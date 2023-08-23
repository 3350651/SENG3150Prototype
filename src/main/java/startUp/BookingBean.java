/**
 * FILE NAME: BookingBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model Object to hold data pertaining to bookings for customers
 */

package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.Random;

public class BookingBean implements Serializable {

    private String bookingId;
    private String bookingUserId;
    private FlightBean departureFlight;
    private FlightBean returnFlight;
    private LinkedList<TicketBean> tickets;
    private LinkedList<PassengerBean> passengers;
    private float totalAmount;
    private boolean progress;

    // constructors

    public BookingBean(String bookingId, String bookingUserId, FlightBean departureFlight, FlightBean returnFlight,
    LinkedList<TicketBean> tickets, LinkedList<PassengerBean> passengers, float totalAmount, boolean progress){
        this.bookingId = bookingId;
        this.bookingUserId = bookingUserId;
        this.departureFlight = departureFlight;
        this.returnFlight = returnFlight;
        this.tickets = tickets;
        this.passengers = passengers;
        this.totalAmount = totalAmount;
        this.progress = progress;
    }

    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, float newTotalAmount) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = null;
        tickets = null;
        passengers = null;
    }

    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, FlightBean newReturnFlight,
            float newTotalAmount) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = newReturnFlight;
        tickets = null;
        passengers = null;
    }

    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, FlightBean newReturnFlight) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        returnFlight = newReturnFlight;
        tickets = null;
        passengers = null;
    }

    // getters and setters

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getBookingUserId() {
        return bookingUserId;
    }

    public void setBookingUserId(String bookingUserId) {
        this.bookingUserId = bookingUserId;
    }

    public FlightBean getDepartureFlight() {
        return departureFlight;
    }

    public void setDepartureFlight(FlightBean departureFlight) {
        this.departureFlight = departureFlight;
    }

    public FlightBean getReturnFlight() {
        return returnFlight;
    }

    public void setReturnFlight(FlightBean returnFlight) {
        this.returnFlight = returnFlight;
    }

    public LinkedList<TicketBean> getTickets() {
        return tickets;
    }

    public void setTickets(LinkedList<TicketBean> tickets) {
        this.tickets = tickets;
    }

    public LinkedList<PassengerBean> getPassengers() {
        return passengers;
    }

    public void setPassengers(LinkedList<PassengerBean> passengers) {
        this.passengers = passengers;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    // add booking to database
    // TODO: Add ability to add with return flight if not null.
//    public void addBooking() {
//        try {
//            String query = "INSERT INTO dbo.BOOKINGS (BookingId, BookingUserId, DepartureAirlineCode, DepartureFlightNumber, DepartureTime, TotalAmount, Progress)\n"
//                    +
//                    "VALUES(?,?,?,?,?,?,?);";
//            Connection connection = ConfigBean.getConnection();
//            PreparedStatement statement = connection.prepareStatement(query);
//            statement.setString(1, this.bookingId);
//            statement.setString(2, this.bookingUserId);
//            statement.setString(3, this.departureFlight.getAirline());
//            statement.setString(4, this.departureFlight.getFlightName());
//            statement.setString(5, this.departureFlight.getFlightTime().toString());
//            statement.setString(6, String.valueOf(this.totalAmount));
//            statement.setBoolean(7, true);
//            statement.execute();
//            statement.close();
//            connection.close();
//
//        } catch (SQLException e) {
//            System.err.println(e.getMessage());
//            System.err.println(e.getStackTrace());
//        }
//
//    }

    //change progress bit of booking to false
    public void finalise() {
        try {
            String query = "UPDATE BOOKINGS SET Progress = 0 WHERE BookingId = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, this.bookingId);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    //get all bookings related to user
//    public static LinkedList<BookingBean> getUserBookings(String userId){
//        LinkedList<BookingBean> bookings = new LinkedList<>();
//        try {
//            String query = "SELECT * from BOOKINGS WHERE BookingUserId = ?";
//            Connection connection = ConfigBean.getConnection();
//            PreparedStatement statement = connection.prepareStatement(query);
//            statement.setString(1, userId);
//            ResultSet results =  statement.executeQuery();
//
//
//            BookingBean booking = null;
//            while(results.next()){
//                String bookingId = results.getString(1);
//                String bookingUserId = results.getString(2);
//                String DepartureAirlineCode = results.getString(3);
//                String DepartureFlightNumber = results.getString(4);
//                Timestamp departureTime = results.getTimestamp(5);
//                String returnAirlineCode = results.getString(6);
//                String returnFlightNumber = results.getString(7);
//                Timestamp returnTime = results.getTimestamp(8);
//                float totalAmount = results.getFloat(9);
//                boolean progress = results.getBoolean(10);
//
//                //getDepartureFlight
//                FlightBean departureFlight = FlightBean.getFlight(DepartureAirlineCode, DepartureFlightNumber, departureTime);
//
//                //getReturnFlight
//                FlightBean returnFlight = FlightBean.getFlight(returnAirlineCode, returnFlightNumber, returnTime);
//
//                //get passengers from this booking
//                query = "SELECT * FROM PASSENGERS WHERE BookingId = ?";
//                statement = connection.prepareStatement(query);
//                statement.setString(1, bookingId);
//                ResultSet passengerResults = statement.executeQuery();
//                LinkedList<PassengerBean> passengers = null;
//                while(passengerResults.next()){
//                    String passengerId = passengerResults.getString(1);
//                    String lName = passengerResults.getString(2);
//                    String fName = passengerResults.getString(3);
//                    String email = passengerResults.getString(4);
//                    String mobile = passengerResults.getString(5);
//                    Timestamp DOB = passengerResults.getTimestamp(6);
//                    String passengerBookingId = passengerResults.getString(7);
//                    passengers.add(new PassengerBean(lName, fName, email, mobile, DOB, passengerBookingId));
//                }
//                //get tickets from this booking
//                query = "SELECT * FROM TICKETS WHERE BookingId = ?";
//                statement = connection.prepareStatement(query);
//                statement.setString(1, bookingId);
//                ResultSet ticketResults = statement.executeQuery();
//                LinkedList<TicketBean> tickets = null;
//                while(ticketResults.next()){
//                    String ticketId = ticketResults.getString(1);
//                    String ticketBookingId = ticketResults.getString(2);
//                    String ticketPassengerId = ticketResults.getString(3);
//                    String ticketAirlineCode = ticketResults.getString(4);
//                    String ticketFlightNumber = ticketResults.getString(5);
//                    Timestamp ticketDepartureTime = ticketResults.getTimestamp(6);
//                    String ticketClass = ticketResults.getString(7);
//                    String ticketType = ticketResults.getString(8);
//                    tickets.add(new TicketBean(ticketBookingId, ticketPassengerId, ticketFlightNumber, ticketAirlineCode, ticketDepartureTime, ticketClass, ticketType));
//                }
//                bookings.add(new BookingBean(bookingId, bookingUserId, departureFlight, returnFlight, tickets, passengers, totalAmount, progress ));
//
//            }
//            statement.close();
//            connection.close();
//        } catch (SQLException e) {
//            System.err.println(e.getMessage());
//            System.err.println(e.getStackTrace());
//        }
//        return bookings;
//    }

    // save Booking Progress

    // get booking

    // update booking

    // remove booking

}
