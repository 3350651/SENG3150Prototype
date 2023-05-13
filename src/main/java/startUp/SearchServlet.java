package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(urlPatterns = { "/Search" })
public class SearchServlet extends HttpServlet {

	/**
	 * Forwards the user to the login page
	 */
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch-LoggedIn.jsp");
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
		if (request.getParameter("saveParam") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch-LoggedIn-SavedParam.jsp");
			requestDispatcher.forward(request, response);
		}
		if (request.getParameter("searchLogged") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/SearchResults-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}
		if (request.getParameter("savedParameter") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/SearchResults-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}
		if (request.getParameter("backToHome") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}
		if (request.getParameter("bookmark.x") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/SearchResults-LoggedIn-ExtraBookmark.jsp");
			requestDispatcher.forward(request, response);
		}
		if (request.getParameter("favourite") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}
		if (request.getParameter("add-to-list") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}

		if (request.getParameter("recSearch") != null)
		{
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Mock-Rec-SearchResults.jsp");
			requestDispatcher.forward(request, response);
		}

	}

}
