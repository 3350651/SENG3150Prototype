package startUp;

import java.io.*;
import java.time.LocalDate;
import java.util.LinkedList;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import static startUp.GroupBean.getGroup;
import static startUp.GroupBean.getGroups;
import static startUp.UserGroupsBean.isAdmin;

@WebServlet(urlPatterns = { "/Homepage" })
public class Homepage extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher = null;

		// send the user to an unauthorised page if they try to access the homepage
		// without being logged in.
		if (session.getAttribute("userBean") == null) {
			session.setAttribute("destinationCodes", new DestinationOptionsBean());
			requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
			requestDispatcher.forward(request, response);
		} else {
			// gets the person object and their role from the session object.
			UserBean user = (UserBean) session.getAttribute("userBean");
			String role = ((UserBean) session.getAttribute("userBean")).getRoleInSystem();
			String defaultSearch = ((UserBean) session.getAttribute("userBean")).getDefaultSearch();
			// Get groups that the user is in.
			LinkedList<String> groupIDs = user.getGroupIDs(user.getUserID());
			LinkedList<GroupBean> groups = getGroups(groupIDs);
			session.setAttribute("groups", groups);
			// sends the user to the correct homepage depending on their role

			// sends the user to the correct homepage depending on their role
			if (role.equals("user")) {


				// stuff to set and display groups for user.
				// LinkedList<String> groupIDs = user.getGroupIDs(user.getUserID());
				if (!groupIDs.isEmpty()) {

					if (request.getParameter("goGroup") != null) {
						String groupName = request.getParameter("groupName");
						GroupBean group = getGroup(groupName);
						session.setAttribute("group", group);
						Boolean isAdmin = isAdmin(user.getUserID(), group.getGroupID());
						session.setAttribute("isAdmin", isAdmin);

						requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepage.jsp");
						requestDispatcher.forward(request, response);
					}
					else{
						session.setAttribute("destinationCodes", new DestinationOptionsBean());
						requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
						requestDispatcher.forward(request, response);
					}
				} else {
					session.setAttribute("destinationCodes", new DestinationOptionsBean());
					requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
					requestDispatcher.forward(request, response);
				}
			} else if (role.equals("admin")) {
				requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/StaffHomepage.jsp");
			} else {
				System.out.println("Unknown role error: (webapp.Homepage.java)");
			}
		}
	}

	/**
	 * Handles POST requests for the logout button, home button and admin
	 * functionality
	 */
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// logout button
		if (request.getParameter("logout") != null) {
			request.getSession().invalidate();
			response.sendRedirect("login");
		}

		// home button
		if (request.getParameter("home") != null) {
			response.sendRedirect("Homepage");
		}

		// admin - add user form
		if (request.getParameter("addUser") != null) {
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/CreateAccount.jsp");
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
					defaultSearch, defaultCurrency, defaultTimeZone, themePreference, questionnaireCompleted,
					dateOfBirth);

			user.addUserToTheSystem(firstName, lastName, email, password, phoneNumber, role, address, defaultSearch,
					defaultCurrency, defaultTimeZone, themePreference, questionnaireCompleted, dateOfBirth);
			requestDispatcher.forward(request, response);
		}

		// admin - remove user
		if (request.getParameter("remove") != null) {
			UserBean.removeUserFromSystem(request.getParameter("remove"));
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AdminHomepage.jsp");
			requestDispatcher.forward(request, response);
		}

	}

}