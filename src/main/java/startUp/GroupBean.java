package startUp;

import java.io.Serializable;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Random;

import static startUp.ChatBean.getChatMessages;

public class GroupBean implements Serializable {

    private String groupID;
    private String groupName;
    private String chatID;

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

        addGroupToDB();
    }

    //Already existing GroupBean
    public GroupBean(String id, String name, String chatID){
        this.groupID = id;
        this.groupName = name;
        this.chatID = chatID;
    }

    public void addGroupToDB(){
        String query = "INSERT INTO GROUPS VALUES (?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.groupID);
            statement.setString(2, this.groupName);
            statement.setString(3, this.chatID);

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

                    GroupBean group = new GroupBean(id, groupName, chatID);
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
        String id = "", groupName = "", chatID = "";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, name);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                id = result.getString(1);
                groupName = result.getString(2);
                chatID = result.getString(3);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return new GroupBean(id, groupName, chatID);
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

}
