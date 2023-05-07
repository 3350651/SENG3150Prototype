package startUp;

import java.io.Serializable;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Random;

public class GroupBean implements Serializable {

    private String groupID;
    private String groupName;

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

        addGroupToDB();
    }

    //Already existing GroupBean
    public GroupBean(String id, String name){
        this.groupID = id;
        this.groupName = name;
    }

    public void addGroupToDB(){
        String query = "INSERT INTO GROUPS VALUES (?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.groupID);
            statement.setString(2, this.groupName);

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

                    GroupBean group = new GroupBean(id, groupName);
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
        String id = "", groupName = "";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, name);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                id = result.getString(1);
                groupName = result.getString(2);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return new GroupBean(id, groupName);
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

}
