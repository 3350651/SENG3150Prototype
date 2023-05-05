package startUp;

import java.io.Serializable;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Random;
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

}
