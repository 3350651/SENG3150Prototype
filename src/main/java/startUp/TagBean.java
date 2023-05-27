/**
 * FILE NAME: TagBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for tags - linked to destinations and users.
 */

package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Random;

public class TagBean implements Serializable{

    private String tagID;
    private String tagName;

    public TagBean(){
    }

    public TagBean(String tagName){
        Random random = new Random();
        this.tagID = String.format("%08d", random.nextInt(100000000));
        this.tagName = tagName;
        addTagToDB();
    }

    //Already existing TagBean
    public TagBean(String id, String name){
        this.tagID = id;
        this.tagName = name;
    }

    public void addTagToDB(){
        String query = "INSERT INTO TAGS VALUES (?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.tagID);
            statement.setString(2, this.tagName);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

    }

    public String getTagID(){
        return this.tagID;
    }

    public static LinkedList<TagBean> getTags(LinkedList<String> tagIDs){
        LinkedList<TagBean> tags = new LinkedList<>();

        int size = tagIDs.size();
        String query = "SELECT * FROM TAGS WHERE [tagID] = ?";

        for(int i = 0; i < size; i++){
            try {
                Connection connection = ConfigBean.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                String tempID = tagIDs.pop();

                statement.setString(1, tempID);
                ResultSet result = statement.executeQuery();

                while (result.next()){
                    String id = result.getString(1);
                    String tagName = result.getString(2);

                    TagBean tag = new TagBean(id, tagName);
                    tags.add(tag);
                }
                tagIDs.addLast(tempID);
                statement.close();
                connection.close();
            }
            catch(SQLException e){
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
        }
        return tags;
    }

    public static LinkedList<String> getAllTags(){
        LinkedList<String> tags = new LinkedList<>();

        String query = "SELECT tagName FROM TAGS";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();

            while (result.next()){
                String tagName = result.getString(1);

                String tag = new String(tagName);
                tags.add(tag);
            }
            statement.close();
            connection.close();
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return tags;
    }

    public String getTagName(){
        return this.tagName;
    }

    public static TagBean getTag(String name) {
        String query = "SELECT * FROM TAGS WHERE [tagName] = ?";
        String id = "", tagName = "";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, name);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                id = result.getString(1);
                tagName = result.getString(2);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return new TagBean(id, tagName);
    }

    public static void deleteTag(String id){

        String query = "DELETE FROM TAGS WHERE [tagID] = ?";
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
