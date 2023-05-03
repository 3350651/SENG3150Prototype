package startUp;

import seng2050.IssuesBean;
import startUp.PersonBean;

import java.io.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

/**
 * The homepage servlet which handles requests made to the homepage.
 * @author Jordan Eade c3350651
 * @author Lucy Knight c3350691
 * @author Ahmed Al-khazraji c3277545
 * @author Jason Walls c3298757
 */
@WebServlet(urlPatterns = { "/Homepage" })
public class Homepage extends HttpServlet {

	/**
	 * Handles GET requests made to the homepage, this servlet will forward the user to the
	 * user, admin or staff homepage depending on their role.
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher = null;

		// send the user to an unauthorised page if they try to access the homepage without being logged in.
		if (session.getAttribute("personBean") == null){
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Unauthorised.jsp");
			requestDispatcher.forward(request, response);
		}

		// gets the person object and their role from the session object.
		String role = ((PersonBean)session.getAttribute("personBean")).getRoleInSystem();
		PersonBean person = (PersonBean) session.getAttribute("personBean");

		// sends the user to the correct homepage depending on their role
		if (role.equals("user")){
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/UserHomepage.jsp");
		} else if (role.equals("admin")){
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/StaffHomepage.jsp");
		} else {
			System.out.println("Unknown role error: (webapp.Homepage.java)");
		}

		requestDispatcher.forward(request, response);
	}

	/**
	 * Handles POST requests for the logout button, home button and admin functionality
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// logout button
		if (request.getParameter("logout") != null){
			request.getSession().invalidate();
			response.sendRedirect("login");
		}

		// home button
		if(request.getParameter("home") != null){
			response.sendRedirect("Homepage");
		}

		// admin - add user form
		if (request.getParameter("addUser") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AdminHomepage.jsp");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String phoneNumber = request.getParameter("phoneNumber");
			String role = request.getParameter("role");

			PersonBean person = new PersonBean(firstName, lastName, email, password, phoneNumber, role);
			person.addUserToTheSystem(firstName, lastName, email, password, phoneNumber, role);
			requestDispatcher.forward(request, response);
		}

		// admin - remove user
		if (request.getParameter("remove") != null){
			PersonBean.removeUserFromSystem(request.getParameter("remove"));
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AdminHomepage.jsp");
			requestDispatcher.forward(request, response);
		}
	}

}