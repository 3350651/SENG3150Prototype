/**
 * FILE NAME: SearchBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for Searches made
 */

package startUp;

import sun.security.krb5.internal.crypto.Des;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.temporal.ChronoUnit;
import java.util.*;

public class SearchBean implements Serializable {

    Timestamp departureDate;
    String destination;
    String departure;
    LinkedList<TagBean> tags;
    boolean simple;
    int flexible;
    int adultPassengers;
    int childPassengers;
    LinkedList<FlightBean> results;
    //TODO: may need more for completed recommendation search

    //constructors
    public SearchBean(Timestamp newDepartureDate, String newDestination, String newDeparture, LinkedList<TagBean> newTags, boolean newSimple, int newflexible, int newAdults, int newChildren) {
        departureDate = newDepartureDate;
        destination = newDestination;
        departure = newDeparture;
        tags = newTags;
        simple = newSimple;
        flexible = newflexible;
        adultPassengers = newAdults;
        childPassengers = newChildren;
        results = new LinkedList<>();
        //TODO: get rid of this for full implementation
        DestinationBean source = new DestinationBean("LAX");
        DestinationBean destination = new DestinationBean("YYZ");
        Timestamp time = Timestamp.valueOf("2016-01-02 11:55:00.000");
        LinkedList<FlightPathBean> flights = searchFlights(source, destination, time);
    }

    //getters and setters
    public LinkedList<FlightBean> getResults() {
        return this.results;
    }

