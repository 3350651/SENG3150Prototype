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
    private int leg1SeatsAvailable;
    private int leg2SeatsAvailable;
    private float fullPrice;
    private float leg1Price;
    private float leg2Price;

    //constructors

    public AvailabilityBean(String newClassCode, String newTicketCode, String newAirlineCode, String newFlightName,
                            Timestamp newFlightDepartureTime, int newLeg1SeatsAvailable, int newLeg2SeatsAvailable,
                            String newClassName, String newTicketTypeName, float newseatPrice, float newLeg1Price, float newLeg2Price){
        classCode = newClassCode;
        ticketCode = newTicketCode;
        airlineCode = newAirlineCode;
        flightName = newFlightName;
        flightDepartureTime = newFlightDepartureTime;
        leg1SeatsAvailable = newLeg1SeatsAvailable;
        leg2SeatsAvailable = newLeg2SeatsAvailable;
        className = newClassName;
        ticketTypeName = newTicketTypeName;
        fullPrice = newseatPrice;
        leg1Price = newLeg1Price;
        leg2Price =- newLeg2Price;
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

    public int getLeg1SeatsAvailable() {
        return leg1SeatsAvailable;
    }

    public void setLeg1SeatsAvailable(int leg1SeatsAvailable) {
        this.leg1SeatsAvailable = leg1SeatsAvailable;
    }

    public int getLeg2SeatsAvailable() {
        return leg2SeatsAvailable;
    }

    public void setLeg2SeatsAvailable(int leg2SeatsAvailable) {
        this.leg2SeatsAvailable = leg2SeatsAvailable;
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

    public float getFullPrice() {
        return fullPrice;
    }

    public void setFullPrice(float fullPrice) {
        this.fullPrice = fullPrice;
    }

    public float getLeg1Price() {
        return leg1Price;
    }

    public void setLeg1Price(float leg1Price) {
        this.leg1Price = leg1Price;
    }

    public float getLeg2Price() {
        return leg2Price;
    }

    public void setLeg2Price(float leg2Price) {
        this.leg2Price = leg2Price;
    }

    //retrieves availabilities for the specified flight
    public static LinkedList<AvailabilityBean> getAvailability(String airlineCode, String flightName, Timestamp flightDepartureTime){

        int available1 = 0;
        int available2 = 0;
        String classCode = "";
        String ticketType = "";
        String className = "";
        String ticketTypeName = "";
        float fullPrice = 0, leg1Price = 0, leg2Price = 0;
        LinkedList<AvailabilityBean> list = new LinkedList<>();

        try {
            String query = "SELECT [a].[AirlineCode]," +
                    "[a].[FlightNumber]," +
                    "[a].[DepartureTime]," +
                    "[a].[ClassCode]," +
                    "[a].[TicketCode]," +
                    "[a].[NumberAvailableSeatsLeg1]," +
                    "[a].[NumberAvailableSeatsLeg2]," +
                    "[c].[Details]," +
                    "[t].[Name]," +
                    "[p].Price," +
                    "[p].[PriceLeg1]," +
                    "[p].[PriceLeg2] FROM Availability a " +
                    "LEFT JOIN TicketClass c ON c.ClassCode = a.ClassCode " +
                    "LEFT JOIN TicketType t ON t.TicketCode = a.TicketCode " +
                    "LEFT JOIN Price p ON p.AirlineCode = a.AirlineCode AND p.ClassCode = a.ClassCode " +
                    "AND p.FlightNumber = a.FlightNumber AND p.TicketCode = a.TicketCode AND " +
                    "(a.DepartureTime >= p.StartDate AND a.DepartureTime <= p.EndDate) " +
                    "WHERE a.AirlineCode = ? AND a.FlightNumber = ? AND a.DepartureTime = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, airlineCode);
            statement.setString(2, flightName);
            statement.setString(3, flightDepartureTime.toString());

            ResultSet result = statement.executeQuery();

            while(result.next()){
                    classCode = result.getString(4);
                    ticketType = result.getString(5);
                    available1 = result.getInt(6);
                    available2 = result.getInt(7);
                    className = result.getString(8);
                    ticketTypeName = result.getString(9);
                    fullPrice = result.getFloat(10);
                    leg1Price = result.getFloat(11);
                    leg2Price = result.getFloat(12);
                    list.add(new AvailabilityBean(classCode, ticketType, airlineCode, flightName, flightDepartureTime, available1, available2, className, ticketTypeName, fullPrice, leg1Price, leg2Price));
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
