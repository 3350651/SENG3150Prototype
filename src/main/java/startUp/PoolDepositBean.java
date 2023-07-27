/**
 * FILE NAME: FlightBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model object for holding the information about a deposit made into the group money pool
 */

package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class PoolDepositBean implements Serializable {
    private String poolDepositID;
    private String poolID;
    private String userID;
    private double amount;

    public PoolDepositBean(String poolID, String userID, double amount){
        Random random = new Random();
        this.poolDepositID = String.format("%08d", random.nextInt(100000000));
        this.poolID = poolID;
        this.userID = userID;
        this.amount = amount;

        addPoolDepositToDB();
    }

    public void addPoolDepositToDB(){

        String query = "INSERT INTO POOLDEPOSIT VALUES (?, ?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.poolDepositID);
            statement.setString(2, this.poolID);
            statement.setString(3, this.userID);
            statement.setDouble(4, this.amount);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static void withdrawDeposits(String poolID, String userID){
        String query = "DELETE FROM POOLDEPOSIT WHERE [poolID] = ? AND [userID] = ?";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, poolID);
            statement.setString(2, userID);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public static double getUsersPoolDeposits(String poolID, String userID){
        String query = "SELECT SUM(amount) FROM POOLDEPOSIT WHERE [poolID] = ? AND [userID] = ?";
        double amount = 0;
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, poolID);
            statement.setString(2, userID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
               amount = result.getDouble(1);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return amount;
    }

    public static boolean hasMadeDeposit(String poolID, String userID){
        String query = "SELECT * FROM POOLDEPOSIT WHERE [poolID] = ? AND [userID] = ?";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, poolID);
            statement.setString(2, userID);
            ResultSet result = statement.executeQuery();

            if(result.next()) {
                return true;
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return false;
    }

    public static boolean poolDeposits(String poolID){
        String query = "SELECT * FROM POOLDEPOSIT WHERE [poolID] = ?";

        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, poolID);
            ResultSet result = statement.executeQuery();

            if(result.next()) {
                return true;
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return false;
    }
}
