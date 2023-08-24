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

    private String groupFaveFlightID;

    private String chatID;

    private double score;

    private String groupID;

    public BookmarkedFlightBean(FlightBean flightToAdd, int bookmarkedFlightID) {
        this.id = bookmarkedFlightID;
        this.flight = flightToAdd;
    }

    public BookmarkedFlightBean(int id, FlightBean flightToAdd, String groupFaveFlightID, String chatID, double score, String groupID) {
        this.id = id;
        this.groupFaveFlightID = groupFaveFlightID;
        this.flight = flightToAdd;
        this.chatID = chatID;
        this.score = score;
        this.groupID = groupID;
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

    public String getGroupFaveFlightID() {
        return groupFaveFlightID;
    }

    public void setGroupFaveFlightID(String groupFaveFlightID) {
        this.groupFaveFlightID = groupFaveFlightID;
    }

    public String getChatID() {
        return chatID;
    }

    public void setChatID(String chatID) {
        this.chatID = chatID;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getGroupID() {
        return groupID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
    }
}