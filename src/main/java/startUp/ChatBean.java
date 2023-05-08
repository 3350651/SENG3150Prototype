package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Random;

public class ChatBean implements Serializable {
    private String chatID;

    public ChatBean(){
        Random random = new Random();
        this.chatID = String.format("%08d", random.nextInt(100000000));

        addChatToDB();
    }

    public void addChatToDB(){
        String query = "INSERT INTO CHAT VALUES (?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.chatID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

    }

    public String getChatID(){
        return this.chatID;
    }

    public static LinkedList<MessageBean> getChatMessages(String chatID){

        LinkedList<MessageBean> messages = new LinkedList<>();

        String query = "SELECT * FROM MESSAGE WHERE [chatID] = ? ORDER BY messageTime";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, chatID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {

               String messageID = (result.getString(1));
               String chatId = (result.getString(2));
               String message = (result.getString(3));
               String messageTime = (result.getString(4));
               String userID = (result.getString(5));

               MessageBean aMessage = new MessageBean(messageID, chatId, message, messageTime, userID);
               messages.add(aMessage);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return messages;
    }

}
