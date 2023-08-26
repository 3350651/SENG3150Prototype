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
            minPrice += flight.getMinCost();
        }
        id = ThreadLocalRandom.current().nextInt(10000000, 99999999);
        minPrice = BigDecimal.valueOf(minPrice).setScale(2, RoundingMode.HALF_UP).floatValue();
    }

    public FlightPathBean(Stack<FlightBean> flights, boolean check) {
        flightPath = flights;
        destinations = new LinkedList<>();
        minPrice = 0;
        for (FlightBean flight : flights) {
            destinations.add(flight.getDeparture().getDestinationCode());
            minPrice += flight.getMinCost();
        }
        id = ThreadLocalRandom.current().nextInt(10000000, 99999999);
        minPrice = BigDecimal.valueOf(minPrice).setScale(2, RoundingMode.HALF_UP).floatValue();
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

    public void addFlightPathToDatabase() {
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

        while (!entry.getFlightPath().isEmpty()) {
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

    public static FlightPathBean getFlightPath(String flightPathID) {
        FlightPathBean flightPathBean = null;
        String query = "\n" +
                "SELECT F.AirlineCode,\n" +
                "A.AirlineName,\n" +
                "F.ArrivalTime,\n" +
                "F.ArrivalTimeStopOver,\n" +
                "F.DepartureCode,\n" +
                "F.DepartureTime,\n" +
                "F.DepartureTimeStopOver,\n" +
                "F.DestinationCode,\n" +
                "F.FlightNumber,\n" +
                "F.PlaneCode,\n" +
                "F.StopOverCode,\n" +
                "FPF.Leg\n" +
                "FROM FLIGHTPATH FP\n" +
                "LEFT JOIN FLIGHTPATHFLIGHT FPF ON FP.flightPathID = FPF.flightPathID\n" +
                "LEFT JOIN Flights F ON  F.AirlineCode = FPF.AirlineCode AND F.FlightNumber = FPF.FlightNumber AND F.DepartureTime = FPF.DepartureTime\n" +
                "LEFT JOIN Airlines A ON A.AirlineCode = F.AirlineCode\n" +
                "WHERE FP.flightPathID = ?";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, flightPathID);

            ResultSet result = statement.executeQuery();

            Stack<FlightBean> stack = new Stack<>();

            while (result.next()) {
                String airlineCode = result.getString("AirlineCode");
                String airlineName = result.getString("AirlineName");
                Timestamp originalDepartureTime = result.getTimestamp("DepartureTime");
                String flightNumber = result.getString("FlightNumber");
                int leg = result.getInt("Leg");
                String planeCode = result.getString("PlaneCode");
                Timestamp departureTime = null;
                String destCode = "";
                String departCode = "";
                Timestamp arrivalTime = null;

                switch (leg) {
                    case (0): {
                        departureTime = result.getTimestamp("DepartureTime");
                        arrivalTime = result.getTimestamp("ArrivalTime");
                        departCode = result.getString("DepartureCode");
                        destCode = result.getString("DestinationCode");
                        break;
                    }
                    case (1): {
                        departureTime = result.getTimestamp("DepartureTime");
                        arrivalTime = result.getTimestamp("ArrivalTimeStopOver");
                        departCode = result.getString("DepartureCode");
                        destCode = result.getString("StopOverCode");
                        break;
                    }
                    case (2): {
                        departureTime = result.getTimestamp("ArrivalTimeStopOver");
                        arrivalTime = result.getTimestamp("ArrivalTime");
                        departCode = result.getString("StopOverCode");
                        destCode = result.getString("DestinationCode");
                        break;
                    }
                }

                FlightBean flightBean = new FlightBean(airlineCode, airlineName, departureTime, arrivalTime, flightNumber, planeCode,
                        new DestinationBean(departCode), new DestinationBean(destCode), null, leg, originalDepartureTime);
                flightBean.loadDestinationBeans();
                flightBean.getAvailabilities(1);
                stack.add(flightBean);
            }

            statement.close();
            connection.close();

            flightPathBean = new FlightPathBean(stack, true);
        } catch (Exception e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return flightPathBean;
    }

    public FlightBean getInitialFlight() {
        return flightPath.get(flightPath.size() - 1);
    }

    public FlightBean getLastFlight() {
        return flightPath.get(0);
    }
}
