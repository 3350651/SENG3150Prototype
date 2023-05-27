/**
 * FILE NAME: UserGroupsBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for groups a users is a part of
 */

package startUp;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedList;
import java.util.Random;

import static startUp.UserBean.getUsersName;

public class UserGroupsBean implements Serializable {

    private String userGroupsID;
    private String userID;
    private String groupID;
    private boolean isAdmin;

    public UserGroupsBean(String userID, String groupID, boolean createdGroup){
        Random random = new Random();
        this.userGroupsID = String.format("%08d", random.nextInt(100000000));
        this.userID = userID;
        this.groupID = groupID;
        isAdmin = createdGroup;

        addUserGroupsToDB();
    }

    public void addUserGroupsToDB(){
        String query = "INSERT INTO USERGROUPS VALUES (?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.userGroupsID);
            statement.setString(2, this.userID);
            statement.setString(3, this.groupID);

            if(isAdmin){
                statement.setInt(4, 1);
            }
            else{
                statement.setInt(4, 0);
            }

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }


    public static boolean isAdmin(String userID, String groupID){
        boolean isAdmin = false;
        int res;

        String query = "SELECT isAdmin FROM USERGROUPS WHERE [userID] = ? AND [groupID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, userID);
            statement.setString(2, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                res = result.getInt(1);
                if (res == 1) {
                    isAdmin = true;
                }
            }
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return isAdmin;
    }

    public static LinkedList<String> getGroupMembersIDs(String groupID){
        LinkedList<String> userIDs = new LinkedList<>();

        String query = "SELECT userID FROM USERGROUPS WHERE [groupID] = ? AND isAdmin = 0";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                userIDs.add(result.getString(1));
            }
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return userIDs;
    }

    public static LinkedList<String> getGroupMemberNames(LinkedList<String> userIDs){
        LinkedList<String> memberNames = new LinkedList<>();
        int size = userIDs.size();

        for(int i = 0; i < size; i++) {
            String id = userIDs.pop();
            memberNames.add(getUsersName(id));
            userIDs.addLast(id);
        }
        return memberNames;
    }

    public static void removeGroupMember(String id){

        String query = "DELETE FROM USERGROUPS WHERE [userID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, id);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

    }

    public static void deleteUserGroups(String id){

        String query = "DELETE FROM USERGROUPS WHERE [groupID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, id);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static boolean userAlreadyInGroup(String userID, String groupID){
        boolean inGroup = false;

        String query = "SELECT * FROM USERGROUPS WHERE [userID] = ? AND [groupID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, userID);
            statement.setString(2, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                inGroup = true;
            }
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return inGroup;
    }

}
