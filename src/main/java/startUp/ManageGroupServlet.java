package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedList;
import javax.servlet.http.HttpServlet;

import static startUp.GroupBean.getGroups;
import static startUp.UserBean.userExists;

@WebServlet(urlPatterns = { "/ManageGroup" })
public class ManageGroupServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher = null;

        // send the user to an unauthorised page if they try to access the homepage without being logged in.
        if (session.getAttribute("userBean") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
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
        GroupBean group = (GroupBean) session.getAttribute("group");
        String groupID = group.getGroupID();

        //Admin has inputted email.
        if((request.getParameter("addMember") != null) && (request.getParameter("userEmail") != null)){
            String email = request.getParameter("userEmail");
            String addUserID = userExists(email);

            if(addUserID != null){
                //add to the group in the db.
                UserGroupsBean userGroupsBean = new UserGroupsBean(userID, groupID, false);
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
            }
            else{
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
                requestDispatcher.forward(request, response);
            }
        }

        if(request.getParameter("addMember") != null){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddMember.jsp");
            requestDispatcher.forward(request, response);
        }

    }
}
