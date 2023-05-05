package startUp;

import java.io.Serializable;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
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
}
