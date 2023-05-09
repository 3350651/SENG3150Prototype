package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import static startUp.UserBean.getUsersName;

public class MessageBean implements Serializable {

    private String messageID;
    private String chatID;
    private String message;
    private String messageTime;
    private String userID;

    public MessageBean(){
    }

    public MessageBean(String id, String chatID, String message, String time, String userID){
        this.messageID = id;
        this.chatID = chatID;
        this.message = message;
        this.messageTime = time;
        this.userID = userID;
    }

    public MessageBean(String chatID, String message, String userID){
        Random random = new Random();
        this.messageID = String.format("%08d", random.nextInt(100000000));
        this.chatID = chatID;
        this.message = message;
        //get current time
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date date = new Date();
        this.messageTime = formatter.format(date);
        this.userID = userID;

        addMessageToDB();
    }

    //Add the message to the DB.
    public void addMessageToDB(){
        String query = "INSERT INTO MESSAGE VALUES (?, ?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.messageID);
            statement.setString(2, this.chatID);
            statement.setString(3, this.message);
            statement.setString(4, this.messageTime);
            statement.setString(5, this.userID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public String getMessage(){
        return this.message;
    }

    public String getMessageTime(){
        return this.messageTime;
    }

    public String getUserName(){
        return getUsersName(this.userID);
    }

    public static void deleteMessages(String chatID){
        String query = "DELETE FROM MESSAGE WHERE [chatID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, chatID);

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
