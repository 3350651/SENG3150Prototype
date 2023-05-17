package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Random;
import java.io.Serializable;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Random;
import static startUp.UserBean.getUsersName;

public class UserBookmarkedFlightBean implements Serializable{

    private String userBookmarkedFlightID;
    private String userID;
    private String airlineCode;
    private String flightNumber;
    private Timestamp departureTime;

    public UserBookmarkedFlightBean(String userID, String airlineCode, String flightNumber, Timestamp departureTime){
        Random random = new Random();
        this.userBookmarkedFlightID = String.format("%08d", random.nextInt(100000000));
        this.userID = userID;
        this.airlineCode = airlineCode;
        this.flightNumber = flightNumber;
        this.departureTime = departureTime;

        addFlightToUserInDB();
    }

    public void addFlightToUserInDB(){
        String query = "INSERT INTO USERBOOKMARKEDFLIGHTS VALUES (?, ?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.userBookmarkedFlightID);
            statement.setString(2, this.userID);
            statement.setString(3, this.airlineCode);
            statement.setString(4, this.flightNumber);
            statement.setTimestamp(5, this.departureTime);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static void removeFlightFromUserInDB(String userID, String airlineCode, String flightNumber, Timestamp departureTime){

        String query = "DELETE FROM USERBOOKMARKEDFLIGHTS WHERE [userID] = ? AND [airlineCode] = ? AND [flightNumber] = ? AND [departureTime] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, userID);
            statement.setString(2, airlineCode);
            statement.setString(3, flightNumber);
            statement.setTimestamp(4, departureTime);
            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static boolean userAlreadyHasTag(String userID, String airlineCode, String flightNumber, Timestamp departureTime){
        boolean hasTag = false;

        String query = "SELECT * FROM USERBOOKMARKEDFLIGHTS WHERE [userID] = ? AND [airlineCode] = ? AND [flightNumber] = ? AND [departureTime] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, userID);
            statement.setString(2, airlineCode);
            statement.setString(3, flightNumber);
            statement.setTimestamp(4, departureTime);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                hasTag = true;
            }
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return hasTag;
    }
}
