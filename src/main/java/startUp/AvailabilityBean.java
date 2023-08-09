/**
 * FILE NAME: AvailabilityBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model Object to obtain Availability data on flights
 */

package startUp;

import java.sql.*;
import java.util.LinkedList;

public class AvailabilityBean {

    private String classCode;
    private String ticketCode;
    private String airlineCode;
    private String flightName;
    private Timestamp flightDepartureTime;
    private String className;
    private String ticketTypeName;
    private int seatsAvailable;
    private float price;

    //constructors

    public AvailabilityBean(String newClassCode, String newTicketCode, String newAirlineCode, String newFlightName,
                            Timestamp newFlightDepartureTime, int newSeatsAvailable, String newClassName,
                            String newTicketTypeName, float newPrice) {
        classCode = newClassCode;
        ticketCode = newTicketCode;
        airlineCode = newAirlineCode;
        flightName = newFlightName;
        flightDepartureTime = newFlightDepartureTime;
        seatsAvailable = newSeatsAvailable;
        className = newClassName;
        ticketTypeName = newTicketTypeName;
        price = newPrice;
    }



    //getters and setters
    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public String getAirlineCode() {
        return airlineCode;
    }

    public void setAirlineCode(String airlineCode) {
        this.airlineCode = airlineCode;
    }

    public String getFlightName() {
        return flightName;
    }

    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    public Timestamp getFlightDepartureTime() {
        return flightDepartureTime;
    }

    public void setFlightDepartureTime(Timestamp flightDepartureTime) {
        this.flightDepartureTime = flightDepartureTime;
    }

    public int getSeatsAvailable() {
        return seatsAvailable;
    }

    public void setSeatsAvailable(int seatsAvailable) {
        this.seatsAvailable = seatsAvailable;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getTicketTypeName() {
        return ticketTypeName;
    }

    public void setTicketTypeName(String ticketTypeName) {
        this.ticketTypeName = ticketTypeName;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    //retrieves availabilities for the specified flight
    public static LinkedList<AvailabilityBean> getAvailability(String airlineCode, String flightName, Timestamp flightDepartureTime, int leg, int passengers) {

        int available = 0;
        String classCode = "";
        String ticketType = "";
        String className = "";
        String ticketTypeName = "";
        float price = 0;
        LinkedList<AvailabilityBean> list = new LinkedList<>();

        try {
            String query = "";
            switch (leg) {
                case 0:
                    query = "SELECT  [a].[ClassCode], " +
                            "        [a].[TicketCode], " +
                            "        [a].[NumberAvailableSeatsLeg1], " +
                            "        [c].[Details], " +
                            "        [t].[Name], " +
                            "        [p].[Price] AS Price FROM Availability a " +
                            "        LEFT JOIN TicketClass c ON c.ClassCode = a.ClassCode " +
                            "        LEFT JOIN TicketType t ON t.TicketCode = a.TicketCode " +
                            "        LEFT JOIN Price p ON p.AirlineCode = a.AirlineCode AND p.ClassCode = a.ClassCode " +
                            "        AND p.FlightNumber = a.FlightNumber AND p.TicketCode = a.TicketCode AND " +
                            "        (a.DepartureTime >= p.StartDate AND a.DepartureTime <= p.EndDate) " +
                            "        WHERE a.AirlineCode = ? AND a.FlightNumber = ? AND a.DepartureTime = ? AND NumberAvailableSeatsLeg1 >= ?" +
                            "        ORDER BY [p].[Price]";
                    break;
                case 1:
                    query = "SELECT  [a].[ClassCode], " +
                            "        [a].[TicketCode], " +
                            "        [a].[NumberAvailableSeatsLeg1], " +
                            "        [c].[Details], " +
                            "        [t].[Name], " +
                            "        [p].[PriceLeg1] AS Price FROM Availability a " +
                            "        LEFT JOIN TicketClass c ON c.ClassCode = a.ClassCode " +
                            "        LEFT JOIN TicketType t ON t.TicketCode = a.TicketCode " +
                            "        LEFT JOIN Price p ON p.AirlineCode = a.AirlineCode AND p.ClassCode = a.ClassCode " +
                            "        AND p.FlightNumber = a.FlightNumber AND p.TicketCode = a.TicketCode AND " +
                            "        (a.DepartureTime >= p.StartDate AND a.DepartureTime <= p.EndDate) " +
                            "        WHERE a.AirlineCode = ? AND a.FlightNumber = ? AND a.DepartureTime = ? AND NumberAvailableSeatsLeg1 >= ?" +
                            "        ORDER BY [p].[PriceLeg1]";
                    break;
                case 2:
                    query = "SELECT  [a].[ClassCode], " +
                            "        [a].[TicketCode], " +
                            "        [a].[NumberAvailableSeatsLeg2], " +
                            "        [c].[Details], " +
                            "        [t].[Name], " +
                            "        [p].[PriceLeg2] AS Price FROM Availability a " +
                            "        LEFT JOIN TicketClass c ON c.ClassCode = a.ClassCode " +
                            "        LEFT JOIN TicketType t ON t.TicketCode = a.TicketCode " +
                            "        LEFT JOIN Price p ON p.AirlineCode = a.AirlineCode AND p.ClassCode = a.ClassCode " +
                            "        AND p.FlightNumber = a.FlightNumber AND p.TicketCode = a.TicketCode AND " +
                            "        (a.DepartureTime >= p.StartDate AND a.DepartureTime <= p.EndDate) " +
                            "        WHERE a.AirlineCode = ? AND a.FlightNumber = ? AND a.DepartureTime = ? AND NumberAvailableSeatsLeg2 >= ?" +
                            "        ORDER BY [p].[PriceLeg2]";
                    ;
                    break;
            }

            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, airlineCode);
            statement.setString(2, flightName);
            statement.setString(3, flightDepartureTime.toString());
            statement.setInt(4, passengers);

            ResultSet result = statement.executeQuery();

            while(result.next()) {
                classCode = result.getString(1);
                ticketType = result.getString(2);
                available = result.getInt(3);
                className = result.getString(4);
                ticketTypeName = result.getString(5);
                price = result.getFloat(6);
                list.add(new AvailabilityBean(classCode, ticketType, airlineCode, flightName, flightDepartureTime, available, className, ticketTypeName, price));
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return list;
    }

    //update availability



    //remove availability

    //add availability

}
