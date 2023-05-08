package startUp;

import java.io.Serializable;
import java.sql.*;

public class FlightBean implements Serializable {

    private String airline;
    private Timestamp flightTime;
    private String flightName;
    private String planeType;
    private float minCost;
    private DestinationBean departure;
    private DestinationBean stopOver;
    private DestinationBean destination;

    // constructor

    public FlightBean(String newAirline, Timestamp newFlightTime, String newflightName, String newPlaneType,
            /* float newMinCost, */ DestinationBean newDeparture, DestinationBean newStopOver,
            DestinationBean newDestination) {
        airline = newAirline;
        flightTime = newFlightTime;
        flightName = newflightName;
        planeType = newPlaneType;
        /* minCost = newMinCost; */
        departure = newDeparture;
        stopOver = newStopOver;
        destination = newDestination;
    }

    // getters and setters
    public String getAirline() {
        return airline;
    }

    public void setAirline(String airline) {
        this.airline = airline;
    }

    public Timestamp getFlightTime() {
        return flightTime;
    }

    public void setFlightTime(Timestamp flightTime) {
        this.flightTime = flightTime;
    }

    public String getFlightName() {
        return flightName;
    }

    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    public String getPlaneType() {
        return planeType;
    }

    public void setPlaneType(String planeType) {
        this.planeType = planeType;
    }

    /*
     * public float getMinCost() {
     * return minCost;
     * }
     * 
     * public void setMinCost(float minCost) {
     * this.minCost = minCost;
     * }
     */

    public DestinationBean getDeparture() {
        return departure;
    }

    public void setDeparture(DestinationBean departure) {
        this.departure = departure;
    }

    public DestinationBean getStopover() {
        return stopOver;
    }

    public void setStopover(DestinationBean stopover) {
        this.stopOver = stopover;
    }

    public DestinationBean getDestination() {
        return destination;
    }

    public void setDestination(DestinationBean destination) {
        this.destination = destination;
    }

    // get flight
    public static FlightBean getFlight(String airlineCode, String flightName, Timestamp flightDepartureTime) {

        int available = 0;
        FlightBean flight = null;

        try {
            String query = "SELECT *" +
                    " FROM dbo.Flights  " +
                    " WHERE [AirlineCode] = ? AND [FlightNumber] = ? AND [DepartureTime] = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, airlineCode);
            statement.setString(2, flightName);
            statement.setString(3, flightDepartureTime.toString());

            ResultSet result = statement.executeQuery();

            // TODO:Possibly won't work?
            // TODO:Retrieve min cost of flight...

            while (result.next()) {
                String aCode = result.getString(1);
                String flightCode = result.getString(2);
                String plane = result.getString(10);
                Timestamp departTime = result.getTimestamp(6);
                String departureCode = result.getString(3);
                String stopOverCode = result.getString(4);
                String destinationCode = result.getString(5);

                DestinationBean rDeparture = new DestinationBean(departureCode);
                DestinationBean rStopOver = new DestinationBean(stopOverCode);
                DestinationBean rDestination = new DestinationBean(destinationCode);

                flight = new FlightBean(aCode, departTime, flightCode, plane, /* mCost, */ rDeparture, rStopOver,
                        rDestination);
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return flight;
    }

    // TODO: get min cost

}
