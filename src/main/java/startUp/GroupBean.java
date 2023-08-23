/**
 * FILE NAME: GroupBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for holding group information
 */

package startUp;

import java.io.Serializable;
import java.sql.*;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.Random;

import static startUp.ChatBean.getChatMessages;
import static startUp.PoolBean.*;
import static startUp.PoolDepositBean.getUsersPoolDeposits;
import static startUp.PoolDepositBean.withdrawDeposits;

public class GroupBean implements Serializable {

    private String groupID;
    private String groupName;
    private String poolID;
    private String questionnaireCompleted;
    private LinkedList<String> tagSet;

    public GroupBean(){
    }

    public GroupBean(String groupName){
        Random random = new Random();
        this.groupID = String.format("%08d", random.nextInt(100000000));
        this.groupName = groupName;
        PoolBean pool = new PoolBean();
        //TEMPORARY VALUES BEFORE FULL IMPLEMENTATION.
        this.poolID = pool.getPoolID();
        pool.setTotalAmount(250);
        pool.setAmountRemaining(250);
        this.setPoolTotalAmount(250);
        this.setAmountRemaining(250);
        this.questionnaireCompleted = "";
        this.tagSet = new LinkedList<>();

        addGroupToDB();
    }

    //Already existing GroupBean
    public GroupBean(String id, String name, String poolID){
        this.groupID = id;
        this.groupName = name;
        this.poolID = poolID;
        this.tagSet = new LinkedList<>();
    }

    public void addGroupToDB(){
        String query = "INSERT INTO GROUPS VALUES (?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.groupID);
            statement.setString(2, this.groupName);
            statement.setString(3, this.poolID);
            statement.setString(4, this.questionnaireCompleted);

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
                    String poolID = result.getString(3);

                    GroupBean group = new GroupBean(id, groupName, poolID);
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

    public static GroupBean getGroup(String groupID) {
        String query = "SELECT * FROM GROUPS WHERE [groupID] = ?";
        String id = "", groupName = "", poolID = "";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                id = result.getString(1);
                groupName = result.getString(2);
                poolID = result.getString(3);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        GroupBean group = new GroupBean(id, groupName, poolID);
        group.setTagSet(getTags(id));
        return group;
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

    public double withDrawFromPool(String userID){
        //get total amount user deposited in the pool.
        double amount = getUsersPoolDeposits(this.poolID, userID);

        //Update the remaining pool amount.
        addToRemainingPool(this.poolID, amount);

        //remove PoolDeposit rows from db.
        withdrawDeposits(this.poolID, userID);

        return amount;
    }

    public String getPoolID() {
        return poolID;
    }

    public boolean isPoolComplete(String poolID){
        double amountRemaining = getAmountRemaining(poolID);
        if(amountRemaining == 0){
            return true;
        }
        return false;

    }

    //Methods that are not currently used -- will be needed in full implementation.
    public String isQuestionnaireCompleted() {
        return questionnaireCompleted;
    }

    public void setQuestionnaireCompleted(String questionnaireCompleted) {
        this.questionnaireCompleted = questionnaireCompleted;
    }

    public String getQuestionnaireCompleted() {
        return questionnaireCompleted;
    }

    public LinkedList<String> getTagSet() {
        return tagSet;
    }

    public void setTagSet(LinkedList<String> tagSet) {
        this.tagSet = tagSet;
    }


    public void addTag(String tag) {
        boolean tagExists = false;
        for (String s : getTagSet()) {
            if (s.equals(tag)) {
                tagExists = true;
                break;
            }
        }
        if (!tagExists) {
            getTagSet().add(tag);
        }
    }

    public void removeTag(String tag) {
        for (int i = 0; i < getTagSet().size(); i++) {
            if (getTagSet().get(i).equals(tag)) {
                getTagSet().remove(i);
                break;
            }
        }
    }


    public static void addToTagSet(String groupID, String tagName) throws SQLException {
        String tagID = "-1"; // initialize tagID to an invalid value
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet result = null;
        ResultSet resultSet2 = null;

        // get the tag IDs for the relevant tags
        try {
            connection = ConfigBean.getConnection();
            statement = connection.prepareStatement("SELECT tagID FROM TAGS WHERE tagName = ?");
            statement.setString(1, tagName);
            result = statement.executeQuery();

            if (result.next()) {
                tagID = result.getString("tagID");
            }
            connection.close();
            statement.close();
            result.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (!tagID.equals("-1")) {
            try {
                connection = ConfigBean.getConnection();
                // check if user already has that tag saved
                PreparedStatement checkTag = connection.prepareStatement("SELECT * FROM GROUPTAGS WHERE groupID = ? AND tagID = ?");
                checkTag.setString(1, groupID);
                checkTag.setString(2, tagID);
                resultSet2 = checkTag.executeQuery();

                if (resultSet2.next()) {

                }
                else {
                    try {
                        PreparedStatement insertStatement = connection.prepareStatement("INSERT INTO GROUPTAGS VALUES (?, ?, ?)");
                        Random random = new Random();
                        String groupTagsID = String.format("%08d", random.nextInt(100000000));
                        insertStatement.setString(1, groupTagsID);
                        insertStatement.setString(2, tagID);
                        insertStatement.setString(3, groupID);
                        insertStatement.executeUpdate();
                        insertStatement.close();
                        connection.close();
                    }
                    catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                connection.close();
                resultSet2.close();
                resultSet2.close();
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void removeFromTagSet(String groupID, String tagName) {
        String query = "DELETE FROM GROUPTAGS WHERE groupID = ? AND tagID = ?";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement("SELECT tagID FROM TAGS WHERE tagName = ?");
            statement.setString(1, tagName);
            ResultSet result = statement.executeQuery();

            if (result.next()) {
                String tagID = result.getString("tagID");

                statement = connection.prepareStatement(query);
                statement.setString(1, groupID);
                statement.setString(2, tagID);
                statement.executeUpdate();
                statement.close();
            }

            result.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public static LinkedList<String> getTags(String groupID) {
        LinkedList<String> tagSet = new LinkedList<>();

        try {
            String query = "SELECT tagName\n" +
                    "FROM TAGS\n" +
                    "INNER JOIN GROUPTAGS ON TAGS.tagID = GROUPTAGS.tagID\n" +
                    "WHERE GROUPTAGS.groupID = ?;";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                tagSet.add(result.getString("tagName"));
            }

            result.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }

        return tagSet;
    }

}
