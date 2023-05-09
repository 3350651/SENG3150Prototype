package startUp;

import java.io.Serializable;
import java.sql.Date;

public class BookingBean implements Serializable {

    private String bookingId;
    private String bookingUserId;
    private FlightBean departureFlight;
    private FlightBean returnFlight;
    private float totalAmount;

    //constructors
    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, float newTotalAmount){
        bookingId = null;
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = null;
    }
    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, FlightBean newReturnFlight, float newTotalAmount){
        bookingId = null;
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = newReturnFlight;
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

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }


    //create booking

    //save Booking Progress

    //get booking

    //update booking

    //remove booking


}
