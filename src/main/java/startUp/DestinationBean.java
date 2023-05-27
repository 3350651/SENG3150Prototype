/**
 * FILE NAME: DestinationBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model Object for destinations of flights
 */

package startUp;

import java.sql.*;
import java.util.Arrays;
import java.util.LinkedList;

public class DestinationBean {

    private String destinationCode;
    private String destinationName;
    private String destinationDescription;
    private LinkedList<String> tags;
    private int reputationScore;
    LinkedList<String> codes;

    public DestinationBean()
    {
        destinationCode = null;
        destinationName = null;
        destinationDescription = null;
        tags = null;
        reputationScore = 0;
        codes = new LinkedList<>();
    }

    // constructors
    public DestinationBean(String newDestinationCode) {
        destinationCode = newDestinationCode;

        try {
            String query = "SELECT *" +
                    " FROM dbo.Destinations " +
                    " WHERE DestinationCode = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, newDestinationCode);

            ResultSet result = statement.executeQuery();
            while (result.next()) {
                destinationName = result.getString(2);
                // TODO: Add destinationDescription, tags and reputationScore here
//                tagSet t = new tagSet();
//                t.setDestinationTag(this);

                /*LinkedList<String> tlist = new LinkedList<>();
                String tag1 = result.getString(4);
                String tag2 = result.getString(5);
                String tag3 = result.getString(6);
                String tag4 = result.getString(7);
                String tag5 = result.getString(8);

                tlist.add(tag1);
                tlist.add(tag2);
                tlist.add(tag3);
                tlist.add(tag4);
                tlist.add(tag5);

                tags = tlist;*/
            }

            result.close();
            statement.close();
            connection.close();

        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }
    }

    public DestinationBean(String destination, String a) {
        destinationName = destination;

        try {
            String query = "SELECT *" +
                    " FROM Destinations " +
                    " WHERE Airport = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, destination);

            ResultSet result = statement.executeQuery();
            while (result.next()) {
                destinationCode = result.getString(1);
                // TODO: Add destinationDescription, tags and reputationScore here
                /*LinkedList<String> tlist = new LinkedList<>();
                String tag1 = result.getString(4);
                String tag2 = result.getString(5);
                String tag3 = result.getString(6);
                String tag4 = result.getString(7);
                String tag5 = result.getString(8);

                tlist.add(tag1);
                tlist.add(tag2);
                tlist.add(tag3);
                tlist.add(tag4);
                tlist.add(tag5);

                tags = tlist;*/
            }
            result.close();
            statement.close();
            connection.close();

        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
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

    public void getAllDestinations()
    {
        String query = "SELECT * FROM Destinations;";
        try (Connection connection = ConfigBean.getConnection(); Statement statement = connection.createStatement(); ResultSet result = statement.executeQuery(query);)
        {
            while (result.next())
            {
                String d = result.getString(1);
                codes.add(d);
            }

            result.close();
            statement.close();
            connection.close();
        } catch (SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        for (int i = 0; i < codes.size(); i++)
        {
            DestinationBean a = new DestinationBean(codes.get(i));
        }
    }


    // get destination

    // TODO: increment/decrement reputation score

}
