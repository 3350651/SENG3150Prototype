package startUp;

import java.io.Serializable;
import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

/**
 * The user Bean which contains all the details of the user.
 * 
 * @author Jordan Eade c3350651
 * @author Lucy Knight c3350691
 * @author Ahmed Al-khazraji c3277545
 * @author Jason Walls c3298757
 */
public class UserBean implements Serializable {

	private boolean hasLogin;
	private String userID;
	private String fname;
	private String lname;
	private String email;
	private String userPassword;
	private String phoneNo;
	private String role;
	private String address;
	private String defaultSearch;
	private String defaultCurrency;
	private String defaultTimeZone;
	private String themePreference;
	private String questionnaireCompleted;
	private LocalDate dateOfBirth;
	private LinkedList<String> tagSet;
	private LinkedList<FlightBean> bookmarkedFlights;
	// private LinkedList<Searches> savedSearches
	// private LinkedList<Groups> groups
	// private LinkedList<Tags> tags
	// private LinkedList<Destinations> favouriteDestinations

	public UserBean() {
	}

	/**
	 * Constructor which will instantiate a new user with the argument details.
	 */
	public UserBean(String newFirstName, String newLastName, String newEmail, String newUserPassword, String newPhoneNo,
			String newRole) {
		Random random = new Random();
		this.userID = String.format("%08d", random.nextInt(100000000));
		this.fname = newFirstName;
		this.lname = newLastName;
		this.email = newEmail;
		this.userPassword = newUserPassword;
		this.phoneNo = newPhoneNo;
		this.role = newRole;
	}

	public UserBean(boolean hasLogin, String userID, String fname, String lname, String email, String userPassword,
			String phoneNo, String role, String address, String defaultSearch, String defaultCurrency,
			String defaultTimeZone, String themePreference, String questionnaireCompleted, LocalDate dateOfBirth) {
		this.hasLogin = hasLogin;
		this.userID = userID;
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.dateOfBirth = dateOfBirth;
		this.userPassword = userPassword;
		this.phoneNo = phoneNo;
		this.role = role;
		this.address = address;
		this.defaultSearch = defaultSearch;
		this.defaultCurrency = defaultCurrency;
		this.defaultTimeZone = defaultTimeZone;
		this.themePreference = themePreference;
		this.questionnaireCompleted = questionnaireCompleted;
		this.tagSet = new LinkedList<>();
		this.bookmarkedFlights = new LinkedList<>();
	}

	public UserBean(String fname, String lname, String email, String userPassword, String phoneNo, String role,
			String address, String defaultSearch, String defaultCurrency, String defaultTimeZone,
			String themePreference, String questionnaireCompleted, LocalDate dateOfBirth) {
		this.fname = fname;
		this.lname = lname;
		this.email = email;
		this.userPassword = userPassword;
		this.phoneNo = phoneNo;
		this.role = role;
		this.address = address;
		this.defaultSearch = defaultSearch;
		this.defaultCurrency = defaultCurrency;
		this.defaultTimeZone = defaultTimeZone;
		this.themePreference = themePreference;
		this.questionnaireCompleted = questionnaireCompleted;
		this.dateOfBirth = dateOfBirth;
		this.tagSet = new LinkedList<>();
		this.bookmarkedFlights = new LinkedList<>();
	}

	public Boolean isHasLogin() {
		return hasLogin;
	}

