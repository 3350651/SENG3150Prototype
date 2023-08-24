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
    LinkedList<FlightPathBean> results;
    int searchID;

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
    }

    // empty search bean instantiation
    public SearchBean(){
        departureDate = null;
        destination = null;
        departure = null;
        tags = null;
        simple = true;
        flexible = 0;
        adultPassengers = 0;
        childPassengers = 0;
        results = new LinkedList<>();
    }

    // Search Bean for Saved Searches Instantiation
    public SearchBean(String newDestination, String newDeparture, int newFlexible, int newAdultPassengers, int newChildPassengers, int newSearchID, Timestamp newDepartureDate){
        searchID = newSearchID;
        departureDate = newDepartureDate;
        destination = newDestination;
        departure = newDeparture;
        simple = true;
        flexible = newFlexible;
        adultPassengers = newAdultPassengers;
        childPassengers = newChildPassengers;
    }


    //getters and setters
    public LinkedList<FlightPathBean> getResults() {
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

    public void setResults(LinkedList<FlightPathBean> results) {
        this.results = results;
    }

    public int getSearchID() {
        return searchID;
    }

    public void setSearchID(int searchID) {
        this.searchID = searchID;
    }

    public void searchFlights(int numFlights, int maxStopovers) {
        LinkedList<FlightPathBean> flightPaths = new LinkedList<>();
        Queue<FlightBean> flightList = new LinkedList<>();
        FlightBean flight = null;
        Timestamp start = this.departureDate;
        Timestamp end = Timestamp.from(this.departureDate.toInstant().plus(24, ChronoUnit.HOURS));

        if (!isFlightsTo(destination, departureDate, (this.adultPassengers + this.childPassengers))) {
            results = flightPaths;
            return;
        }

        if (this.flexible > 0) {
            start = Timestamp.from(this.departureDate.toInstant().minus(this.flexible * 24, ChronoUnit.HOURS));
            end = Timestamp.from(this.departureDate.toInstant().plus(this.flexible * 24, ChronoUnit.HOURS));
        }

        do {
            //get all flights leaving within 24 hours of departure
            //add previous flight to each
            //add all to queue
            flightList.addAll(getAllFlightsFrom(departure, start, end, flight, (this.adultPassengers + this.childPassengers)));


            //go to next in queue
            flight = flightList.poll();
            //if queue empty return list of flight paths
            if (flight == null) {
                results = flightPaths;
                return;
            }
            if (getFlightPathFrom(flight).getFlightPath().size() > maxStopovers) {
                System.out.println("Max stopovers");
                break;
            }

            //check if destination
            while (Objects.equals(flight.getDestination().getDestinationCode(), destination)) {
                //if destination, backtrack through previous flights to make complete flight path
                //add to list of complete flight paths
                flightPaths.add(getFlightPathFrom(flight));
                //if 10 flights in list return
                if (flightPaths.size() >= numFlights) {
                    results = flightPaths;
                    return;
                }
                if (flightList.isEmpty()) {
                    results = flightPaths;
                    return;
                }
                flight = flightList.poll();
                if (flight == null) {
                    results = flightPaths;
                    return;
                }

            }
            departure = flight.getDestination().getDestinationCode();
            start = flight.getFlightArrivalTime();
            end = Timestamp.from(start.toInstant().plus(24, ChronoUnit.HOURS));
        } while (flightPaths.size() < numFlights);
        results = flightPaths;
    }

    public Queue<FlightBean> getAllFlightsFrom(String source, Timestamp startTime, Timestamp endTime, FlightBean previous, int passengers) {
        Queue<FlightBean> flights = new LinkedList<>();
        String loopingDestinations = null;
        if (previous != null) {
            loopingDestinations = getFlightPathFrom(previous).getAllDestinations();
        }
        try {
            String query = "SELECT \n" +
                    "    F.AirlineCode, \n" +
                    "    F.FlightNumber, \n" +
                    "    F.DepartureCode, \n" +
                    "    F.DestinationCode, \n" +
                    "    F.DepartureTime, \n" +
                    "    F.ArrivalTime, \n" +
                    "    F.PlaneCode, \n" +
                    "    A.AirlineName, \n" +
                    "    0 AS leg, \n" +
                    "    F.DepartureTime AS originalDepartureTime \n" +
                    "    FROM Flights F \n" +
                    "    LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode \n" +
                    "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                    "    WHERE StopOverCode IS NULL AND F.DepartureTime <= ? AND F.DepartureTime >= ? AND F.DepartureCode = ? \n" +
                    "    AND AV.NumberAvailableSeatsLeg1 >= ?\n" +
                    "    UNION \n" +
                    "    SELECT \n" +
                    "    F.AirlineCode, \n" +
                    "    F.FlightNumber, \n" +
                    "    F.DepartureCode, \n" +
                    "    F.StopOverCode AS DestinationCode, \n" +
                    "    F.DepartureTime, \n" +
                    "    F.ArrivalTimeStopOver AS ArrivalTime, \n" +
                    "    F.PlaneCode, \n" +
                    "    A.AirlineName, \n" +
                    "    1 AS leg, \n" +
                    "    F.DepartureTime AS originalDepartureTime \n" +
                    "    FROM Flights F \n" +
                    "    LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode \n" +
                    "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                    "    WHERE StopOverCode IS NOT NULL AND F.DepartureTime <= ? AND F.DepartureTime >= ? AND F.DepartureCode = ? \n" +
                    "        AND AV.NumberAvailableSeatsLeg1 >= ?\n" +
                    "    UNION \n" +
                    "    SELECT \n" +
                    "    F.AirlineCode, \n" +
                    "    F.FlightNumber, \n" +
                    "    F.StopOverCode AS DepartureCode, \n" +
                    "    F.DestinationCode, \n" +
                    "    F.DepartureTimeStopOver AS DepartureTime, \n" +
                    "    F.ArrivalTime, \n" +
                    "    F.PlaneCode, \n" +
                    "    A.AirlineName, \n" +
                    "    2 AS leg, \n" +
                    "    F.DepartureTime AS originalDepartureTime \n" +
                    "    FROM Flights F \n" +
                    "    LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode \n" +
                    "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                    "    WHERE StopOverCode IS NOT NULL AND F.DepartureTimeStopOver <= ? AND F.DepartureTimeStopOver >= ? AND F.StopOverCode = ? \n" +
                    "        AND AV.NumberAvailableSeatsLeg2 >= ?;";

            if (loopingDestinations != null) {
                query = "SELECT " +
                        "F.AirlineCode, " +
                        "F.FlightNumber, " +
                        "F.DepartureCode, " +
                        "F.DestinationCode, " +
                        "F.DepartureTime, " +
                        "F.ArrivalTime, " +
                        "F.PlaneCode, " +
                        "A.AirlineName, " +
                        "0 AS leg, " +
                        "F.DepartureTime AS originalDepartureTime " +
                        "FROM Flights F " +
                        "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode " +
                        "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                        "WHERE StopOverCode IS NULL AND F.DepartureTime <= ? AND F.DepartureTime >= ? AND F.DepartureCode = ? AND F.DestinationCode NOT IN (" + loopingDestinations + ") " +
                        "    AND AV.NumberAvailableSeatsLeg1 >= ?\n" +
                        "UNION " +
                        "SELECT " +
                        "F.AirlineCode, " +
                        "F.FlightNumber, " +
                        "F.DepartureCode, " +
                        "F.StopOverCode AS DestinationCode, " +
                        "F.DepartureTime, " +
                        "F.ArrivalTimeStopOver AS ArrivalTime, " +
                        "F.PlaneCode, " +
                        "A.AirlineName, " +
                        "1 AS leg, " +
                        "F.DepartureTime AS originalDepartureTime " +
                        "FROM Flights F " +
                        "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode " +
                        "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                        "WHERE StopOverCode IS NOT NULL AND F.DepartureTime <= ? AND F.DepartureTime >= ? AND F.DepartureCode = ? AND F.StopOverCode NOT IN (" + loopingDestinations + ") " +
                        "    AND AV.NumberAvailableSeatsLeg1 >= ?\n" +
                        "UNION " +
                        "SELECT " +
                        "F.AirlineCode, " +
                        "F.FlightNumber, " +
                        "F.StopOverCode AS DepartureCode, " +
                        "F.DestinationCode, " +
                        "F.DepartureTimeStopOver AS DepartureTime, " +
                        "F.ArrivalTime, " +
                        "F.PlaneCode, " +
                        "A.AirlineName, " +
                        "2 AS leg, " +
                        "F.DepartureTime AS originalDepartureTime " +
                        "FROM Flights F " +
                        "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode " +
                        "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                        "WHERE StopOverCode IS NOT NULL AND F.DepartureTimeStopOver <= ? AND F.DepartureTimeStopOver >= ? AND F.StopOverCode = ? AND F.DestinationCode NOT IN (" + loopingDestinations + ") " +
                        "    AND AV.NumberAvailableSeatsLeg2 >= ?\n";
            }

            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setTimestamp(1, endTime);
            statement.setTimestamp(2, startTime);
            statement.setString(3, source);
            statement.setInt(4, passengers);
            statement.setTimestamp(5, endTime);
            statement.setTimestamp(6, startTime);
            statement.setString(7, source);
            statement.setInt(8, passengers);
            statement.setTimestamp(9, endTime);
            statement.setTimestamp(10, startTime);
            statement.setString(11, source);
            statement.setInt(12, passengers);


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
                int leg = result.getInt(9);
                String test = result.getString(10);
                Timestamp originalDepartTime = result.getTimestamp(10);

                DestinationBean rDeparture = new DestinationBean(departureCode);
                DestinationBean rDestination = new DestinationBean(destinationCode);
                FlightBean temp = new FlightBean(aCode, airlineName, departTime, arrivalTime, flightCode, plane, /* mCost, */ rDeparture,
                        rDestination, previous, leg, originalDepartTime);
                flights.add(temp);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }
        for (FlightBean flight : flights) {
            flight.loadDestinationBeans();
            flight.getAvailabilities(passengers);
        }
        return flights;
    }

    public FlightPathBean getFlightPathFrom(FlightBean destinationFlight) {
        FlightBean temp = destinationFlight;
        Stack<FlightBean> flights = new Stack<>();
        while (temp != null) {
            flights.add(temp);
            temp = temp.getPreviousFlight();
        }
        return new FlightPathBean(flights);
    }

    public boolean isFlightsTo(String destination, Timestamp time, int passengers) {

        LinkedList<FlightBean> flights = new LinkedList<>();

        String query = "SELECT\n" +
                "F.AirlineCode,\n" +
                "F.FlightNumber,\n" +
                "F.DepartureCode,\n" +
                "F.DestinationCode,\n" +
                "F.DepartureTime,\n" +
                "F.ArrivalTime,\n" +
                "F.PlaneCode,\n" +
                "A.AirlineName,\n" +
                "0 AS leg,\n" +
                "F.DepartureTime AS originalDepartureTime\n" +
                "FROM Flights F\n" +
                "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode\n" +
                "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                "WHERE StopOverCode IS NULL AND F.DepartureTime > ? AND F.DestinationCode = ? \n" +
                "    AND AV.NumberAvailableSeatsLeg1 >= ?\n" +
                "UNION \n" +
                "SELECT \n" +
                "F.AirlineCode, \n" +
                "F.FlightNumber,\n" +
                "F.DepartureCode, \n" +
                "F.StopOverCode AS DestinationCode, \n" +
                "F.DepartureTime, \n" +
                "F.ArrivalTimeStopOver AS ArrivalTime, \n" +
                "F.PlaneCode, \n" +
                "A.AirlineName, \n" +
                "1 AS leg, \n" +
                "F.DepartureTime AS originalDepartureTime \n" +
                "FROM Flights F \n" +
                "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode \n" +
                "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                "WHERE StopOverCode IS NOT NULL AND F.DepartureTime > ? AND F.StopOverCode = ?\n" +
                "    AND AV.NumberAvailableSeatsLeg1 >= ?\n" +
                "UNION \n" +
                "SELECT \n" +
                "F.AirlineCode, \n" +
                "F.FlightNumber, \n" +
                "F.StopOverCode AS DepartureCode, \n" +
                "F.DestinationCode, \n" +
                "F.DepartureTimeStopOver AS DepartureTime, \n" +
                "F.ArrivalTime, \n" +
                "F.PlaneCode, \n" +
                "A.AirlineName, \n" +
                "2 AS leg, \n" +
                "F.DepartureTime AS originalDepartureTime \n" +
                "FROM Flights F \n" +
                "LEFT JOIN Dbo.Airlines a ON A.AirlineCode = F.AirlineCode \n" +
                "    LEFT JOIN dbo.Availability AV ON AV.AirlineCode = F.AirlineCode AND AV.DepartureTime = F.DepartureTime AND AV.FlightNumber = F.FlightNumber\n" +
                "WHERE StopOverCode IS NOT NULL AND F.DepartureTimeStopOver > ? AND F.DestinationCode = ?" +
                "    AND AV.NumberAvailableSeatsLeg2 >= ?\n";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setTimestamp(1, time);
            statement.setString(2, destination);
            statement.setInt(3, passengers);
            statement.setTimestamp(4, time);
            statement.setString(5, destination);
            statement.setInt(6, passengers);
            statement.setTimestamp(7, time);
            statement.setString(8, destination);
            statement.setInt(9, passengers);

            ResultSet result = statement.executeQuery();

            while (result.next() && flights.size() == 0) {
                String aCode = result.getString(1);
                String flightCode = result.getString(2);
                String departureCode = result.getString(3);
                String destinationCode = result.getString(4);
                Timestamp departTime = result.getTimestamp(5);
                Timestamp arrivalTime = result.getTimestamp(6);
                String plane = result.getString(7);
                String airlineName = result.getString(8);
                int leg = result.getInt(9);
                Timestamp originalDepartTime = result.getTimestamp(10);

                DestinationBean rDeparture = new DestinationBean(departureCode);
                DestinationBean rDestination = new DestinationBean(destinationCode);
                FlightBean temp = new FlightBean(aCode, airlineName, departTime, arrivalTime, flightCode, plane, /* mCost, */ rDeparture,
                        rDestination, null, leg, originalDepartTime);
                flights.add(temp);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }

        return flights.size() > 0;
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
