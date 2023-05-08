package startUp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class PoolBean {
    private String poolID;
    private double totalAmount;
    private double remainingAmount;

    public PoolBean(){
        Random random = new Random();
        this.poolID = String.format("%08d", random.nextInt(100000000));
        this.totalAmount = 0;
        this.remainingAmount = 0;

        addPoolToDB();
    }

    public void addPoolToDB(){
        String query = "INSERT INTO POOL VALUES (?, ?, ?)";
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, this.poolID);
            statement.setDouble(2, this.totalAmount);
            statement.setDouble(3, this.remainingAmount);

            statement.executeUpdate();
            statement.close();
            connection.close();
        }
        catch(SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
    }

    public PoolBean(String poolID, double totalAmount, double remainingAmount){
        this.poolID = poolID;
        this.totalAmount = totalAmount;
        this.remainingAmount = remainingAmount;
    }

    public static double getTotalAmount(String poolID){
        String query = "SELECT totalAmount FROM POOL WHERE [poolID] = ?";
        double total = 0;
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, poolID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                total = result.getDouble(1);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return total;
    }

    public static double getAmountRemaining(String poolID){
        String query = "SELECT amountRemaining FROM POOL WHERE [poolID] = ?";
        double remaining = 0;
        try {
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, poolID);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                remaining = result.getDouble(1);
            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return remaining;
    }

    public String getPoolID(){
        return this.poolID;
    }

  public double getTotalAmount(){
        return this.totalAmount;
  }

  public double getAmountRemaining(){
        return this.remainingAmount;
  }

  //KILL THIS WHEN IMPLEMENTATION IS DONE -- adds temporary total amount for all group pools.
  public void setTotalAmount(double total){
        this.totalAmount = total;
  }
}
