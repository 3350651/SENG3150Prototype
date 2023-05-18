package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;


@WebServlet(urlPatterns = { "/Search" })
public class SearchServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockUp-Homepage-SimpleSearch-LoggedIn.jsp");
		requestDispatcher.forward(request, response);
	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserBean user = (UserBean) session.getAttribute("userBean");
		if (request.getParameter("saveParam") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockUp-Homepage-SimpleSearch-LoggedIn-SavedParam.jsp");
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
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockUp-Homepage-SimpleSearch-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("bookmark.x") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String airlineCode = request.getParameter("airlineCode");
			String flightNumber = request.getParameter("flightNumber");
			Timestamp departureTime = Timestamp.valueOf(request.getParameter("departureTime"));
			UserBean.addToBookmarkedFlights(id, airlineCode, flightNumber, departureTime); // adds to database with foreign keys, creates PK
			FlightBean f = new FlightBean(airlineCode, flightNumber, departureTime); // constructor searches for the remainder of flight information upon instantiation
			user.addBookmarkedFlight(f);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
			requestDispatcher.forward(request, response);
		}
//		if(request.getParameter("removeTags") != null){
//			String id = request.getParameter("userID"); // do this for all others as hidden form input
//			String airlineCode = request.getParameter("airlineCode");
//			String flightNumber = request.getParameter("flightNumber");
//			Timestamp departureTime = Timestamp.valueOf(request.getParameter("departureTime"));
//			UserBean.removeFromBookmarkedFlights(id, airlineCode, flightNumber, departureTime);
//			FlightBean f = new FlightBean(airlineCode, flightNumber, departureTime); // make this constructor search for the remainder of flight information upon instantiation
//			user.removeBookmarkedFlight(f);
//			session.setAttribute("userBean", user);
//			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
//			requestDispatcher.forward(request, response);
//		}
		if (request.getParameter("favourite") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockUp-Homepage-SimpleSearch-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}
		if (request.getParameter("add-to-list") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockUp-Homepage-SimpleSearch-LoggedIn.jsp");
			requestDispatcher.forward(request, response);
		}

		if (request.getParameter("recSearch") != null)
		{
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Mock-Rec-SearchResults.jsp");
			requestDispatcher.forward(request, response);
		}

	}

}
