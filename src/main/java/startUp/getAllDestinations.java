package startUp;

import sun.security.krb5.internal.crypto.Des;

import javax.servlet.http.HttpServlet;
import java.sql.*;
import java.util.*;
import java.util.LinkedList;

public class getAllDestinations extends HttpServlet
{
    LinkedList<DestinationBean> destinations;
    LinkedList<String> codes;

    public getAllDestinations()
    {
        destinations = new LinkedList<>();
        codes = new LinkedList<>();
    }

    public void execute()
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
            destinations.add(a);
        }
    }
    public LinkedList<DestinationBean> getDestinations()
    {
        return this.destinations;
    }
}
