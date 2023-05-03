package seng2050;

import startUp.PersonBean;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * The Edit User servlet which allows admin's to edit user accounts
 * @author Jordan Eade c3350651
 * @author Lucy Knight c3350691
 * @author Ahmed Al-khazraji c3277545
 * @author Jason Walls c3298757
 */
@WebServlet(urlPatterns = { "/EditUser" })
public class EditUserServlet extends HttpServlet {

    @Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/Unauthorised.jsp").forward(request,response);
    }

    /**
     * Handles POST requests made by the edit user form.
     * This method calls functions within the webapp.PersonBean class which communicate with the database
     * to update account details.
     */
    @Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getParameter("edit") != null) {
            RequestDispatcher requestDispatcher = null;
            PersonBean person = (PersonBean)request.getSession().getAttribute("personBean");

            // if a user that isn't logged in tries to access this page redirect them to an unauthorised page
            if (person == null){
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/views/Unauthorised.jsp");
                requestDispatcher.forward(request, response);
            }

            // forward the admin to the edit user form
            if (person.getRoleInSystem().equals("admin")){
                String id = request.getParameter("edit");
                request.getSession().setAttribute("editID", id);
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/views/EditUser.jsp");
                requestDispatcher.forward(request, response);
            } else {
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/views/Unauthorised.jsp");
                requestDispatcher.forward(request, response);
            }
        }
        
        // Update the account based on the details contained in the form
        else {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneNumber = request.getParameter("phoneNumber");
            String role = request.getParameter("role");

            PersonBean.editUser((String) request.getSession().getAttribute("editID"), firstName, lastName, email, password, phoneNumber, role);

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/views/AdminHomepage.jsp");
            requestDispatcher.forward(request, response);
        }
    }

}
