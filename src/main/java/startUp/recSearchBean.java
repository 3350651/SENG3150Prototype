package startUp;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedList;


public class recSearchBean implements Serializable
{
    Timestamp departureDate;
    String departureLocation;
    String destinationLocation;
    int flexible;
    int adultPassengers;
    int childPassengers;
    LinkedList<FlightBean> flightResults;
    LinkedList<FlightBean> recommendedFlights;

    public recSearchBean()
    {
        departureDate = null;
        departureLocation = null;
        destinationLocation = null;
        flexible = 0;
        adultPassengers = 0;
        childPassengers = 0;
        flightResults = null;
    }

    public void setFlightResults(LinkedList<FlightBean> results)
    {
        this.flightResults = results;
    }

    public LinkedList<FlightBean> getFlightResults()
    {
        return this.flightResults;
    }

    public void setDepartureDate(Timestamp a)
    {
        this.departureDate = a;
    }

    public Timestamp getDepartureDate()
    {
        return this.departureDate;
    }

    public void setFlexible(int a)
    {
        this.flexible = a;
    }

    public int getFlexible()
    {
        return this.flexible;
    }

    public void setAdultPassengers(int a)
    {
        this.adultPassengers = a;
    }

    public int getAdultPassengers()
    {
        return this.adultPassengers;
    }

    public void setChildPassengers(int a)
    {
        this.childPassengers = a;
    }

    public int getChildPassengers()
    {
        return this.childPassengers;
    }

    public void setDepartureLocation(String b)
    {
        this.departureLocation = b;
    }

    public String getDepartureLocation()
    {
        return this.departureLocation;
    }

    public void setDestinationLocation(String a)
    {
        this.departureLocation = a;
    }

    public String getDestinationLocation()
    {
        return this.destinationLocation;
    }

    public void getpresetFlights()
    {
        flightResults = new LinkedList<>();

        try {
            String query = "SELECT * FROM Flights";

            Connection connection = ConfigBean.getConnection();

            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();

            while (result.next() != false)
            {
                String airCode = result.getString(1);
                String flightNum = result.getString(2);
                System.out.println(flightNum);
                DestinationBean departure = new DestinationBean(result.getString(3));
                DestinationBean stopOver = new DestinationBean(result.getString(4));
                DestinationBean arrival = new DestinationBean(result.getString(5));
                Timestamp leaveTime = result.getTimestamp(6);
                Timestamp arrivalTime = result.getTimestamp(9);
                String planeCode = result.getString(10);
                int duration = result.getInt(11);

                //FlightBean flight = new FlightBean(airCode, flightNum, departure, stopOver, arrival, leaveTime);
                FlightBean flight = new FlightBean(airCode, airCode, leaveTime, flightNum, planeCode, departure, arrival, arrival);

                flightResults.add(flight);
            }

            connection.close();
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //, int flexible, Timestamp date
    public void getResults(String destination, String dep)
    {
        flightResults = new LinkedList<>();

        try {
            DestinationBean depart = new DestinationBean(dep, "");
            DestinationBean dest = new DestinationBean(destination, "");
            String query = "SELECT * FROM Flights WHERE DepartureCode= ? AND DestinationCode= ?;";

            Connection connection = ConfigBean.getConnection();

            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, depart.getDestinationCode());
            statement.setString(2, dest.getDestinationCode());

            ResultSet result = statement.executeQuery();

            while (result.next() != false)
            {
                String airCode = result.getString(1);
                String flightNum = result.getString(2);
                DestinationBean departure = new DestinationBean(result.getString(3));
                DestinationBean stopOver = new DestinationBean(result.getString(4));
                DestinationBean arrival = new DestinationBean(result.getString(5));
                Timestamp leaveTime = result.getTimestamp(6);
                Timestamp arrivalTime = result.getTimestamp(9);
                String planeCode = result.getString(10);
                int duration = result.getInt(11);

                FlightBean flight = new FlightBean(airCode, flightNum, departure, stopOver, arrival, leaveTime);

                flightResults.add(flight);
            }

            connection.close();
            statement.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void getRecommendedFlights(UserBean user) {
        LinkedList<String> userTags = user.getTagSet();

        getAllDestinations des = new getAllDestinations();

        des.execute();

        LinkedList<DestinationBean> destinations = des.getDestinations();

        LinkedList<DestinationBean> acceptedDestinations = new LinkedList<>();

        for (int i = 0; i < destinations.size(); i++) {
            if (destinations.get(i).getTags() != null)
            {
                for (int l = 0; l < userTags.size(); l++) {
                    if (destinations.get(i).getTags().get(l).contains(userTags.get(l))) {
                        acceptedDestinations.add(destinations.get(i));
                        break;
                    }
                }
            }
        }

        recommendedFlights = new LinkedList<>();

        for (int k = 0; k < acceptedDestinations.size(); k++)
        {
            try
            {
                String query = "SELECT * FROM Flights WHERE DestinationCode= ?;";

                Connection connection = ConfigBean.getConnection();

                PreparedStatement statement = connection.prepareStatement(query);

                statement.setString(1, acceptedDestinations.get(k).getDestinationCode());

                ResultSet result = statement.executeQuery();

                while (result.next() != false)
                {
                    String airCode = result.getString(1);
                    String flightNum = result.getString(2);
                    DestinationBean departure = new DestinationBean(result.getString(3));
                    DestinationBean stopOver = new DestinationBean(result.getString(4));
                    DestinationBean arrival = new DestinationBean(result.getString(5));
                    Timestamp leaveTime = result.getTimestamp(6);
                    Timestamp arrivalTime = result.getTimestamp(9);
                    String planeCode = result.getString(10);
                    int duration = result.getInt(11);

                    FlightBean flight = new FlightBean(airCode, flightNum, departure, stopOver, arrival, leaveTime);

                    recommendedFlights.add(flight);
                }

                connection.close();
                statement.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public LinkedList<FlightBean> getRecFlights()
    {
        return this.recommendedFlights;
    }
}