    public Timestamp getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(Timestamp departureDate) {
        this.departureDate = departureDate;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

    public LinkedList<TagBean> getTags() {
        return tags;
    }

    public void setTags(LinkedList<TagBean> tags) {
        this.tags = tags;
    }

    public boolean isSimple() {
        return simple;
    }

    public void setSimple(boolean simple) {
        this.simple = simple;
    }

    public int getFlexible() {
        return flexible;
    }

    public void setFlexible(int flexible) {
        this.flexible = flexible;
    }

    public int getAdultPassengers() {
        return adultPassengers;
    }

    public void setAdultPassengers(int adultPassengers) {
        this.adultPassengers = adultPassengers;
    }

    public int getChildPassengers() {
        return childPassengers;
    }

    public void setChildPassengers(int childPassengers) {
        this.childPassengers = childPassengers;
    }

    public void setResults(LinkedList<FlightBean> results) {
        this.results = results;
    }

    //gets all flights from the database. Only used for examples for prototype
    public void getAllFlights() {
        try {
            String query = "SELECT f.*," +
                    "a.AirlineName" +
                    " FROM dbo.Flights f " +
                    "LEFT JOIN Dbo.Airlines a ON a.AirlineCode = f.AirlineCode";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();

            // TODO:Retrieve min cost of flight...

            while (result.next()) {
                String aCode = result.getString(1);
                String flightCode = result.getString(2);
                String plane = result.getString(10);
                Timestamp departTime = result.getTimestamp(6);
                String departureCode = result.getString(3);
                String stopOverCode = result.getString(4);
                String destinationCode = result.getString(5);
                String airlineName = result.getString(13);

                DestinationBean rDeparture = new DestinationBean(departureCode);
                DestinationBean rStopOver = new DestinationBean(stopOverCode);
                DestinationBean rDestination = new DestinationBean(destinationCode);

                results.add(new FlightBean(aCode, airlineName, departTime, flightCode, plane, /* mCost, */ rDeparture,
                        rStopOver,
                        rDestination));
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }
    }

    public LinkedList<FlightPathBean> searchFlights(DestinationBean source, DestinationBean destination, Timestamp departure) {
        LinkedList<FlightPathBean> flightPaths = new LinkedList<>();
        Queue<FlightBean> flightList = new LinkedList<>();
        FlightBean flight = null;

        do {

            //get all flights leaving within 24 hours of departure
            //add previous flight to each
            //add all to queue
            flightList.addAll(getAllFlightsFrom(source, departure, flight));

            //if queue empty return list of flight paths
            if (flightList.isEmpty()) {
                break;
            }
            //go to next in queue
            flight = flightList.poll();


            //check if destination
            if (Objects.equals(flight.getDestination().getDestinationCode(), destination.getDestinationCode())) {
                //if destination, backtrack through previous flights to make complete flight path
                //add to list of complete flight paths
                flightPaths.add(getFlightPathFrom(flight));
                //if 10 flights in list return
            }
        } while (flightPaths.size() < 10 || !flightList.isEmpty());
        return flightPaths;
    }

    public Queue<FlightBean> getAllFlightsFrom(DestinationBean source, Timestamp time, FlightBean previous) {
        Queue<FlightBean> flights = new LinkedList<>();
        Timestamp endtime = Timestamp.from(time.toInstant().plus(24, ChronoUnit.HOURS));
        try {
            String query = "SELECT " +
                    "F.AirlineCode, " +
                    "F.FlightNumber, " +
                    "F.DepartureCode, " +
                    "F.DestinationCode, " +
                    "F.DepartureTime, " +
                    "F.ArrivalTime, " +
                    "F.PlaneCode, " +
                    "A.AirlineName " +
                    "FROM Flights F " +
                    "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode " +
                    "WHERE StopOverCode IS NULL AND F.DepartureTime <= ? AND F.DepartureTime >= ? AND F.DepartureCode = ? " +
                    "UNION " +
                    "SELECT " +
                    "F.AirlineCode, " +
                    "F.FlightNumber, " +
                    "F.DepartureCode, " +
                    "F.StopOverCode AS DestinationCode, " +
                    "F.DepartureTime, " +
                    "F.ArrivalTimeStopOver AS ArrivalTime, " +
                    "F.PlaneCode, " +
                    "A.AirlineName " +
                    "FROM Flights F " +
                    "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode " +
                    "WHERE StopOverCode IS NOT NULL AND F.DepartureTime <= ? AND F.DepartureTime >= ? AND F.DepartureCode = ? " +
                    "UNION " +
                    "SELECT " +
                    "F.AirlineCode, " +
                    "F.FlightNumber, " +
                    "F.StopOverCode AS DepartureCode, " +
                    "F.DestinationCode, " +
                    "F.DepartureTimeStopOver AS DepartureTime, " +
                    "F.ArrivalTime, " +
                    "F.PlaneCode, " +
                    "A.AirlineName " +
                    "FROM Flights F " +
                    "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode " +
                    "WHERE StopOverCode IS NOT NULL AND F.DepartureTimeStopOver <= ? AND F.DepartureTimeStopOver >= ? AND F.StopOverCode = ? ";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setTimestamp(1, endtime);
            statement.setTimestamp(2, time);
            statement.setString(3, source.getDestinationCode());
            statement.setTimestamp(4, endtime);
            statement.setTimestamp(5, time);
            statement.setString(6, source.getDestinationCode());
            statement.setTimestamp(7, endtime);
            statement.setTimestamp(8, time);
            statement.setString(9, source.getDestinationCode());


            ResultSet result = statement.executeQuery();

            // TODO:Retrieve min cost of flight...

            while (result.next()) {
                String aCode = result.getString(1);
                String flightCode = result.getString(2);
                String departureCode = result.getString(3);
                String destinationCode = result.getString(4);
                Timestamp departTime = result.getTimestamp(5);
                Timestamp arrivalTime = result.getTimestamp(6);
                String plane = result.getString(7);
                String airlineName = result.getString(8);

                DestinationBean rDeparture = new DestinationBean(departureCode);
                DestinationBean rDestination = new DestinationBean(destinationCode);

                flights.add(new FlightBean(aCode, airlineName, departTime, arrivalTime, flightCode, plane, /* mCost, */ rDeparture,
                        rDestination, previous));
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }

        return flights;
    }

    public FlightPathBean getFlightPathFrom(FlightBean destinationFlight) {
        FlightBean temp = destinationFlight;
        FlightPathBean flightPath = new FlightPathBean();
        while (temp != null) {
            flightPath.addToFlightPath(temp);
            temp = temp.getPreviousFlight();
        }

        return flightPath;
    }


//this all may be useful for later when we start implementing properly...

    // public void getRecommendedFlights(UserBean user) {
    //     LinkedList<String> userTags = user.getTagSet();

    //     //getAllDestinations des = new getAllDestinations();

    //     //des.execute();

    //     //LinkedList<DestinationBean> destinations = des.getDestinations();
    //     LinkedList<DestinationBean> destinations = new LinkedList<>();

    //     LinkedList<DestinationBean> acceptedDestinations = new LinkedList<>();

    //     for (int i = 0; i < destinations.size(); i++) {
    //         if (destinations.get(i).getTags() != null)
    //         {
    //             for (int l = 0; l < userTags.size(); l++) {
    //                 if (destinations.get(i).getTags().get(l).contains(userTags.get(l))) {
    //                     acceptedDestinations.add(destinations.get(i));
    //                     break;
    //                 }
    //             }
    //         }
    //     }

    //     recommendedFlights = new LinkedList<>();

    //     for (int k = 0; k < acceptedDestinations.size(); k++)
    //     {
    //         try
    //         {
    //             String query = "SELECT * FROM Flights WHERE DestinationCode= ?;";

    //             Connection connection = ConfigBean.getConnection();

    //             PreparedStatement statement = connection.prepareStatement(query);

    //             statement.setString(1, acceptedDestinations.get(k).getDestinationCode());

    //             ResultSet result = statement.executeQuery();

    //             while (result.next() != false)
    //             {
    //                 String airCode = result.getString(1);
    //                 String flightNum = result.getString(2);
    //                 DestinationBean departure = new DestinationBean(result.getString(3));
    //                 DestinationBean stopOver = new DestinationBean(result.getString(4));
    //                 DestinationBean arrival = new DestinationBean(result.getString(5));
    //                 Timestamp leaveTime = result.getTimestamp(6);
    //                 Timestamp arrivalTime = result.getTimestamp(9);
    //                 String planeCode = result.getString(10);
    //                 int duration = result.getInt(11);

    //                 FlightBean flight = new FlightBean(airCode, flightNum, departure, stopOver, arrival, leaveTime);

    //                 recommendedFlights.add(flight);
    //             }

    //             connection.close();
    //             statement.close();
    //         } catch (SQLException e) {
    //             throw new RuntimeException(e);
    //         }
    //     }
    // }

    // public void getResults(String destination, String dep)
    // {
    //     flightResults = new LinkedList<>();

    //     try {
    //         DestinationBean depart = new DestinationBean(dep, "");
    //         DestinationBean dest = new DestinationBean(destination, "");
    //         String query = "SELECT * FROM Flights WHERE DepartureCode= ? AND DestinationCode= ?;";

    //         Connection connection = ConfigBean.getConnection();

    //         PreparedStatement statement = connection.prepareStatement(query);

    //         statement.setString(1, depart.getDestinationCode());
    //         statement.setString(2, dest.getDestinationCode());

    //         ResultSet result = statement.executeQuery();

    //         while (result.next() != false)
    //         {
    //             String airCode = result.getString(1);
    //             String flightNum = result.getString(2);
    //             DestinationBean departure = new DestinationBean(result.getString(3));
    //             DestinationBean stopOver = new DestinationBean(result.getString(4));
    //             DestinationBean arrival = new DestinationBean(result.getString(5));
    //             Timestamp leaveTime = result.getTimestamp(6);
    //             Timestamp arrivalTime = result.getTimestamp(9);
    //             String planeCode = result.getString(10);
    //             int duration = result.getInt(11);

    //             FlightBean flight = new FlightBean(airCode, flightNum, departure, stopOver, arrival, leaveTime);

    //             flightResults.add(flight);
    //         }

    //         connection.close();
    //         statement.close();
    //     } catch (SQLException e) {
    //         throw new RuntimeException(e);
    //     }
    // }


}
