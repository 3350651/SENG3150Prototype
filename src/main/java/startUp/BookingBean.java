package startUp;

import java.io.Serializable;
import java.sql.Date;

public class BookingBean implements Serializable {

    private String bookingId;
    private String bookingUserId;
    private String departureFlightId;
    private String departureAirlineId;
    private Date departureFlightTime;
    private String returnFlightId;
    private String returnAirlineId;
    private Date returnFlightTime;
    private float totalAmount;

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

    public String getDepartureFlightId() {
        return departureFlightId;
    }

    public void setDepartureFlightId(String departureFlightId) {
        this.departureFlightId = departureFlightId;
    }

    public String getDepartureAirlineId() {
        return departureAirlineId;
    }

    public void setDepartureAirlineId(String departureAirlineId) {
        this.departureAirlineId = departureAirlineId;
    }

    public Date getDepartureFlightTime() {
        return departureFlightTime;
    }

    public void setDepartureFlightTime(Date departureFlightTime) {
        this.departureFlightTime = departureFlightTime;
    }

    public String getReturnFlightId() {
        return returnFlightId;
    }

    public void setReturnFlightId(String returnFlightId) {
        this.returnFlightId = returnFlightId;
    }

    public String getReturnAirlineId() {
        return returnAirlineId;
    }

    public void setReturnAirlineId(String returnAirlineId) {
        this.returnAirlineId = returnAirlineId;
    }

    public Date getReturnFlightTime() {
        return returnFlightTime;
    }

    public void setReturnFlightTime(Date returnFlightTime) {
        this.returnFlightTime = returnFlightTime;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    //create booking

    //get booking

    //update booking

    //remove booking


}
