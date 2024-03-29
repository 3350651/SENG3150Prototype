/**
 * FILE NAME: LoginPageServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for managing log in and log out attempts
 */

package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(urlPatterns = { "/login" })
public class LoginPageServlet extends HttpServlet {

	/**
	 * Forwards the user to the login page
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.setAttribute("destinationCodes", new DestinationOptionsBean());
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
		requestDispatcher.forward(request, response);
	}

	/**
	 * Takes the username and password from the login form and cross checks those details with the database.
	 * If successful, a user object will be added to their session, and they will be logged in.
	 * If unsuccessful, they will be sent back to the login page to try again.
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher;

		String buttonValue = request.getParameter("logOutButton");
		if(buttonValue != null){
			request.getSession().invalidate();
			response.sendRedirect("Homepage");
		}
		else {
			String email = request.getParameter("email");
			String password = request.getParameter("password");

			UserBean user = new UserBean();
			user.login(email, password);

			if (user.getHasLogin()) {
				session.setAttribute("userBean", user);
				response.sendRedirect(request.getContextPath() + "/Homepage");
			} else {
				requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Login-Failed.jsp");
				requestDispatcher.forward(request, response);
			}
		}
	}

}
