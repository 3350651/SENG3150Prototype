package startUp;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.Random;
import java.sql.*;

import static startUp.FlightBean.getFlight;

public class GroupFaveFlightBean implements Serializable {
    private String groupFaveFlightID;
    private String airline;
    private String flightName;
    private Timestamp flightTime;

    private String chatID;
    private float rank;
    private String groupID;


    public GroupFaveFlightBean(String airline, String flightName, Timestamp flightTime, String groupID){
        Random random = new Random();
        this.groupFaveFlightID = String.format("%08d", random.nextInt(100000000));
        this.airline = airline;
        this.flightName = flightName;
        this.flightTime = flightTime;
        ChatBean chat = new ChatBean();
        this.chatID = chat.getChatID();
        this.rank = 0;
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
            statement.setBigDecimal(6, BigDecimal.valueOf(this.rank));
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

    public static FlightBean getGroupFaveFlight(String airlineCode, String flightName, Timestamp flightDepartureTime) {

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

            statement.setString(1, airlineCode);
            statement.setString(2, flightName);
            statement.setTimestamp(3, flightDepartureTime);

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

    public GroupFaveFlightBean(String id, String airlineCode, String flightName, Timestamp flightTime, String chatID, float rank, String groupID){
        this.groupFaveFlightID = id;
        this.airline = airlineCode;
        this.flightName = flightName;
        this.flightTime = flightTime;
        this.chatID = chatID;
        this.rank = rank;
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

    public static boolean isInGroupFaveList(String groupID){
        boolean isFavourited = false;
        String query = "SELECT * FROM GROUPFAVEFLIGHT WHERE [groupID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
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
}
