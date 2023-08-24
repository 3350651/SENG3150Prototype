/**
 * FILE NAME: GroupFaveFlightBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model Object to hold data pertaining to favourited flights for groups.
 */

package startUp;

import javax.swing.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.*;
import java.sql.*;

import static startUp.ChatBean.getChatMessages;
import static startUp.FlightBean.getFlight;
import static startUp.MemberFlightVoteBean.deleteMemberFlightVotes;
import static startUp.MemberFlightVoteBean.getFaveFlightScore;
import static startUp.UserGroupsBean.getNumberOfMembers;

public class GroupFaveFlightBean implements Serializable{
    private String groupFaveFlightID;
    private FlightPathBean flightPath;

    private String chatID;
    private double score;
    private String groupID;


    public GroupFaveFlightBean(){
        this.groupFaveFlightID = "";
        this.flightPath = new FlightPathBean();
        this.chatID = "";
        this.score = 0;
        this.groupID = "";
    }

    public GroupFaveFlightBean(FlightPathBean flightPath, String groupID){
        Random random = new Random();
        this.groupFaveFlightID = String.format("%08d", random.nextInt(100000000));
        ChatBean chat = new ChatBean();
        this.chatID = chat.getChatID();
        this.score = 0;
        this.groupID = groupID;
        this.flightPath = flightPath;
        addGroupFaveFlightToDB();
    }

