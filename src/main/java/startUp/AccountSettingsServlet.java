/**
 * FILE NAME: AccountSettingsServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller to manage modifications to Account Settings/User Profiles
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
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.LinkedList;

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
		LinkedList<FlightPathBean> flightPath = (LinkedList<FlightPathBean>) session.getAttribute("flightResultList");

		if (request.getParameter("submitQuestionnaire") != null) {
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String[] travelGoals, valueAdds, locations;
			if (request.getParameterValues("travelGoals[]") != null) {
				travelGoals = request.getParameterValues("travelGoals[]");
			}
			else{
				travelGoals = new String[0];
			}
			if (request.getParameterValues("valueAdds[]") != null) {
				valueAdds = request.getParameterValues("valueAdds[]");
			}
			else{
				valueAdds = new String[0];
			}
			if (request.getParameterValues("locations[]") != null) {
				locations = request.getParameterValues("locations[]");
			}
			else{
				locations = new String[0];
			}

			for (String tagValue : travelGoals) {
				UserBean.addToTagSet(id, tagValue);
				user.addTag(tagValue);
			}
			for (String tagValue : locations) {
				UserBean.addToTagSet(id, tagValue);
				user.addTag(tagValue);
			}
			for (String tagValue : valueAdds) {
				UserBean.addToTagSet(id, tagValue);
				user.addTag(tagValue);
			}
			session.setAttribute("userBean", user);
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
			String[] tagValues = request.getParameterValues("tagsToAdd[]");
			for (String tagValue : tagValues) {
				UserBean.addToTagSet(id, tagValue);
				user.addTag(tagValue);
			}
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyTags.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("removeTags") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String[] tagValues = request.getParameterValues("tagsToRemove[]");
			for (String tagValue : tagValues) {
				UserBean.removeFromTagSet(id, tagValue);
				user.removeTag(tagValue);
			}
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyTags.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("addBookmarkedFlight") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			int index = Integer.parseInt(request.getParameter("flightIndex"));
			FlightPathBean fpb = flightPath.get(index);
			UserBean.addToBookmarkedFlights(id, fpb);
			user.addBookmarkedFlight(fpb);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("removeBookmarkedFlight") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String bookmarkedFlightID = request.getParameter("bookmarkedFlightID");
			UserBean.removeFromBookmarkedFlights(id, bookmarkedFlightID);
			int intBookmarkedFlightID = Integer.parseInt(bookmarkedFlightID);
			user.removeBookmarkedFlight(intBookmarkedFlightID);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyBookmarkedFlights.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("addFavouriteDestination") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String destinationCode = request.getParameter("destinationCode");
			UserBean.addToFavouritedDestinations(id, destinationCode);
			DestinationBean d = new DestinationBean(destinationCode);
			user.addFavouritedDestination(d);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("removeFavouritedDestination") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String destinationCode = request.getParameter("destinationCode");
			UserBean.removeFromFavouritedDestinations(id, destinationCode);
			DestinationBean d = new DestinationBean(destinationCode);
			user.removeFavouritedDestination(d);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyFavouritedDestination.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("removeSearchParameters") != null) {
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			int searchID = Integer.parseInt(request.getParameter("searchID"));
			UserBean.removeFromSavedSearches(id, searchID);
			user.removeSavedSearch(searchID);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifySavedSearches.jsp");
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
		if(request.getParameter("goToModifySavedSearches") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifySavedSearches.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("goToQuestionnaire") != null){
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Questionnaire.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("bookmark.x") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			int index = Integer.parseInt(request.getParameter("flightIndex"));
			FlightPathBean fpb = flightPath.get(index);
			UserBean.addToBookmarkedFlights(id, fpb);
			user.addBookmarkedFlight(fpb);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
			requestDispatcher.forward(request, response);
		}
		if(request.getParameter("favourite.x") != null){
			String id = request.getParameter("userID"); // do this for all others as hidden form input
			String destinationCode = request.getParameter("destinationCode");
			UserBean.addToFavouritedDestinations(id, destinationCode);
			DestinationBean d = new DestinationBean(destinationCode);
			user.addFavouritedDestination(d);
			session.setAttribute("userBean", user);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
			requestDispatcher.forward(request, response);
		}
	}
}
