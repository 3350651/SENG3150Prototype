/**
 * FILE NAME: TicketBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for flight tickets
 */

package startUp;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Random;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TicketBean implements Serializable {

    private String bookingId;
    private String ticketId;
    private String passengerId;
    private String flightId;
    private String airlineId;
    private Timestamp flightTime;
    private String ticketClass;
    private String ticketClassName;
    private String ticketType;
    private String ticketTypeName;

    private String price;

    private String departure;

    private String arrival;


    public TicketBean(String bookingId, String passengerId, String flightId, String airlineId, Timestamp flightTime, String ticketClass, String ticketType){
        this.bookingId = bookingId;
        this.passengerId = passengerId;
        this.flightId = flightId;
        this.airlineId = airlineId;
        this.flightTime = flightTime;
        this.ticketClass = ticketClass;
        this.ticketType = ticketType;
        //using the ticket class code to discern the class name. Will probably make this into a database call later as its better practice
        switch (ticketClass){
            case "FIR":
                this.ticketClassName = "First Class";
                break;
            case "BUS":
                this.ticketClassName = "Business Class";
                break;
            case "PME":
                this.ticketClassName = "Premium Economy";
                break;
            case "ECO":
                this.ticketClassName = "Economy";
                break;
        }
         //using the ticket type code to discern the type name. Will probably make this into a database call later as its better practice
        switch (ticketType){
            case "A":
                this.ticketTypeName = "Standby";
                break;
            case "B":
                this.ticketTypeName = "Premium Discounted";
                break;
            case "C":
                this.ticketTypeName = "Discounted";
                break;
            case "D":
                this.ticketTypeName = "Standard";
                break;
            case "E":
                this.ticketTypeName = "Premium";
                break;
            case "F":
                this.ticketTypeName = "ld";
                break;
            case "G":
                this.ticketTypeName = "Platinum";
                break;
        }
        Random random = new Random();
        this.ticketId = String.format("%08d", random.nextInt(100000000));
    }

    //getters and setters


    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(String passengerId) {
        this.passengerId = passengerId;
    }

    public String getFlightId() {
        return flightId;
    }

    public void setFlightId(String flightId) {
        this.flightId = flightId;
    }

    public String getAirlineId() {
        return airlineId;
    }

    public void setAirlineId(String airlineId) {
        this.airlineId = airlineId;
    }

    public Timestamp getFlightTime() {
        return flightTime;
    }

    public void setFlightTime(Timestamp flightTime) {
        this.flightTime = flightTime;
    }

    public String getTicketClass() {
        return ticketClass;
    }

    public void setTicketClass(String ticketClass) {
        this.ticketClass = ticketClass;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public String getTicketId() {
        return ticketId;
    }

    public void setTicketId(String ticketId) {
        this.ticketId = ticketId;
    }

    public String getTicketClassName() {
        return ticketClassName;
    }

    public void setTicketClassName(String ticketClassName) {
        this.ticketClassName = ticketClassName;
    }

    public String getTicketTypeName() {
        return ticketTypeName;
    }

    public void setTicketTypeName(String ticketTypeName) {
        this.ticketTypeName = ticketTypeName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }



    //create ticket in database
    public void addTicket(){
        try{
            String query = "INSERT INTO dbo.TICKETS (TicketId, BookingId, PassengerId, AirlineCode, FlightNumber, DepartureTime, TicketClass, TicketType)\n" +
                            "VALUES(?,?,?,?,?,?,?,?);";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, this.ticketId);
            statement.setString(2, this.bookingId);
            statement.setString(3, this.passengerId);
            statement.setString(4, this.airlineId);
            statement.setString(5, ""+this.flightId);
            statement.setString(6, this.flightTime.toString());
            statement.setString(7, this.ticketClass);
            statement.setString(8, this.ticketType);
            statement.execute();
            statement.close();
            connection.close();

        }catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

    public String getArrival() {
        return arrival;
    }

    public void setArrival(String arrival) {
        this.arrival = arrival;
    }

    //remove ticket

    //update ticket

}
