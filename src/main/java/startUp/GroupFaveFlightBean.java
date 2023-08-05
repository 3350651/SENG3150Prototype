/**
 * FILE NAME: GroupFaveFlightBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model Object to hold data pertaining to favourited flights for groups.
 */

package startUp;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedList;
import java.util.Random;
import java.sql.*;
import java.util.Comparator;

import static startUp.ChatBean.getChatMessages;
import static startUp.FlightBean.getFlight;
import static startUp.MemberFlightVoteBean.deleteMemberFlightVotes;
import static startUp.MemberFlightVoteBean.getFaveFlightScore;
import static startUp.UserGroupsBean.getNumberOfMembers;

public class GroupFaveFlightBean implements Serializable {
    private String groupFaveFlightID;
    private String airline;
    private String flightName;
    private Timestamp flightTime;

    private String chatID;
    private double score;
    private String groupID;


    public GroupFaveFlightBean(){}

    public GroupFaveFlightBean(String airline, String flightName, Timestamp flightTime, String groupID){
        Random random = new Random();
        this.groupFaveFlightID = String.format("%08d", random.nextInt(100000000));
        this.airline = airline;
        this.flightName = flightName;
        this.flightTime = flightTime;
        ChatBean chat = new ChatBean();
        this.chatID = chat.getChatID();
        this.score = 0;
        this.groupID = groupID;

        addGroupFaveFlightToDB();
    }

