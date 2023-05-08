package startUp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

public class DestinationBean {

    private String destinationCode;
    private String destinationName;
    private String destinationDescription;
    private LinkedList<String> tags;
    private int reputationScore;

    // constructors
    public DestinationBean(String newDestinationCode) {
        destinationCode = newDestinationCode;

        try {
            String query = "SELECT *" +
                    " FROM dbo.Destinations  " +
                    " WHERE DestinationCode = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, newDestinationCode);

            ResultSet result = statement.executeQuery();
            while (result.next()) {
                destinationName = result.getString("Airport");
                // TODO: Add destinationDescription, tags and reputationScore here

            }

        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    // getters

    public String getDestinationCode() {
        return destinationCode;
    }

    public void setDestinationCode(String destinationCode) {
        this.destinationCode = destinationCode;
    }

    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
    }

    public String getDestinationDescription() {
        return destinationDescription;
    }

    public void setDestinationDescription(String destinationDescription) {
        this.destinationDescription = destinationDescription;
    }

    public LinkedList<String> getTags() {
        return tags;
    }

    public void setTags(LinkedList<String> tags) {
        this.tags = tags;
    }

    public int getReputationScore() {
        return reputationScore;
    }

    public void setReputationScore(int reputationScore) {
        this.reputationScore = reputationScore;
    }

    // get destination

    // TODO: increment/decrement reputation score

}
