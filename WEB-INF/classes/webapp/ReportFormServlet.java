package webapp;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * The Report Form servlet which allows a user to submit issues.
 * @author Jordan Eade c3350651
 * @author Lucy Knight c3350691
 * @author Ahmed Al-khazraji c3277545
 * @author Jason Walls c3298757
 */
@WebServlet(urlPatterns = "/reportIssue")
public class ReportFormServlet extends HttpServlet {

    //get method is not used
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/Unauthorised.jsp").forward(req,resp);
    }

    /**
     * The doPost method provides all functions of this servlet. Firstly, it deals with input from a user or staff from their
     * homepage and produces the correct jsp for the category of issue selected. It then takes the input from the advanced
     * form and places all this information into a single string for the description. This satisfies the more detailed
     * collection of information requirement.
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        PersonBean person = (PersonBean)req.getSession().getAttribute("personBean");
        RequestDispatcher requestDispatcher = null;

        //if coming from the home page
        if(req.getParameter("page") != null) {
            //deal with input
            String title = req.getParameter("title");
            String subCategory = req.getParameter("subCategory");
            String location = req.getParameter("location");

            IssuesBean issue = new IssuesBean();

            issue.setTitle(title);
            issue.setSubCategory(subCategory);
            issue.setDescription(location);

            //save issue for later
            req.getSession().setAttribute("Issue", issue);

            //load next page with information
            requestDispatcher = req.getRequestDispatcher("/WEB-INF/views/AdvancedReportFormPage.jsp");
            requestDispatcher.forward(req, resp);
        }
        //otherwise coming from advanced report page
        else{
            IssuesBean issue = (IssuesBean) req.getSession().getAttribute("Issue");
             String str = "Location: "+issue.getDescription() + "<br>";

            //if network advanced report from put input into string
            if (issue.getSubCategory().equalsIgnoreCase("Cannot connect to internet") || issue.getSubCategory().equalsIgnoreCase("Slow internet") || issue.getSubCategory().equalsIgnoreCase("Constant internet dropouts")){
                str+="Browser: " + req.getParameter("browser") + " ver: "+req.getParameter("browserVer")+ "<br>" +
                        "External sites working? ";
                if(req.getParameter("externalSites").equalsIgnoreCase("false"))
                    str+="Yes<br>";
                else
                    str+="No<br>";
                str+="Internal sites working? ";
                if(req.getParameter("internalSites").equalsIgnoreCase("false"))
                    str+="Yes<br>";
                else
                    str+="No<br>";
                str+="Tried different browser? ";
                if(req.getParameter("differentBrowser") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";
                str+="Restarted computer? ";
                if(req.getParameter("restarted") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";
                str+="Error message: " + req.getParameter("errorMessage") + "<br>";
                str+="Internet Connection Method: " + req.getParameter("cableWifi") + "<br>";
                str+="Connection status: ";
                if(req.getParameter("levelWifiConnection") != null){
                    str+=req.getParameter("levelWifiConnection") + "<br>";
                }
                else{
                    if(Boolean.parseBoolean(req.getParameter("showConnection")))
                        str+= "Connected<br>";
                    else
                        str+="None<br>";
                }
                str+="Devices effected: " + req.getParameter("numDevicesEffected");
                issue.setCategory("Network issue");
            }
            //if software advanced report from put input into string
            else if (issue.getSubCategory().equalsIgnoreCase("Application slow to load") || issue.getSubCategory().equalsIgnoreCase("Application won't load")) {
                str+="Problem application: " + req.getParameter("problemApplication") + " Version: " + req.getParameter("versionApplication") + "<br>";
                str+="Operating System: " + req.getParameter("operatingSystem") + "<br>";
                str+="Restarted: ";
                if(req.getParameter("restarted") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";

                str+="Other software effected: ";
                if(req.getParameter("otherSoftware") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";
                issue.setCategory("Software Issue");
            }
            //if computer no power advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("Computer has no power")){

                str+="Device charged? ";
                if(req.getParameter("charged") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";
                str+="Make and model: " + req.getParameter("makeModel") + "<br>";
                str+="Age of device: " + req.getParameter("age") + "<br>";
                str+="Device making sounds? " + req.getParameter("sounds" + "<br>");
                str+="Where does device reach on start up? " + req.getParameter("startup");
                issue.setCategory("Hardware Issue");
            }
            //if blue screen advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("Blue screen")){

                str+="Make and model: " + req.getParameter("makeModel") + "<br>";
                str+="Age of device: " + req.getParameter("age") + "<br>";
                str+="Operating System: " + req.getParameter("operatingSystem") + "<br>";
                str+="Events before 'Blue screen': " + req.getParameter("priorBlueScreen") + "<br>";
                str+="Is computer responsive? " + req.getParameter("response");
                issue.setCategory("Hardware Issue");
            }
            //if disk drive advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("Disk drive issue")){
                str+="Make and model: " + req.getParameter("makeModel") + "<br>";
                str+="Age of device: " + req.getParameter("age") + "<br>";
                str+="Error message: " + req.getParameter("errorMessage") + "<br>";
                str+="Other information: " + req.getParameter("other");
                issue.setCategory("Hardware Issue");
            }
            //if peripherals advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("peripherals")){
                str+="Peripheral device effected: " + req.getParameter("peripheralsEffected") + "<br>";
                str+="Device connection type: " + req.getParameter("peripheralConnectionType") + "<br>";
                str+="Does peripheral device have power? ";
                if(req.getParameter("peripheralPower") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";
                issue.setCategory("Hardware Issue");
            }
            //if email send/receive advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("email send") || issue.getSubCategory().equalsIgnoreCase("email receive")){

                str+="Restarted: ";
                if(req.getParameter("restarted") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";
                str+="Email application: " + req.getParameter("emailApp") + "version: " + req.getParameter("emailAppVersion") + "<br>";
                str+="Device connected to internet: ";
                if(req.getParameter("internet") != null)
                    str+="Yes<br>";
                else
                    str+="No<br>";
                issue.setCategory("Email Issue");
            }
            //if spam/phishing advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("spam phishing email")){
                str+="Address of suspect: " + req.getParameter("spamAddress") + "<br>";
                str+="Category: " + req.getParameter("emailCategory");
                issue.setCategory("Email Issue");
            }
            //if incorrect details advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("Incorrect account details")){
                str+="Incorrect details: " + req.getParameter("details");
                issue.setCategory("Account Issue");
            }
            //if reset password advanced report from put input into string
            else if(issue.getSubCategory().equalsIgnoreCase("Password reset")){
                str+="Password: " + req.getParameter("password");
                issue.setCategory("Account Issue");
            }

            //current date and time
            Date date = new Date(System.currentTimeMillis());
            Time time = new Time(System.currentTimeMillis());
            //creating issue in the database
            try {
                String query = "INSERT INTO Issues VALUES (NEWID(), ?, ? , ?, ?, ?, NULL, ?, ?, NULL, ?, ?)";
                Connection connection = ConfigBean.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);

                statement.setString(1, person.getPersonID());
                statement.setString(2, "NEW");
                statement.setString(3, issue.getCategory());
                statement.setString(4, issue.getSubCategory());
                statement.setString(5, issue.getTitle());
                statement.setString(6, date.toString());
                statement.setString(7, time.toString());
                statement.setString(8, str);
                statement.setString(9, "0");

                statement.executeUpdate();
                statement.close();
                connection.close();

            } catch (SQLException e) {
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
            //sending list of issues to the staff or user homepage
            List<IssuesBean> staffIssues, userIssues = null;
            if(person.getRoleInSystem().equalsIgnoreCase("staff")) {
                staffIssues = IssuesBean.getIssuesForIT("SELECT * FROM Issues");
                req.getSession().setAttribute("sorted", staffIssues);
                req.getRequestDispatcher("/WEB-INF/views/StaffHomepage.jsp").forward(req, resp);
            }
            else
                userIssues = IssuesBean.getIssuesForUser("SELECT * FROM Issues", person);
                req.getSession().setAttribute("sorted", userIssues);
                req.getRequestDispatcher("/WEB-INF/views/UserHomepage.jsp").forward(req, resp);
        }
    }
}