    public void addGroupFaveFlightToDB(){
        String insertFlightPath = "INSERT INTO FLIGHTPATH VALUES(?, ?)";
        String insertFlightPathFlight = "INSERT INTO FLIGHTPATHFLIGHT VALUES (?, ?, ?, ?, ?)";
        String query = "INSERT INTO GROUPFAVEFLIGHT VALUES (?, ?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement insertPath = connection.prepareStatement(insertFlightPath);
            PreparedStatement insertFlight = connection.prepareStatement(insertFlightPathFlight);
            PreparedStatement statement = connection.prepareStatement(query);

            insertPath.setString(1, String.valueOf(this.flightPath.getId()));
            insertPath.setFloat(2, this.flightPath.getMinPrice());
            insertPath.executeUpdate();

            for (FlightBean flightInFlightPath: this.flightPath.getFlightPath()){
                insertFlight.setString(1, String.valueOf(this.flightPath.getId()));
                insertFlight.setString(2, flightInFlightPath.getAirline());
                insertFlight.setString(3, flightInFlightPath.getFlightName());
                if (flightInFlightPath.getLeg() == 2){
                    insertFlight.setTimestamp(4, flightInFlightPath.getOriginalFlightDepartureTime());
                }
                else{
                    insertFlight.setTimestamp(4, flightInFlightPath.getFlightTime());
                }
                insertFlight.setInt(5, flightInFlightPath.getLeg());
                insertFlight.executeUpdate();
            }

            statement.setString(1, this.groupFaveFlightID);
            statement.setBigDecimal(2, BigDecimal.valueOf(this.score));
            statement.setString(3, String.valueOf(this.flightPath.getId()));
            statement.setString(4, this.chatID);
            statement.setString(5, this.groupID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public GroupFaveFlightBean(String id, FlightPathBean flightPath, String chatID, double score, String groupID){
        this.groupFaveFlightID = id;
        this.flightPath = flightPath;
        this.chatID = chatID;
        this.score = score;
        this.groupID = groupID;
    }

    public GroupFaveFlightBean(String id, String chatID, double score, String groupID){
        this.groupFaveFlightID = id;
        this.chatID = chatID;
        this.score = score;
        this.groupID = groupID;
    }

    public String getChatID(){
        return this.chatID;
    }

    public void setGroupFaveFlightID(String groupFaveFlightID) {
        this.groupFaveFlightID = groupFaveFlightID;
    }

    public FlightPathBean getFlightPath() {
        return flightPath;
    }

    public void setFlightPath(FlightPathBean flightPath) {
        this.flightPath = flightPath;
    }

    public void setChatID(String chatID) {
        this.chatID = chatID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
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


        String query = "SELECT flightPathID FROM GROUPFAVEFLIGHT WHERE groupFaveFlightID = ?";
        String deleteGroupFaveFlight = "DELETE FROM GROUPFAVEFLIGHT WHERE flightPathID = ?";
        String deleteFlightsAssociated = "DELETE FROM FLIGHTPATHFLIGHT WHERE flightPathID = ?";
        String deleteFlightPaths = "DELETE FROM FLIGHTPATH WHERE flightPathID = ?";

        try {
            int flightPathID = 0;
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, groupFaveFlightID);

            ResultSet result = statement.executeQuery();

            while (result.next()) {
                flightPathID = Integer.parseInt(result.getString("flightPathID"));
            }
            statement.close();
            statement = connection.prepareStatement(deleteGroupFaveFlight);

            statement.setString(1, String.valueOf(flightPathID));

            statement.executeUpdate();
            statement.close();
            statement = connection.prepareStatement(deleteFlightsAssociated);

            statement.setString(1, String.valueOf(flightPathID));

            statement.executeUpdate();
            statement.close();
            statement = connection.prepareStatement(deleteFlightPaths);

            statement.setString(1, String.valueOf(flightPathID));

            statement.executeUpdate();
            statement.close();

            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

    }

    public static boolean isInGroupFaveList(int flightPathID, String groupID){
        boolean isFavourited = false;
        String query = "SELECT * FROM GROUPFAVEFLIGHT WHERE [flightPathID] = ? AND [groupID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, flightPathID);
            statement.setString(2, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                isFavourited = true;
            }
            statement.close();
            connection.close();
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return isFavourited;
    }

    public static LinkedList<String> getDestinations(LinkedList<GroupFaveFlightBean> flightPath){
        LinkedList<String> destinations = new LinkedList<>();

        int size = flightPath.size();
        for(int i = 0; i < size; i++){
            GroupFaveFlightBean fave = flightPath.removeFirst();
            String destination = fave.getFlightPath().getLastFlight().getDestination().getDestinationName();
            destinations.add(destination);
            flightPath.addLast(fave);
        }

        return destinations;
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
                        rDestination);
                flight.loadDestinationBeans();
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


    //Determine if the flight has been lockedIn
    public static boolean lockedIn(String groupID, double score){
        float groupSize = getNumberOfMembers(groupID);
        return score == (groupSize * 2) / groupSize;
    }

    //Determine if the flight has been blacklisted
    public static boolean blacklisted(String groupID, double score){
        float groupSize = getNumberOfMembers(groupID);
        return score == (groupSize * -2) / groupSize;
    }

    public static GroupFaveFlightBean getLockedIn(){
        GroupFaveFlightBean lockedInFlight = new GroupFaveFlightBean();

        String query = "SELECT * FROM GROUPFAVEFLIGHT WHERE [rank] = 2";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                String id = result.getString(1);
                double rank = result.getFloat(2);
                String flightPathID = result.getString(3);
                String chatID = result.getString(4);
                String group = result.getString(5);


                lockedInFlight = new GroupFaveFlightBean(id, FlightPathBean.getFlightPath(flightPathID), chatID, rank, group);
            }
            statement.close();
            connection.close();
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        //Delete all the other flights for that group.
        deleteAllNotLockedIn();

        return lockedInFlight;
    }

    public static void deleteAllNotLockedIn(){
        String query = "DELETE FROM GROUPFAVEFLIGHT WHERE [rank] != 2";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static LinkedList<GroupFaveFlightBean> getGroupFaveFlights(String groupID) {
        Queue<BookmarkedFlightBean> flightsToSort = null;
        HashMap<Integer, Float> hm = new HashMap<>();
        try {
            String query = "SELECT fpf.*, fp.minimumPrice, gf.* " +
                    "FROM FLIGHTPATHFLIGHT fpf " +
                    "JOIN FLIGHTPATH fp ON fpf.flightPathID = fp.flightPathID " +
                    "JOIN GROUPFAVEFLIGHT gf ON gf.flightPathID = fp.flightPathID " +
                    "WHERE gf.groupID = ? " +
                    "ORDER BY gf.flightPathID, fpf.DepartureTime DESC; ";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
            ResultSet result = statement.executeQuery();
            flightsToSort = new LinkedList<>();
            while (result.next()) {
                String groupFaveFlightID = result.getString("groupFaveFlightID");
                int flightPathID = Integer.parseInt(result.getString("flightPathID"));
                double score = result.getDouble("rank");
                String chatID = result.getString("chatID");
                String airlineCodeToAdd = result.getString("AirlineCode");
                String flightNumberToAdd = result.getString("FlightNumber");
                Timestamp departureTimeToAdd = result.getTimestamp("DepartureTime");
                float minimumCost = result.getFloat("minimumPrice");
                hm.put(flightPathID, minimumCost);
                int leg = result.getInt("Leg");
                FlightBean flightToAdd = new FlightBean(airlineCodeToAdd, flightNumberToAdd, departureTimeToAdd, leg);
                flightToAdd.loadDestinationBeans();
                BookmarkedFlightBean bfb = new BookmarkedFlightBean(flightPathID, flightToAdd, groupFaveFlightID, chatID, score, groupID);
                flightsToSort.add(bfb);
            }

            result.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }

        Stack<FlightPathBean> flightPaths = new Stack<FlightPathBean>();
        int tempFlightPathID = -1; // Initialize to a value that doesn't match any ID
        LinkedList<GroupFaveFlightBean> groupFaveFlightList = new LinkedList<>();
        GroupFaveFlightBean gf;
        while (!flightsToSort.isEmpty()) {
            gf = new GroupFaveFlightBean(flightsToSort.peek().getGroupFaveFlightID(),
                    flightsToSort.peek().getChatID(), flightsToSort.peek().getScore(),
                    flightsToSort.peek().getGroupID());
            int currentFlightPathID = flightsToSort.peek().getId();

            if (currentFlightPathID != tempFlightPathID) {

                Stack<FlightBean> flights = new Stack<FlightBean>();
                float minimumPrice = hm.get(currentFlightPathID);

                FlightBean flightToAddToPath;
                while (!flightsToSort.isEmpty() && flightsToSort.peek().getId() == currentFlightPathID) {
                    flightToAddToPath = flightsToSort.poll().getFlight();
                    flights.add(flightToAddToPath);
                }
                FlightPathBean fpb = new FlightPathBean(flights);
                fpb.setId(currentFlightPathID);
                fpb.setMinPrice(minimumPrice);
                ;
                gf.setFlightPath(fpb);
                groupFaveFlightList.add(gf);
                tempFlightPathID = currentFlightPathID; // update tempFlightPathID
            }
        }
        return groupFaveFlightList;
    }
}
