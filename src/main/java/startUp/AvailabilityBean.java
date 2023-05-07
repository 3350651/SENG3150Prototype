package startUp;

import java.sql.Date;

public class AvailabilityBean {

    private String classCode;
    private String ticketCode;
    private String airlineCode;
    private String flightName;
    private Date flightDepartureTime;
    private int seatsAvailable;

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

    public Date getFlightDepartureTime() {
        return flightDepartureTime;
    }

    public void setFlightDepartureTime(Date flightDepartureTime) {
        this.flightDepartureTime = flightDepartureTime;
    }

    public int getSeatsAvailable() {
        return seatsAvailable;
    }

    public void setSeatsAvailable(int seatsAvailable) {
        this.seatsAvailable = seatsAvailable;
    }
}
