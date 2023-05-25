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

    //, int flexible, Timestamp date
    public void getResults(String destination, String dep)
    {
        flightResults = new LinkedList<>();
        String query = "SELECT * FROM Flights WHERE DepartureCode='" + dep + "' AND DestinationCode= '" + destination + "';";
        try(Connection connection = ConfigBean.getConnection(); //step 1
            Statement statement = connection.createStatement(); //step 2
            ResultSet result = statement.executeQuery(query);) { //step 3 and 4
            while (result.next())
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
            statement.close();
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
