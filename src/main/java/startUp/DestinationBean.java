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
    private String destinationCountry;
    private LinkedList<String> tags;
    private int reputationScore;

    public DestinationBean()
    {
        destinationCode = null;
        destinationName = null;
        destinationCountry = null;
        tags = null;
        reputationScore = 0;
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
                //tagSet t = new tagSet();
                //t.setDestinationTag(this);

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

    public DestinationBean(String code, String name) {
        destinationCode = code;
        destinationName = name;
    }

    public DestinationBean(String code, String name, String country) {
        destinationCode = code;
        destinationName = name;
        destinationCountry = country;
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

    public String getDestinationCountry() {
        return destinationCountry;
    }

    public void setDestinationCountry(String destinationCountry) {
        this.destinationCountry = destinationCountry;
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

    public LinkedList<DestinationBean> getDestinationsWith(LinkedList<TagBean> tags) {
        LinkedList<DestinationBean> destinations = new LinkedList<>();
        try {
            String query = "SELECT * FROM Destinations d " +
                    "WHERE  (SELECT COUNT(t.tagName) " +
                    "FROM DESTINATIONTAGS dt " +
                    "LEFT JOIN TAGS t ON t.tagID = dt.tagID " +
                    "WHERE dt.DestinationCode = d.DestinationCode " +
                    "AND t.tagName IN (?)) >=?";
            //TODO: first ? is list of tag names separated by commas. Second is the size of the list
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, getTagNames(tags));
            statement.setInt(2, tags.size());

            ResultSet result = statement.executeQuery();

            while (result.next()) {
                String code = result.getString(1);
                String name = result.getString(2);
                String country = result.getString(3);
                destinations.add(new DestinationBean(code, name, country));
            }
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            ex.printStackTrace();
        }
        return destinations;
    }

    private String getTagNames(LinkedList<TagBean> tags) {
        String result = "";
        for (int i = 0; i < tags.size(); i++) {
            if (i == tags.size() - 1) {
                result += tags.get(i).getTagName();
            } else {
                result += tags.get(i).getTagName() + ", ";
            }
        }
        return result;
    }


    // TODO: increment/decrement reputation score

}
