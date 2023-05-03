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
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/LoginPage.jsp");
		requestDispatcher.forward(request, response);
	}

	/**
	 * Takes the username and password from the login form and cross checks those details with the database.
	 * If successful, a person object will be added to their session, and they will be logged in.
	 * If unsuccessful, they will be sent back to the login page to try again.
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher = null;

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		PersonBean person = new PersonBean();
		person.login(username, password);

		if (person.getHasLogin()) {
			session.setAttribute("personBean", person);
			response.sendRedirect(request.getContextPath() + "/Homepage");
		}
		else {
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/LoginPage-input.jsp");
			requestDispatcher.forward(request, response);
		}
	}

}
