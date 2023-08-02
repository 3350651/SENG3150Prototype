/**
 * FILE NAME: MemberFlightVoteBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for information about a members vote made on a favourited flight.
 */

package startUp;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class MemberFlightVoteBean {

    private String memberFlightVoteID;
    private String groupID;
    private String userID;
    private String groupFaveFlightID;
    private int score;

    public MemberFlightVoteBean(){}

    public MemberFlightVoteBean(String groupID, String userID, String groupFaveFlightID, int vote){
        Random random = new Random();
        this.memberFlightVoteID = String.format("%08d", random.nextInt(100000000));
        this.groupID = groupID;
        this.userID = userID;
        this.groupFaveFlightID = groupFaveFlightID;
        this.score = vote;

        addMemberFlightVoteToDB();
    }

    public void addMemberFlightVoteToDB(){
        String query = "INSERT INTO MEMBERFLIGHTVOTE VALUES (?, ?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.memberFlightVoteID);
            statement.setString(2, this.groupID);
            statement.setString(3, this.userID);
            statement.setString(4, this.groupFaveFlightID);
            statement.setInt(5, this.score);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }


    public static int getMembersVote(String groupID, String userID, String groupFaveFlightID){
        int score = 0;
        String query = "SELECT score FROM MEMBERFLIGHTVOTE WHERE [groupID] = ? AND [userID] = ? AND" +
                " [groupFaveFlightID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
            statement.setString(2, userID);
            statement.setString(3, groupFaveFlightID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                score = result.getInt(1);
            }

            statement.close();
            connection.close();
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return score;
    }


    public static int getFaveFlightScore(String groupID, String groupFaveFlightID){
        int score = 0;
        String query = "SELECT SUM(score) FROM MEMBERFLIGHTVOTE WHERE [groupID] = ? AND " +
                " [groupFaveFlightID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
            statement.setString(2, groupFaveFlightID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                score = result.getInt(1);
            }

            statement.close();
            connection.close();
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return score;
    }

    public static void updateMemberScore(String groupID, String groupFaveFlightID, String userID, int vote){
        String query = "UPDATE MEMBERFLIGHTVOTE SET [score] = ? WHERE [groupID] = ? AND [groupFaveFlightID] = ? AND [userID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setInt(1, vote);
            statement.setString(2, groupID);
            statement.setString(3, groupFaveFlightID);
            statement.setString(4, userID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    //Check if the member has already voted for that flight.
    public static boolean hasVoted(String groupFaveFlightID, String groupID, String userID){
        boolean hasVoted = false;
        String query =" SELECT * FROM MEMBERFLIGHTVOTE WHERE [groupID] = ? AND groupFaveFlightID = ? AND userID = ?";

        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
            statement.setString(2, groupFaveFlightID);
            statement.setString(3, userID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                hasVoted = true;
            }

            statement.close();
            connection.close();
        }
        catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return hasVoted;
    }

    public static void deleteMemberFlightVotes(String groupID, String groupFaveFlightID){
        String query = "DELETE MEMBERFLIGHTVOTE WHERE [groupID] = ? AND [groupFaveFlightID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, groupID);
            statement.setString(2, groupFaveFlightID);

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
