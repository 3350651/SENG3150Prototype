package startUp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

public class MessageBean {

    private String messageID;
    private String chatID;
    private String message;
    private String messageTime;

    public MessageBean(){
    }

    public MessageBean(String id, String chatID, String message, String time){
        this.messageID = id;
        this.chatID = chatID;
        this.message = message;
        this.messageTime = time;
    }

    public MessageBean(String chatID, String message){
        Random random = new Random();
        this.messageID = String.format("%08d", random.nextInt(100000000));
        this.chatID = chatID;
        this.message = message;
        this.messageTime = String.valueOf(System.currentTimeMillis());

        addMessageToDB();
    }

    //Add the message to the DB.
    public void addMessageToDB(){
        String query = "INSERT INTO MESSAGE VALUES (?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.messageID);
            statement.setString(2, this.chatID);
            statement.setString(3, this.message);

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

}
