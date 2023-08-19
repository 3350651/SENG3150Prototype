package startUp;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class DestinationOptionsBean {

    private ArrayList<DestinationBean> destinations;
    private String selected;

    public DestinationOptionsBean() {
        destinations = new ArrayList<>();
        selected = null;
        getDBDestinations();
    }

    public DestinationOptionsBean(String selected) {
        destinations = new ArrayList<>();
        this.selected = selected;
        getDBDestinations();
    }

    public ArrayList<DestinationBean> getDestinations() {
        return destinations;
    }

    public void setDestinations(ArrayList<DestinationBean> destinationCodes) {
        this.destinations = destinationCodes;
    }

    public String getSelected() {
        return selected;
    }

    public void setSelected(String selected) {
        this.selected = selected;
    }

    public void getDBDestinations() {
        try {
            String query = "SELECT DestinationCode, Airport from Destinations";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet result = statement.executeQuery();

            // TODO:Retrieve min cost of flight...

            while (result.next()) {
                destinations.add(new DestinationBean(result.getString(1), result.getString(2)));
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(Arrays.toString(e.getStackTrace()));
        }
    }

}