	public void setHasLogin(Boolean hasLogin) {
		this.hasLogin = hasLogin;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDefaultSearch() {
		return defaultSearch;
	}

	public void setDefaultSearch(String defaultSearch) {
		this.defaultSearch = defaultSearch;
	}

	public String getDefaultCurrency() {
		return defaultCurrency;
	}

	public void setDefaultCurrency(String defaultCurrency) {
		this.defaultCurrency = defaultCurrency;
	}

	public String getDefaultTimeZone() {
		return defaultTimeZone;
	}

	public void setDefaultTimeZone(String defaultTimeZone) {
		this.defaultTimeZone = defaultTimeZone;
	}

	public String getThemePreference() {
		return themePreference;
	}

	public void setThemePreference(String themePreference) {
		this.themePreference = themePreference;
	}

	public String isQuestionnaireCompleted() {
		return questionnaireCompleted;
	}

	public void setQuestionnaireCompleted(String questionnaireCompleted) {
		this.questionnaireCompleted = questionnaireCompleted;
	}

	public LocalDate getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(LocalDate dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public void setUserId(String newData) {
		this.userID = newData;
	}

	public void setFname(String newData) {
		this.fname = newData;
	}

	public void setLname(String newData) {
		this.lname = newData;
	}

	public void setEmail(String newData) {
		this.email = newData;
	}

	public void setUserPassword(String newData) {
		this.userPassword = newData;
	}

	public void setPhoneNo(String newData) {
		this.phoneNo = newData;
	}

	public void setRoleInSystem(String newData) {
		this.role = newData;
	}

	public Boolean getHasLogin() {
		return hasLogin;
	}

	public String getUserID() {
		return userID;
	}

	public String getFname() {
		return fname;
	}

	public String getLname() {
		return lname;
	}

	public String getEmail() {
		return email;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public String getRoleInSystem() {
		return role;
	}

	public String getQuestionnaireCompleted() {
		return questionnaireCompleted;
	}

	public LinkedList<String> getTagSet() {
		return tagSet;
	}

	public void setTagSet(LinkedList<String> tagSet) {
		this.tagSet = tagSet;
	}

	public void setHasLogin(boolean hasLogin) {
		this.hasLogin = hasLogin;
	}

	public LinkedList<FlightBean> getBookmarkedFlights() {
		return bookmarkedFlights;
	}

	public void setBookmarkedFlights(LinkedList<FlightBean> bookmarkedFlights) {
		this.bookmarkedFlights = bookmarkedFlights;
	}

	public void addBookmarkedFlight(FlightBean flight) {
		boolean tagExists = false;
		for (int i = 0; i < getBookmarkedFlights().size(); i++) {
			if (getBookmarkedFlights().get(i).equals(flight)) {
				tagExists = true;
				break;
			}
		}
		if (!tagExists) {
			getBookmarkedFlights().add(flight);
		}
	}

	public void removeBookmarkedFlight(FlightBean flight) {
		String airlineCodeToAdd = flight.getAirline();
		String flightNumberToAdd = flight.getFlightName();
		Timestamp departureTimeToAdd = flight.getFlightTime();
		for (int i = 0; i < getBookmarkedFlights().size(); i++) {
			String existingAirlineCode = getBookmarkedFlights().get(i).getAirline();
			String existingFlightNumber = getBookmarkedFlights().get(i).getFlightName();
			Timestamp existingDepartureTime = getBookmarkedFlights().get(i).getFlightTime();
			if (airlineCodeToAdd.equals(existingAirlineCode) && flightNumberToAdd.equals(existingFlightNumber)
					&& departureTimeToAdd.equals(existingDepartureTime)) {
				getBookmarkedFlights().remove(i);
				break;
			}
		}
	}

	public void addTag(String tag) {
		boolean tagExists = false;
		for (String s : getTagSet()) {
			if (s.equals(tag)) {
				tagExists = true;
				break;
			}
		}
		if (!tagExists) {
			getTagSet().add(tag);
		}
	}

	public void removeTag(String tag) {
		for (int i = 0; i < getTagSet().size(); i++) {
			if (getTagSet().get(i).equals(tag)) {
				getTagSet().remove(i);
				break;
			}
		}
	}

	/**
	 * Inserts a new user Bean with the argumented details into the database.
	 */
	public void addUserToTheSystem(String firstName, String lastName, String email, String password, String phoneNo,
			String role, String address, String defaultSearch, String defaultCurrency, String defaultTimeZone,
			String themePreference, String questionnaireCompleted, LocalDate dateOfBirth) {
		try {
			Random random = new Random();
			userID = String.format("%08d", random.nextInt(100000000));

			String query = "INSERT INTO USERS VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);

			statement.setString(1, userID);
			statement.setString(2, firstName);
			statement.setString(3, lastName);
			statement.setString(4, email);
			statement.setString(5, password);
			statement.setString(6, phoneNo);
			statement.setString(7, role);
			statement.setString(8, address);
			statement.setString(9, defaultSearch);
			statement.setString(10, defaultCurrency);
			statement.setString(11, defaultTimeZone);
			statement.setString(12, themePreference);
			statement.setString(13, questionnaireCompleted);
			statement.setDate(14, java.sql.Date.valueOf(dateOfBirth));

			statement.executeUpdate();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}
	}

	/**
	 * Checks if the argument username and password are in the database.
	 * If the username and password are in the database this method will assign the
	 * user Bean
	 * attributes with the ones found in the database.
	 */
	public void login(String email, String password) {
		try {
			String query = "SELECT * FROM USERS Where [email]=? AND [userPassword]=? ";
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, email);
			statement.setString(2, password);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				hasLogin = true;
				this.setUserId(result.getString("userID"));
				this.setFname(result.getString("first_name"));
				this.setLname(result.getString("last_name"));
				this.setEmail(result.getString("email"));
				this.setPhoneNo(result.getString("phoneNo"));
				this.setUserPassword(result.getString("userPassword"));
				this.setRoleInSystem(result.getString("roles"));
				this.setAddress(result.getString("address"));
				this.setDefaultSearch(result.getString("defaultSearch"));
				this.setDefaultCurrency(result.getString("defaultCurrency"));
				this.setDefaultTimeZone(result.getString("defaultTimeZone"));
				this.setThemePreference(result.getString("themePreference"));
				this.setQuestionnaireCompleted(result.getString("questionnaireCompleted"));
				this.setDateOfBirth(LocalDate.parse(result.getString("dateOfBirth")));
				this.setTagSet(new LinkedList<>());
				loadTags(result.getString("userID"));
				this.setBookmarkedFlights(new LinkedList<>());
				loadBookmarkedFlights(result.getString("userID"));
			}

			result.close();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}
	}

	public void loadTags(String userID) {
		try {
			String query = "SELECT tagName\n" +
					"FROM TAGS\n" +
					"INNER JOIN USERTAGS ON TAGS.tagID = USERTAGS.tagID\n" +
					"WHERE USERTAGS.userID = ?;";
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, userID);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				this.addTag(result.getString("tagName"));
			}

			result.close();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}
	}

	public void loadBookmarkedFlights(String userID) {
		try {
			String query = "SELECT *\n" +
					"FROM Flights\n" +
					"INNER JOIN USERBOOKMARKEDFLIGHTS ON Flights.AirlineCode = USERBOOKMARKEDFLIGHTS.AirlineCode\n" +
					"AND Flights.FlightNumber = USERBOOKMARKEDFLIGHTS.FlightNumber AND Flights.DepartureTime = USERBOOKMARKEDFLIGHTS.DepartureTime\n"
					+
					"WHERE USERBOOKMARKEDFLIGHTS.userID = ?;";
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, userID);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String airlineCodeToAdd = result.getString("AirlineCode");
				String flightNumberToAdd = result.getString("FlightNumber");
				String departureCode = result.getString("DepartureCode");
				if (result.getString("FlightNumber") != null) {
					String stopOverCode = result.getString("StopOverCode");
				}
				Timestamp departureTimeToAdd = result.getTimestamp("DepartureTime");
				FlightBean flightToAdd = new FlightBean(airlineCodeToAdd, flightNumberToAdd, departureTimeToAdd);
				this.addBookmarkedFlight(flightToAdd);
			}

			result.close();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}
	}

	/**
	 * Checks if the argument username exists in the database.
	 */
	public boolean isExist(String userName) {
		boolean isExist = false;
		try {
			String query = "SELECT * FROM USERS Where [email]=? ";
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, userName);
			ResultSet result = statement.executeQuery();

			if (result.next()) {
				result.close();
				statement.close();
				connection.close();
				isExist = true;
			}

			result.close();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}

		return isExist;
	}

	/**
	 * Removes an account from the database depending on the argumented id.
	 */
	public static void removeUserFromSystem(String id) {
		String query = "DELETE FROM USERS WHERE [userID]=?";
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, id);
			statement.executeUpdate();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}
	}

	/**
	 * Generates and returns an arraylist of all non-admin users in the database.
	 */
	public static ArrayList<UserBean> getNonAdminUsers() {
		String query = "SELECT * FROM USERS";
		ArrayList<UserBean> userList = new ArrayList<>();

		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String id = result.getString(1);
				String firstName = result.getString(2);
				String lastName = result.getString(3);
				String email = result.getString(4);
				String password = result.getString(5);
				String phoneNumber = result.getString(6);
				String role = result.getString(7);

				if (role.equals("admin")) {
					continue;
				}

				UserBean user = new UserBean(firstName, lastName, email, password, phoneNumber, role);
				user.setUserId(id);
				userList.add(user);
			}
			statement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return userList;
	}

	/**
	 * Edits the account details of the account with the argumented id.
	 * If an argument is empty then that field will not be updated.
	 */
	public static void editUser(String id, String firstName, String lastName, String email, String password,
			String phoneNo, String role) {
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = null;

			if (!firstName.equals("")) {
				String query = "UPDATE USERS SET [first_name] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, firstName);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!lastName.equals("")) {
				String query = "UPDATE USERS SET [last_name] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, lastName);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!email.equals("")) {
				String query = "UPDATE USERS SET [email] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, email);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!password.equals("")) {
				String query = "UPDATE USERS SET [userPassword] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, password);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!phoneNo.equals("")) {
				String query = "UPDATE USERS SET [phoneNo] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, phoneNo);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!role.equals("")) {
				String query = "UPDATE USERS SET [roles] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, role);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			assert statement != null;
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void updateUserPassword(String id, String password) {
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = null;

			if (!password.equals("")) {
				String query = "UPDATE USERS SET [userPassword] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);
				statement.setString(1, password);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			assert statement != null;
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void updatePersonalDetails(String id, String firstName, String lastName, String email, String address,
			String phoneNo, String defaultCurrency, String defaultTimezone, LocalDate dateOfBirth) {
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = null;
			if (!firstName.equals("")) {
				String query = "UPDATE USERS SET [first_name] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, firstName);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!lastName.equals("")) {
				String query = "UPDATE USERS SET [last_name] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, lastName);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!email.equals("")) {
				String query = "UPDATE USERS SET [email] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, email);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!address.equals("")) {
				String query = "UPDATE USERS SET [address] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, address);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!phoneNo.equals("")) {
				String query = "UPDATE USERS SET [phoneNo] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, phoneNo);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!defaultCurrency.equals("")) {
				String query = "UPDATE USERS SET [defaultCurrency] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, defaultCurrency);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!defaultTimezone.equals("")) {
				String query = "UPDATE USERS SET [defaultTimezone] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, defaultTimezone);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (dateOfBirth != null) {
				String query = "UPDATE USERS SET [dateOfBirth] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);

				statement.setDate(1, java.sql.Date.valueOf(dateOfBirth));
				statement.setString(2, id);
				statement.executeUpdate();
			}

			assert statement != null;
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void addToTagSet(String userID, String tagName) {
		String query = "INSERT INTO USERTAGS VALUES (?, ?, ?)";
		String tagID = "-1"; // initialize tagID to an invalid value

		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT tagID FROM TAGS WHERE tagName = ?");
			statement.setString(1, tagName);
			ResultSet result = statement.executeQuery();

			if (result.next()) {
				tagID = result.getString("tagID");
			}

			result.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (!tagID.equals("-1")) {
			try {
				Connection connection = ConfigBean.getConnection();
				PreparedStatement checkTag = connection
						.prepareStatement("SELECT * FROM USERTAGS WHERE userID = ? AND tagID = ?");
				checkTag.setString(1, userID);
				checkTag.setString(2, tagID);
				ResultSet resultSet2 = checkTag.executeQuery();
				checkTag.close();
				connection.close();
				if (resultSet2.next()) {
					resultSet2.close();
				} else {
					try {
						connection = ConfigBean.getConnection();
						PreparedStatement statement = connection.prepareStatement(query);
						Random random = new Random();
						String userTagsID = String.format("%08d", random.nextInt(100000000));
						statement.setString(1, userTagsID);
						statement.setString(2, tagID);
						statement.setString(3, userID);
						statement.executeUpdate();
						statement.close();
						connection.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

	public static void removeFromTagSet(String userID, String tagName) {
		String query = "DELETE FROM USERTAGS WHERE userID = ? AND tagID = ?";

		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement("SELECT tagID FROM TAGS WHERE tagName = ?");
			statement.setString(1, tagName);
			ResultSet result = statement.executeQuery();

			if (result.next()) {
				String tagID = result.getString("tagID");

				statement = connection.prepareStatement(query);
				statement.setString(1, userID);
				statement.setString(2, tagID);
				statement.executeUpdate();
				statement.close();
			}

			result.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void addToBookmarkedFlights(String userID, String airlineCode, String flightNumber,
			Timestamp departureTime) {
		String query = "INSERT INTO USERBOOKMARKEDFLIGHTS VALUES (?, ?, ?, ?, ?)";
		String tagID = "-1"; // initialize tagID to an invalid value

		try (Connection connection = ConfigBean.getConnection();
				PreparedStatement checkFlight = connection.prepareStatement(
						"SELECT * FROM USERBOOKMARKEDFLIGHTS WHERE userID = ? AND airlineCode = ? AND flightNumber = ? AND departureTime = ?");
				PreparedStatement insertStatement = connection.prepareStatement(query)) {

			checkFlight.setString(1, userID);
			checkFlight.setString(2, airlineCode);
			checkFlight.setString(3, flightNumber);
			checkFlight.setTimestamp(4, departureTime);

			try (ResultSet resultSet1 = checkFlight.executeQuery()) {
				if (resultSet1.next()) {
					// Flight already exists
					return;
				}
			}

			// Generate userBookmarkedFlightID
			Random random = new Random();
			String userBookmarkedFlightID = String.format("%08d", random.nextInt(100000000));

			insertStatement.setString(1, userBookmarkedFlightID);
			insertStatement.setString(2, userID);
			insertStatement.setString(3, airlineCode);
			insertStatement.setString(4, flightNumber);
			insertStatement.setTimestamp(5, departureTime);

			insertStatement.executeUpdate();

		} catch (SQLException e) {
			// Handle or log the exception
			e.printStackTrace();
		}
	}

	public static void removeFromBookmarkedFlights(String userID, String airlineCode, String flightNumber,
			Timestamp departureTime) {
		String query = "DELETE FROM USERBOOKMARKEDFLIGHTS WHERE userID = ? AND airlineCode = ? AND flightNumber = ? AND departureTime = ?";

		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, userID);
			statement.setString(2, airlineCode);
			statement.setString(3, flightNumber);
			statement.setTimestamp(4, departureTime);
			statement.executeUpdate();
			statement.close();

			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void updateUIPreferences(String id, String defaultSearch, String themePreference) {
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = null;

			if (!defaultSearch.equals("")) {
				String query = "UPDATE USERS SET [defaultSearch] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);
				statement.setString(1, defaultSearch);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!themePreference.equals("")) {
				String query = "UPDATE USERS SET [themePreference] = ? WHERE [userID] = ?";
				statement = connection.prepareStatement(query);
				statement.setString(1, themePreference);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			assert statement != null;
			statement.close();
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public LinkedList<String> getGroupIDs(String userID) {
		LinkedList<String> groupIDs = new LinkedList<>();

		String query = "SELECT groupID FROM USERGROUPS WHERE [userID] = ?";
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, userID);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String id = result.getString(1);
				groupIDs.add(id);
			}
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}

		return groupIDs;
	}

	public static String userExists(String email) {
		String userID = null;

		String query = "SELECT userID FROM USERS WHERE [email] = ?";
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);

			statement.setString(1, email);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				userID = result.getString(1);
			}
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}

		return userID;
	}

	public static String getUsersName(String userID) {
		String usersName = "";
		String query = "SELECT first_name, last_name FROM USERS WHERE [userID] = ?";
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);

			statement.setString(1, userID);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String fName = result.getString(1);
				String lName = result.getString(2);
				usersName = fName + " " + lName;
			}
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}
		return usersName;
	}

	public LinkedList<String> getTags(String userID) {
		LinkedList<String> tagSet = new LinkedList<>();

		String query = "SELECT * FROM USERTAGS WHERE [userID] = ?";
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, userID);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				String id = result.getString(1);
				tagSet.add(id);
			}
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(Arrays.toString(e.getStackTrace()));
		}

		return tagSet;
	}
}