    public void addGroupFaveFlightToDB(){
        String query = "INSERT INTO GROUPFAVEFLIGHT VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.groupFaveFlightID);
            statement.setString(2, this.airline);
            statement.setString(3, this.flightName);
            statement.setString(4, String.valueOf(this.flightTime));
            statement.setString(5, this.chatID);
            statement.setBigDecimal(6, BigDecimal.valueOf(this.score));
            statement.setString(7, this.groupID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public GroupFaveFlightBean(String id, String airlineCode, String flightName, Timestamp flightTime, String chatID, double score, String groupID){
        this.groupFaveFlightID = id;
        this.airline = airlineCode;
        this.flightName = flightName;
        this.flightTime = flightTime;
        this.chatID = chatID;
        this.score = score;
        this.groupID = groupID;
    }

    public String getChatID(){
        return this.chatID;
    }

    public static void deleteGroupFaveFlights(String groupID){

        String query = "DELETE FROM GROUPFAVEFLIGHT WHERE [groupID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, groupID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

    }

    public static void deleteGroupFaveFlight(String groupID, String groupFaveFlightID){

        //Get rid of related MemberFlightVotes
        deleteMemberFlightVotes(groupID, groupFaveFlightID);

        String query = "DELETE FROM GROUPFAVEFLIGHT WHERE [groupID] = ? AND [groupFaveFlightID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, groupID);
            statement.setString(2, groupFaveFlightID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

    }

    public static boolean isInGroupFaveList(String airlineCode, String flightName, Timestamp departureTime, String groupID){
        boolean isFavourited = false;
        String query = "SELECT * FROM GROUPFAVEFLIGHT WHERE [AirlineCode] = ? AND [FlightNumber] = ? AND" +
                " [DepartureTime] = ? AND [groupID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, airlineCode);
            statement.setString(2, flightName);
            statement.setTimestamp(3, departureTime);
            statement.setString(4, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                isFavourited = true;
            }
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return isFavourited;
    }

    public static LinkedList<GroupFaveFlightBean> getGroupFaveFlights(String groupID){
        LinkedList<GroupFaveFlightBean> flights = new LinkedList<>();
        String query = "SELECT * FROM GROUPFAVEFLIGHT WHERE [groupID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()){
                String id = result.getString(1);
                String airlineCode = result.getString(2);
                String flightName = result.getString(3);
                Timestamp flightTime = result.getTimestamp(4);
                String chatID = result.getString(5);
                float rank = result.getFloat(6);

                GroupFaveFlightBean flight = new GroupFaveFlightBean(id, airlineCode, flightName, flightTime, chatID, rank, groupID);
                flights.add(flight);
            }
            statement.close();
            connection.close();
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return flights;
    }

    public String getFlightName(){
        return this.flightName;
    }

    public String getAirlineCode(){
        return this.airline;
    }

    public Timestamp getFlightTime(){
        return this.flightTime;
    }

    public static LinkedList<String> getDestinations(LinkedList<GroupFaveFlightBean> faveFlights){
        LinkedList<String> destinations = new LinkedList<>();

        int size = faveFlights.size();
        for(int i = 0; i < size; i++){
            GroupFaveFlightBean fave = faveFlights.removeFirst();
            FlightBean flightBean = getFlight(fave.getAirlineCode(), fave.getFlightName(), fave.getFlightTime());
            String dest = flightBean.getDestination().getDestinationName();
            destinations.add(dest);
            faveFlights.addLast(fave);
        }

        return destinations;
    }

    public String getDestination(){
        FlightBean flightBean = getFlight(this.getAirlineCode(), this.getFlightName(), this.getFlightTime());
        return flightBean.getDestination().getDestinationName();
    }

    public static GroupFaveFlightBean getFaveFlight(String airlineCode, String flightName, Timestamp departureTime, String groupID){
        GroupFaveFlightBean faveFlight = new GroupFaveFlightBean();

        String query = "SELECT * FROM GROUPFAVEFLIGHT WHERE [AirlineCode] = ? AND [FlightNumber] = ? AND" +
                " [DepartureTime] = ? AND [groupID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, airlineCode);
            statement.setString(2, flightName);
            statement.setTimestamp(3, departureTime);
            statement.setString(4, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                String id = result.getString(1);
                String code = result.getString(2);
                String name = result.getString(3);
                Timestamp time = result.getTimestamp(4);
                String chatID = result.getString(5);
                double rank = result.getFloat(6);
                String group = result.getString(7);

                faveFlight = new GroupFaveFlightBean(id, code, name, time, chatID, rank, group);
            }

        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return faveFlight;
    }

    public static FlightBean getFlight(String airline, String flightName, Timestamp flightTime){
        int available = 0;
        FlightBean flight = null;

        try {
            String query = "SELECT f.*," +
                    "a.AirlineName" +
                    " FROM dbo.Flights f " +
                    "LEFT JOIN Dbo.Airlines a ON a.AirlineCode = f.AirlineCode" +
                    " WHERE f.[AirlineCode] = ? AND f.[FlightNumber] = ? AND f.[DepartureTime] = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, airline);
            statement.setString(2, flightName);
            statement.setTimestamp(3, flightTime);

            ResultSet result = statement.executeQuery();

            // TODO:Retrieve min cost of flight...

            while (result.next()) {
                String aCode = result.getString(1);
                String flightCode = result.getString(2);
                String plane = result.getString(10);
                Timestamp departTime = result.getTimestamp(6);
                String departureCode = result.getString(3);
                String stopOverCode = result.getString(4);
                String destinationCode = result.getString(5);
                String airlineName = result.getString(13);

                DestinationBean rDeparture = new DestinationBean(departureCode);
                DestinationBean rStopOver = new DestinationBean(stopOverCode);
                DestinationBean rDestination = new DestinationBean(destinationCode);

                flight = new FlightBean(aCode, airlineName, departTime, flightCode, plane, /* mCost, */ rDeparture,
                        rStopOver,
                        rDestination);
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }
        return flight;
    }

    public LinkedList<MessageBean> getChat(String chatID){
        return getChatMessages(chatID);
    }

    public String getGroupID(){
        return this.groupID;
    }

    public String getGroupFaveFlightID(){
        return this.groupFaveFlightID;
    }

    public void setScore(double score){
        this.score = score;

        updateGroupFaveFlightScore();
    }

    public void updateGroupFaveFlightScore(){
        String query = "UPDATE GROUPFAVEFLIGHT SET [rank] = ? WHERE [groupFaveFlightID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setDouble(1, this.score);
            statement.setString(2, this.groupFaveFlightID);


            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public double getScore(){
        return this.score;
    }

    //Sort the fave flights.
    public static LinkedList<GroupFaveFlightBean> getSortedList(LinkedList<GroupFaveFlightBean> faveFlights, String groupID){
        LinkedList<GroupFaveFlightBean> sortedFlights = new LinkedList<>();
        int size = faveFlights.size();

        //Get the score for each flight, in order to rank them.
        for(int i = 0; i < size; i++){
            GroupFaveFlightBean flight = faveFlights.removeFirst();
            double flightScore = getFaveFlightScore(flight.getGroupID(), flight.getGroupFaveFlightID());
            flight.setScore(flightScore);
            sortedFlights.addLast(flight);
        }

        //Sort the flights based on their score, will give the ranking from largest score.
        sortedFlights.sort(new FlightComparator());

        return sortedFlights;
    }

    //Determine if the flight has been lockedIn
    public static boolean lockedIn(GroupBean group, GroupFaveFlightBean faveFlight){
        float groupSize = getNumberOfMembers(group.getGroupID());
        return faveFlight.getScore() == (groupSize * 2) / groupSize;
    }

    //Determine if the flight has been blacklisted
    public static boolean blacklisted(String groupID, double score){
        float groupSize = getNumberOfMembers(groupID);
        return score == (groupSize * -2) / groupSize;
    }


}
