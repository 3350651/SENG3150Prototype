/**
 * FILE NAME: Passenger.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for passengers on a flight
 */

package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Random;

public class PassengerBean implements Serializable {

    private String passengerId;
    private String lastName;
    private String givenNames;
    private String email;
    private String phoneNumber;
    private Timestamp dateOfBirth;
    private String bookingId;
    private TicketBean departureTicket;
    private TicketBean returnTicket;

    //constructor
    public PassengerBean(String lastName, String givenNames, String email, String phoneNumber, Timestamp dateOfBirth, String bookingId){
        this.lastName = lastName;
        this.givenNames = givenNames;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.dateOfBirth = dateOfBirth;
        this.bookingId = bookingId;
        Random random = new Random();
        this.passengerId = String.format("%08d", random.nextInt(100000000));
    }


    //getters and setters

    public String getPassengerId() {
        return passengerId;
    }

    public void setPassengerId(String passengerId) {
        this.passengerId = passengerId;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGivenNames() {
        return givenNames;
    }

    public void setGivenNames(String givenNames) {
        this.givenNames = givenNames;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Timestamp getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Timestamp dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public TicketBean getDepartureTicket() {
        return departureTicket;
    }

    public void setDepartureTicket(TicketBean departureTicket) {
        this.departureTicket = departureTicket;
    }

    public TicketBean getReturnTicket() {
        return returnTicket;
    }

    public void setReturnTicket(TicketBean returnTicket) {
        this.returnTicket = returnTicket;
    }

    //create passenger in database
    public void addPassenger(){
        try{
            String query = "INSERT INTO dbo.PASSENGERS (PassengerId, LastName, GivenNames, Email, PhoneNumber, DateOfBirth, BookingId)\n" +
                            "VALUES(?,?,?,?,?,?,?);";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, this.passengerId);
            statement.setString(2, this.lastName);
            statement.setString(3, this.givenNames);
            statement.setString(4, this.email);
            statement.setString(5, ""+this.phoneNumber);
            statement.setString(6, this.dateOfBirth.toString());
            statement.setString(7, this.bookingId);
            statement.execute();
            statement.close();
            connection.close();

        }catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    //remove passenger

    //update passenger

}
