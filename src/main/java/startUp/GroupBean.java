package startUp;

import com.sun.jndi.ldap.pool.Pool;

import java.io.Serializable;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Random;

import static startUp.ChatBean.getChatMessages;
import static startUp.PoolBean.*;

public class GroupBean implements Serializable {

    private String groupID;
    private String groupName;
    private String chatID;
    private String poolID;

    /*
    private String poolID;
    private String chatID;
    private String faveListID;
     */

    public GroupBean(){
    }

    public GroupBean(String groupName){
        Random random = new Random();
        this.groupID = String.format("%08d", random.nextInt(100000000));
        this.groupName = groupName;
        ChatBean chat = new ChatBean();
        this.chatID = chat.getChatID();
        PoolBean pool = new PoolBean();
        //TEMPORARY POOL AMOUNT BEFORE ENTIRE FUNCTIONALITY.
        this.poolID = pool.getPoolID();
        pool.setTotalAmount(250);
        pool.setAmountRemaining(250);
        this.setPoolTotalAmount(250);
        this.setAmountRemaining(250);

        addGroupToDB();
    }

    //Already existing GroupBean
    public GroupBean(String id, String name, String chatID, String poolID){
        this.groupID = id;
        this.groupName = name;
        this.chatID = chatID;
        this.poolID = poolID;
    }

    public void addGroupToDB(){
        String query = "INSERT INTO GROUPS VALUES (?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.groupID);
            statement.setString(2, this.groupName);
            statement.setString(3, this.chatID);
            statement.setString(4, this.poolID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

    }

    public String getGroupID(){
        return this.groupID;
    }

    public static LinkedList<GroupBean> getGroups(LinkedList<String> groupIDs){
        LinkedList<GroupBean> groups = new LinkedList<>();

        int size = groupIDs.size();
        String query = "SELECT * FROM GROUPS WHERE [groupID] = ?";

        for(int i = 0; i < size; i++){
            try {
                Connection connection = ConfigBean.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                String tempID = groupIDs.pop();

                statement.setString(1, tempID);
                ResultSet result = statement.executeQuery();

                while (result.next()){
                    String id = result.getString(1);
                    String groupName = result.getString(2);
                    String chatID = result.getString(3);
                    String poolID = result.getString(4);

                    GroupBean group = new GroupBean(id, groupName, chatID, poolID);
                    groups.add(group);
                }
                groupIDs.addLast(tempID);
                statement.close();
                connection.close();
            }
            catch(SQLException e){
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
        }

        return groups;
    }

    public String getGroupName(){
        return this.groupName;
    }

    public static GroupBean getGroup(String name) {
        String query = "SELECT * FROM GROUPS WHERE [groupName] = ?";
        String id = "", groupName = "", chatID = "", poolID = "";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, name);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                id = result.getString(1);
                groupName = result.getString(2);
                chatID = result.getString(3);
                poolID = result.getString(4);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return new GroupBean(id, groupName, chatID, poolID);
    }

    public static void deleteGroup(String id){

        String query = "DELETE FROM GROUPS WHERE [groupID] = ?";
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

    public LinkedList<MessageBean> getChat(String chatID){
        return getChatMessages(chatID);
    }

    public String getChatID(){
        return this.chatID;
    }

    public void setPoolTotalAmount(double total){
        String query = "UPDATE POOL SET [totalAmount] = ? WHERE [poolID] = ?";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setDouble(1, total);
            statement.setString(2, this.poolID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public void setAmountRemaining(double remaining){
        String query = "UPDATE POOL SET [amountRemaining] = ? WHERE [poolID] = ?";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setDouble(1, remaining);
            statement.setString(2, this.poolID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public boolean depositToPool(double amount){
        //Update the remaining amount to the new value.
        double amountRemaining = getAmountRemaining(this.poolID);
        double newAmountRemaining = amountRemaining - amount;

        //If the value is less than 0, then the amount is excessive.
        if(newAmountRemaining < 0){
           return false;
        }

        String query = "UPDATE POOL SET [amountRemaining] = ? WHERE [poolID] = ?";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setDouble(1, newAmountRemaining);
            statement.setString(2, this.poolID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return true;
    }

    public PoolBean getPool(){
        String query = "SELECT * FROM POOL WHERE [poolID] = ?";
        String poolID ="";
        double total = 0, remaining = 0;
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.poolID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                poolID = result.getString(1);
                total = result.getDouble(2);
                remaining = result.getDouble(3);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return new PoolBean(poolID, total, remaining);

    }

    public void withDrawFromPool(){
        //remove PoolDeposit rows from db.
        //get the total amount of money from the db that the user deposited
        //update the remaining pool to add this value.
    }

}
