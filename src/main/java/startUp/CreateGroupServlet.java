package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(urlPatterns = { "/CreateGroup" })
public class CreateGroupServlet extends HttpServlet {
    /**
     * Handles GET requests made to the homepage, this servlet will forward the user to the
     * user, admin or staff homepage depending on their role.
     */
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher = null;

        // send the user to an unauthorised page if they try to access the homepage without being logged in.
        if (session.getAttribute("userBean") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/CreateGroup.jsp");
            requestDispatcher.forward(request, response);
        }

        requestDispatcher.forward(request, response);
    }



    /**
     * Handles POST requests for the logout button, home button and admin functionality
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        UserBean user = (UserBean) session.getAttribute("userBean");
        String userID = user.getUserID();

        // add user form
        if (request.getParameter("createGroup") != null) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/UserHomepage.jsp");
            String groupName = request.getParameter("groupName");

            user.createGroup(userID, groupName);
            requestDispatcher.forward(request, response);
        } else {
            session = request.getSession();
            RequestDispatcher requestDispatcher = null;
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/CreateAccount.jsp");
            requestDispatcher.forward(request, response);
        }
    }

}
