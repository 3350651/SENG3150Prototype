package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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

    //constructors
    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, float newTotalAmount){
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = null;
        tickets = null;
        passengers = null;
    }
    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, FlightBean newReturnFlight, float newTotalAmount){
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = newReturnFlight;
        tickets = null;
        passengers = null;
    }

    public BookingBean(String newBookingUserId,  FlightBean newDepartureFlight, FlightBean newReturnFlight){
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        returnFlight = newReturnFlight;
        tickets = null;
        passengers = null;
    }

    //getters and setters

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


    //add booking to database
    //TODO: Add ability to add with return flight if not null.
    public void addBooking(){
        try{
            String query = "INSERT INTO dbo.BOOKINGS (BookingId, BookingUserId, DepartureAirlineCode, DepartureFlightNumber, DepartureTime, Progress)\n" +
                            "VALUES(?,?,?,?,?,?);";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, this.bookingId);
            statement.setString(2, this.bookingUserId);
            statement.setString(3, this.departureFlight.getAirline());
            statement.setString(4, this.departureFlight.getFlightName());
            statement.setString(5, this.departureFlight.getFlightTime().toString());
            statement.setBoolean(6, true);
            statement.execute();

        }catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }


    //save Booking Progress

    //get booking

    //update booking

    //remove booking


}
