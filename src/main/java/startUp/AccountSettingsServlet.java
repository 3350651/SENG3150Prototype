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
import java.time.LocalDate;

@WebServlet(urlPatterns = { "/AccountSettings" })
public class AccountSettingsServlet extends HttpServlet {


	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher;

		// send the user to an unauthorised page if they try to access the homepage without being logged in.
		if (session.getAttribute("userBean") == null){
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Unauthorised.jsp");
			requestDispatcher.forward(request, response);
		}

		// gets the user object and their role from the session object.
		UserBean user = (UserBean) session.getAttribute("userBean");

		requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");

		requestDispatcher.forward(request, response);
	}

	/**
	 * Handles POST requests for the logout button, home button and admin functionality
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserBean user = (UserBean) session.getAttribute("userBean");
		if (request.getParameter("submitQuestionnaire") != null) {
			//add tags based on the questionnaire results
			// save to user.LinkedList<Tag>
			//String tags = request.getParameter("tags");
			//UserBean.editTags((String) request.getSession().getAttribute("editID"), tags);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("changePassword") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String password = request.getParameter("newPassword");
			UserBean.updateUserPassword(id, password);
			user.setUserPassword(password);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("editPersonalDetails") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String firstName = request.getParameter("firstName");
			String lastName = request.getParameter("lastName");
			String email = request.getParameter("email");
			String address = request.getParameter("address");
			String phoneNumber = request.getParameter("phoneNumber");
			String defaultCurrency = request.getParameter("defaultCurrency");
			String defaultTimezone = request.getParameter("defaultTimezone");
			LocalDate dateOfBirth = LocalDate.parse(request.getParameter("dateOfBirth"));
			UserBean.updatePersonalDetails(id, firstName, lastName, email, address, phoneNumber, defaultCurrency, defaultTimezone, dateOfBirth);
			user.setFname(firstName);
			user.setLname(lastName);
			user.setEmail(email);
			user.setAddress(address);
			user.setPhoneNo(phoneNumber);
			user.setDefaultCurrency(defaultCurrency);
			user.setDefaultTimeZone(defaultTimezone);
			user.setDateOfBirth(dateOfBirth);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("updateUIPreferences") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String themePreference = request.getParameter("themePreference");
			String defaultSearch = request.getParameter("defaultSearch");
			UserBean.updateUIPreferences(id, defaultSearch, themePreference);
			user.setDefaultSearch(defaultSearch);
			user.setThemePreference(themePreference);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("addTags") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String[] tagValues = request.getParameterValues("tags[]");
			for (String tagValue : tagValues) {
				UserBean.addToTagSet(id, tagValue);
				user.addTag(tagValue);
			}
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("removeTags") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String[] tagValues = request.getParameterValues("tags[]");
			for (String tagValue : tagValues) {
				UserBean.removeFromTagSet(id, tagValue);
				user.removeTag(tagValue);
			}
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("addBookmarkedFlight") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String airlineCode = request.getParameter("airlineCode");
			String flightNumber = request.getParameter("flightNumber");
			Timestamp departureTime = Timestamp.valueOf(request.getParameter("departureTime"));
			UserBean.addToBookmarkedFlights(id, airlineCode, flightNumber, departureTime);
			FlightBean f = new FlightBean(airlineCode, flightNumber, departureTime); // make this constructor search for the remainder of flight information upon instantiation
			user.addBookmarkedFlight(f);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("removeBookmarkedFlight") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String airlineCode = request.getParameter("airlineCode");
			String flightNumber = request.getParameter("flightNumber");
			Timestamp departureTime = Timestamp.valueOf(request.getParameter("departureTime"));// adds to database with foreign keys, creates PK
			FlightBean f = new FlightBean(airlineCode, flightNumber, departureTime); // constructor searches for the remainder of flight information upon instantiation
			user.removeBookmarkedFlight(f);
			UserBean.removeFromBookmarkedFlights(id, airlineCode, flightNumber, departureTime);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("addFavouriteDestination") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String destinationCode = request.getParameter("destinationCode");
			UserBean.addToFavouritedDestinations(id, destinationCode);
			DestinationBean d = new DestinationBean(destinationCode); // TODO: make this constructor search for the remainder of flight information upon instantiation
			user.addFavouritedDestination(d);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("removeFavouritedDestination") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String destinationCode = request.getParameter("destinationCode");
			UserBean.removeFromFavouritedDestinations(id, destinationCode);
			DestinationBean d = new DestinationBean(destinationCode); // TODO: make this constructor search for the remainder of flight information upon instantiation
			user.removeFavouritedDestination(d);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("goToUIPreferences") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/EditUIPreferences.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("goToPersonalDetails") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/EditPersonalDetails.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("goToChangePassword") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ChangePassword.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("viewAccountSettings") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AccountSettings-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("goToModifyTags") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyTags.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("goToModifyBookmarkedFlights") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyBookmarkedFlights.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("goToModifyFavouritedDestinations") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyFavouritedDestinations.jsp");
			requestDispatcher.forward(request, response);
		}
	}
}
