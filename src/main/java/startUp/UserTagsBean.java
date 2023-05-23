package startUp;

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

import static startUp.UserBean.getUsersName;

    public class UserTagsBean implements Serializable {

    private String userID;
    private String tagID;
    private String userTagsID;

    public UserTagsBean(String userID, String tagID){
        Random random = new Random();
        this.userTagsID = String.format("%08d", random.nextInt(100000000));
        this.userID = userID;
        this.tagID = tagID;

        addTagToUserInDB();
    }

    public void addTagToUserInDB(){
        String query = "INSERT INTO USERTAGS VALUES (?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.userTagsID);
            statement.setString(2, this.userID);
            statement.setString(3, this.tagID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static void removeTag(String userID, String tagID){

        String query = "DELETE FROM USERTAGS WHERE [userID] = ? AND [tagID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, userID);
            statement.setString(1, tagID);
            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static boolean userAlreadyHasTag(String userID, String tagID){
        boolean hasTag = false;

        String query = "SELECT * FROM USERTAGS WHERE [userID] = ? AND [tagID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, userID);
            statement.setString(2, tagID);
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
