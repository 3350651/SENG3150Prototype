package startUp;

/**
 * FILE NAME: BookmarkedFlightBean
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin, Rogel Christian (Chris)
 * CREATED DATE: 9/08/2023
 * PURPOSE: SENG3150 Project
 */
public class BookmarkedFlightBean{
    private int id;
    private FlightBean flight;

    public BookmarkedFlightBean(FlightBean flightToAdd, int bookmarkedFlightID) {
        this.id = bookmarkedFlightID;
        this.flight = flightToAdd;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public FlightBean getFlight() {
        return flight;
    }

    public void setFlight(FlightBean flight) {
        this.flight = flight;
    }
}