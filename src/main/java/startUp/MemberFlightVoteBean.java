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
    private double score;

    public MemberFlightVoteBean(){}

    public MemberFlightVoteBean(String groupID, String userID, String groupFaveFlightID, double vote){
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
            statement.setDouble(5, this.score);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }


    public static double getMembersVote(String groupID, String userID, String groupFaveFlightID){
        double score = 0;
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
                score = result.getDouble(1);
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


    public static double getFaveFlightScore(String groupID, String groupFaveFlightID){
        double score = 0;
        String query = "SELECT COUNT(score) FROM MEMBERFLIGHTVOTE WHERE [groupID] = ? AND " +
                " [groupFaveFlightID] = ?";
        try{
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, groupID);
            statement.setString(2, groupFaveFlightID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                score = result.getDouble(1);
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


}
