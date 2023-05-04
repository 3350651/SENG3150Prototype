package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = { "/AccountSettings" })
public class AccountSettings extends HttpServlet {


	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher = null;

		// send the user to an unauthorised page if they try to access the homepage without being logged in.
		if (session.getAttribute("userBean") == null){
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Unauthorised.jsp");
			requestDispatcher.forward(request, response);
		}

		// gets the user object and their role from the session object.
		UserBean user = (UserBean) session.getAttribute("userBean");

		requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings.jsp");

		requestDispatcher.forward(request, response);
	}

	/**
	 * Handles POST requests for the logout button, home button and admin functionality
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// logout button

	}
}
