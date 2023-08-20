/**
 * FILE NAME: FlightBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for holding the information about a flight.
 */

package startUp;

import java.io.Serializable;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.LinkedList;

public class FlightBean implements Serializable {

    private String airline;
    private String airlineName;
    private Timestamp flightDepartureTime;
    private Timestamp flightArrivalTime;
    private Timestamp originalFlightDepartureTime;
    private String flightName;
    private String planeType;
    private float minCost;
    private DestinationBean departure;
    private DestinationBean destination;
    private LinkedList<AvailabilityBean> seatAvailability;
    private FlightBean previousFlight;
    private int leg;

    private float selectedPrice;

    // constructor

    public FlightBean(String newAirline, String newAirlineName, Timestamp newFlightTime, String newflightName,
                      String newPlaneType,
            /* float newMinCost, */ DestinationBean newDeparture, DestinationBean newDestination) {
        airline = newAirline;
        airlineName = newAirlineName;
        flightDepartureTime = newFlightTime;
        flightName = newflightName;
        planeType = newPlaneType;
        /* minCost = newMinCost; */
        departure = newDeparture;
        destination = newDestination;
        seatAvailability = new LinkedList<>();
    }

    public FlightBean(String newAirline, String newAirlineName, Timestamp newFlightTime, String newflightName,
                      String newPlaneType,
            float newMinCost, DestinationBean newDeparture, DestinationBean newDestination) {
        airline = newAirline;
        airlineName = newAirlineName;
        flightDepartureTime = newFlightTime;
        flightName = newflightName;
        planeType = newPlaneType;
        minCost = newMinCost;
        departure = newDeparture;
        destination = newDestination;
        seatAvailability = new LinkedList<>();
    }

    /**
     * Used in the search algorithm
     */
    public FlightBean(String newAirline, String newAirlineName, Timestamp newFlightDepartureTime, Timestamp newFlightArrivalTime, String newflightName,
                      String newPlaneType, /* float newMinCost, */ DestinationBean newDeparture,
                      DestinationBean newDestination, FlightBean newPreviousFlight, int newLeg, Timestamp newOriginalFlightTime) {
        airline = newAirline;
        airlineName = newAirlineName;
        flightDepartureTime = newFlightDepartureTime;
        flightArrivalTime = newFlightArrivalTime;
        flightName = newflightName;
        planeType = newPlaneType;
        /* minCost = newMinCost; */
        departure = newDeparture;
        destination = newDestination;
        seatAvailability = new LinkedList<>();
        previousFlight = newPreviousFlight;
        leg = newLeg;
        originalFlightDepartureTime = newOriginalFlightTime;
    }

    public FlightBean(String aline, String fname, DestinationBean dep, DestinationBean arr, Timestamp ftime) {
        airline = aline;
        flightName = fname;
        departure = dep;
        destination = arr;
        flightDepartureTime = ftime;
    }

