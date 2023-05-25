package startUp;

import java.io.Serializable;
import java.sql.*;
import java.util.Arrays;
import java.util.LinkedList;

public class FlightBean implements Serializable {

    private String airline;
    private String airlineName;
    private Timestamp flightTime;
    private String flightName;
    private String planeType;
    private float minCost;
    private DestinationBean departure;
    private DestinationBean stopOver;
    private DestinationBean destination;
    private LinkedList<AvailabilityBean> seatAvailability;

    // constructor

    public FlightBean(String newAirline, String newAirlineName, Timestamp newFlightTime, String newflightName,
            String newPlaneType,
            /* float newMinCost, */ DestinationBean newDeparture, DestinationBean newStopOver,
            DestinationBean newDestination) {
        airline = newAirline;
        airlineName = newAirlineName;
        flightTime = newFlightTime;
        flightName = newflightName;
        planeType = newPlaneType;
        /* minCost = newMinCost; */
        departure = newDeparture;
        stopOver = newStopOver;
        destination = newDestination;
        seatAvailability = new LinkedList<>();
    }

    // FlightBean constructor with primary key elements of Flights table
    public FlightBean(String airline, String flightName, Timestamp flightTime){
        this.airline = airline;
        this.flightName = flightName;
        this.flightTime = flightTime;
        FlightBean infoToImport = getFlight(airline, flightName, flightTime);
        this.airlineName = infoToImport.getAirlineName();
        this.planeType = infoToImport.getPlaneType();
        this.destination = infoToImport.getDestination();
        this.departure = infoToImport.getDeparture();
        this.stopOver = infoToImport.getStopOver();
    }

//    public FlightBean(String airline, String flightName, String departureCode, String stopOverCode, Timestamp flightTime){
//        this.airline = airline;
//        this.flightName = flightName;
//        this.departure = new DestinationBean(departureCode);
//        this.stopOver = new DestinationBean(stopOverCode);
//        this.flightTime = flightTime;
//    }

    // getters and setters
    public String getAirline() {
        return airline;
    }

    public void setAirline(String airline) {
        this.airline = airline;
    }

    public String getAirlineName() {
        return airlineName;
    }

    public void setAirlineName(String airlineName) {
        this.airlineName = airlineName;
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

    public DestinationBean getDestination() {
        return destination;
    }

    public void setDestination(DestinationBean destination) {
        this.destination = destination;
    }

    public float getMinCost() {
        return minCost;
    }

    public void setMinCost(float minCost) {
        this.minCost = minCost;
    }

    public DestinationBean getStopOver() {
        return stopOver;
    }

    public void setStopOver(DestinationBean stopOver) {
        this.stopOver = stopOver;
    }

    public LinkedList<AvailabilityBean> getSeatAvailability() {
        return seatAvailability;
    }

    public void setSeatAvailability(LinkedList<AvailabilityBean> seatAvailability) {
        this.seatAvailability = seatAvailability;
    }

    // get flight
    public static FlightBean getFlight(String airlineCode, String flightName, Timestamp flightDepartureTime) {

        int available = 0;
        FlightBean flight = null;

        try {
            String query = "SELECT f.*," +
                    "a.AirlineName" +
                    " FROM dbo.Flights f " +
                    "LEFT JOIN Dbo.Airlines a ON a.AirlineCode = f.AirlineCode" +
                    " WHERE f.[AirlineCode] = ? AND f.[FlightNumber] = ? AND f.[DepartureTime] = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, airlineCode);
            statement.setString(2, flightName);
            statement.setTimestamp(3, flightDepartureTime);

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

                flight = new FlightBean(aCode, airlineName, departTime, flightCode, plane, /* mCost, */ rDeparture,
                        rStopOver,
                        rDestination);
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }
        return flight;
    }

    // TODO: get min cost

    public void getAvailabilities(){
        seatAvailability = AvailabilityBean.getAvailability(this.airline, this.flightName, this.flightTime);
    }



}
