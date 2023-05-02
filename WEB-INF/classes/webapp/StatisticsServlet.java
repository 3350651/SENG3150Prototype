package webapp;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@WebServlet(urlPatterns = "/stats")
public class StatisticsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/Unauthorised.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int results[] = new int[5];

        String issues[] = new String[5];
        issues[0] = "Network issue";
        issues[1] = "Software Issue";
        issues[2] = "Hardware Issue";
        issues[3] = "Email Issue";
        issues[4] = "Account Issue";


            try {
                Connection connection = ConfigBean.getConnection();
                Statement statement = connection.createStatement();
                for(int i=0; i< issues.length; i++) {
                    String query = "SELECT COUNT(*) AS unresolvedSoftwareIssues FROM Issues WHERE category='" + issues[i] + "' AND issueState!='RESOLVED'";
                    ResultSet result = statement.executeQuery(query);
                    if(result.next()) {
                        results[i] = result.getInt(1);
                    }
                }
                statement.close();
                connection.close();
            } catch (SQLException e) {
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }

        request.getSession().setAttribute("stat1", results);

        results = IssuesBean.getSecondStat();

        request.getSession().setAttribute("stat2", results);
        int numUnresolved = 0, numStaff = 0;


        try{
            String q1 = "SELECT COUNT(*) FROM Issues WHERE issueState!='RESOLVED'";
            String q2= "SELECT COUNT(*) FROM Person WHERE roles='staff'";
            Connection connection = ConfigBean.getConnection();
            Statement statement = connection.createStatement();

            ResultSet result = null;

            result = statement.executeQuery(q1);
            if(result.next()) {
                numUnresolved = result.getInt(1);
            }

            result = statement.executeQuery(q2);
            if(result.next()) {
                numStaff = result.getInt(1);
            }

            statement.close();
            connection.close();
        }catch(SQLException e){
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
            System.err.println("3rd");
        }

        double stressRate = numUnresolved/(double)(numStaff*5);

        request.getSession().setAttribute("stressRate", stressRate);

        request.getRequestDispatcher("/WEB-INF/views/Statistics.jsp").forward(request,response);

    }
}
