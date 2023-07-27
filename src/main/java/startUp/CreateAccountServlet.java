/**
 * FILE NAME: CreateAccountServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for creation of user accounts
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
import java.time.LocalDate;

@WebServlet(urlPatterns = { "/CreateAccount" })
public class CreateAccountServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = null;
		RequestDispatcher requestDispatcher = null;

		requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/CreateAccount.jsp");
		requestDispatcher.forward(request, response);
	}

	/**
	 * Handles POST requests for the logout button, home button and admin functionality
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// add user form
		if (request.getParameter("addUser") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String phoneNumber = request.getParameter("phoneNumber");
			String role = request.getParameter("role");
			String address = request.getParameter("address");
			String defaultSearch = request.getParameter("defaultSearch");
			String defaultCurrency = request.getParameter("defaultCurrency");
			String defaultTimeZone = request.getParameter("defaultTimeZone");
			String themePreference = request.getParameter("themePreference");
			String questionnaireCompleted = request.getParameter("questionnaireCompleted");
			LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));

			UserBean user = new UserBean(firstName, lastName, email, password, phoneNumber, role, address,
					defaultSearch, defaultCurrency, defaultTimeZone, themePreference, questionnaireCompleted, dateOfBirth);

			user.addUserToTheSystem(firstName, lastName, email, password, phoneNumber, role, address, defaultSearch, defaultCurrency, defaultTimeZone, themePreference, questionnaireCompleted, dateOfBirth);
			requestDispatcher.forward(request, response);
		}
		else{
			HttpSession session = request.getSession();
			RequestDispatcher requestDispatcher = null;
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/CreateAccount.jsp");
			requestDispatcher.forward(request, response);
		}
	}

}