    // FlightBean constructor with primary key elements of Flights table
    public FlightBean(String airline, String flightName, Timestamp flightTime) {
        this.airline = airline;
        this.flightName = flightName;
        this.flightDepartureTime = flightTime;
        FlightBean infoToImport = getFlight(airline, flightName, flightTime);
        this.airlineName = infoToImport.getAirlineName();
        this.planeType = infoToImport.getPlaneType();
        this.destination = infoToImport.getDestination();
        this.departure = infoToImport.getDeparture();
    }

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
        return flightDepartureTime;
    }

    public void setFlightTime(Timestamp flightTime) {
        this.flightDepartureTime = flightTime;
    }

    public Timestamp getFlightArrivalTime() {
        return flightArrivalTime;
    }

    public void setFlightArrivalTime(Timestamp flightArrivalTime) {
        this.flightArrivalTime = flightArrivalTime;
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
        return seatAvailability.get(0).getPrice();
    }

    public void setMinCost(float minCost) {
        this.minCost = minCost;
    }

    public LinkedList<AvailabilityBean> getSeatAvailability() {
        return seatAvailability;
    }

    public void setSeatAvailability(LinkedList<AvailabilityBean> seatAvailability) {
        this.seatAvailability = seatAvailability;
    }

    public FlightBean getPreviousFlight() {
        return previousFlight;
    }

    public void setPreviousFlight(FlightBean previousFlight) {
        this.previousFlight = previousFlight;
    }

    public Timestamp getOriginalFlightDepartureTime() {
        return originalFlightDepartureTime;
    }

    public void setOriginalFlightDepartureTime(Timestamp originalFlightDepartureTime) {
        this.originalFlightDepartureTime = originalFlightDepartureTime;
    }

    public int getLeg() {
        return leg;
    }

    public void setLeg(int leg) {
        this.leg = leg;
    }

    public float getSelectedPrice() { return selectedPrice; }

    public  void setSelectedPrice(float selectedPrice) { this.selectedPrice = selectedPrice; }

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
                String destinationCode = result.getString(5);
                String airlineName = result.getString(13);

                DestinationBean rDeparture = new DestinationBean(departureCode);
                DestinationBean rDestination = new DestinationBean(destinationCode);

                flight = new FlightBean(aCode, airlineName, departTime, flightCode, plane, /* mCost, */ rDeparture, rDestination);
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }
        return flight;
    }

    // used to display the custom format of dates in flight details page
    public String getMonthName(Timestamp stamp) {
        int monthValue = stamp.toLocalDateTime().getMonthValue();
        String month = "";

        switch (monthValue) {
            case 1 : month = "January";
                break;
            case 2 : month = "February";
                break;
            case 3 : month = "March";
                break;
            case 4 : month = "April";
                break;
            case 5 : month = "May";
                break;
            case 6 : month = "June";
                break;
            case 7 : month = "July";
                break;
            case 8 : month = "August";
                break;
            case 9 : month = "September";
                break;
            case 10 : month = "October";
                break;
            case 11 : month = "November";
                break;
            case 12 : month = "December";
                break;
        }

        return month;
    }

    // used to display the custom format of time in flight details page
    public String getCivilianTime(Timestamp stamp) {
        int hour = stamp.toLocalDateTime().getHour();
        int minute = stamp.toLocalDateTime().getMinute();
        String suffix = "";
        String zeroMinute = "00";

        if (hour < 12) {
            suffix = "am";
        }
        else suffix = "pm";

        return hour % 12 + ":" + (minute == 0 ? zeroMinute : minute)  + " " + suffix;
    }

    // This will be used as the first value of the return date input field, which is tomorrow's date of the arrival to the final destination
    public String getTomorrow() {
        LocalDateTime arrival = getFlightArrivalTime().toLocalDateTime();
        LocalDateTime tomorrow = arrival.plus(1, ChronoUnit.DAYS);

        String year = String.valueOf(tomorrow.getYear());
        String month = tomorrow.getMonthValue() > 10 ? String.valueOf(tomorrow.getMonthValue()) : "0" + tomorrow.getMonthValue();
        String day = tomorrow.getDayOfMonth() > 10 ? String.valueOf(tomorrow.getDayOfMonth()) : "0" + tomorrow.getDayOfMonth();
        System.out.println(year + "-" + month + "-" + day);

        return year + "-" + month + "-" + day;
    }

    // TODO: get min cost

    public void getAvailabilities(int passengers) {
        seatAvailability = AvailabilityBean.getAvailability(this.airline, this.flightName, this.originalFlightDepartureTime, this.leg, passengers);
    }

    public float getPriceOfAvailability(String classCode, String typeCode) {
        for (AvailabilityBean availability : seatAvailability) {
            if (availability.getClassCode().equals(classCode) && availability.getTicketCode().equals(typeCode)) {
                return availability.getPrice();
            }
        }
        return -1;
    }

}
