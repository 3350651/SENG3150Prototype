package startUp;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;
import java.util.concurrent.ThreadLocalRandom;

public class FlightPathBean {
    private Stack<FlightBean> flightPath;
    private LinkedList<String> destinations;
    private int id;
    private float minPrice;

    public FlightPathBean() {
        flightPath = new Stack<>();
        destinations = new LinkedList<>();
        id = ThreadLocalRandom.current().nextInt(10000000, 99999999);
        minPrice = 0;
    }

    public FlightPathBean(Stack<FlightBean> flights) {
        flightPath = flights;
        destinations = new LinkedList<>();
        minPrice = 0;
        for (FlightBean flight : flights) {
            destinations.add(flight.getDeparture().getDestinationCode());
            //minPrice += flight.getMinCost();
        }
        minPrice = BigDecimal.valueOf(minPrice).setScale(2, RoundingMode.HALF_UP).floatValue();
        id = ThreadLocalRandom.current().nextInt(00000000, 99999999);
    }


    public Stack<FlightBean> getFlightPath() {
        return flightPath;
    }

    public void setFlightPath(Stack<FlightBean> flightPath) {
        this.flightPath = flightPath;
    }


    public LinkedList<String> getDestinations() {
        return destinations;
    }

    public void setDestinations(LinkedList<String> destinations) {
        this.destinations = destinations;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(float minPrice) {
        this.minPrice = minPrice;
    }

    public int getFlightPathStopOvers() {
        return this.flightPath.size() - 1;
    }

    public boolean isLoopingDestination(FlightBean flight) {
        if (this.destinations.contains(flight.getDestination().getDestinationCode())) {
            return true;
        } else {
            return false;
        }
    }

    public String getAllDestinations() {
        String allDestinations = "";
        String temp = "";
        for (int i = destinations.size() - 1; i >= 0; i--) {
            temp = destinations.get(i);
            if (i == 0)
                allDestinations += "\'" + temp + "\'";
            else
                allDestinations += "\'" + temp + "\'" + ", ";
        }
        return allDestinations;
    }

    public void addFlightPathToDatabase()
    {
        try {
            String query = "INSERT INTO dbo.FLIGHTPATH (flightPathID, minimumPrice)\n"
                    +
                    "VALUES(?,?);";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, String.valueOf(this.id));
            statement.setString(2, String.valueOf(this.minPrice));
            statement.execute();
            statement.close();
            connection.close();

        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        FlightPathBean entry = new FlightPathBean((Stack<FlightBean>) this.flightPath.clone());

        while (!entry.getFlightPath().isEmpty())
        {
            FlightBean flight = entry.getFlightPath().pop();
            try {
                String query = "INSERT INTO dbo.FLIGHTPATHFLIGHT (flightPathID, AirlineCode, FlightNumber, DepartureTime, Leg)\n"
                        +
                        "VALUES(?,?,?,?,?);";
                Connection connection = ConfigBean.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, String.valueOf(this.id));
                statement.setString(2, flight.getAirline());
                statement.setString(3, flight.getFlightName());
                statement.setString(4, String.valueOf(flight.getOriginalFlightDepartureTime()));
                statement.setString(5, String.valueOf(flight.getLeg()));
                statement.execute();
                statement.close();
                connection.close();

            } catch (SQLException e) {
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
        }
    }

    public Stack<FlightBean> getFlightPathFromDatabase(String flightpathid)
    {
        Stack<FlightBean> flights =  new Stack<>();

        try {
            String query = "SELECT * FROM FLIGHTPATHFLIGHT WHERE flightPathID = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, flightpathid);
            ResultSet results =  statement.executeQuery();


            while (results.next())
            {
                String pathID = results.getString(1);
                String AirlineCode = results.getString(2);
                String FlightNumber = results.getString(3);
                Timestamp time = Timestamp.valueOf(results.getString(4));
                String leg = results.getString(5);

                FlightBean a = new FlightBean(AirlineCode,  FlightNumber, time);
                flights.add(a);
            }
            statement.close();
            connection.close();

        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return flights;
    }

    public FlightBean getInitialFlight() {
        return flightPath.get(flightPath.size() - 1);
    }

    public FlightBean getLastFlight() {
        return flightPath.get(0);
    }
}
