package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * The Person Bean which contains all the details of the user.
 * @author Jordan Eade c3350651
 * @author Lucy Knight c3350691
 * @author Ahmed Al-khazraji c3277545
 * @author Jason Walls c3298757
 */
public class PersonBean implements Serializable {

	private boolean hasLogin;
	private String personID;
	private String fname;
	private String lname;
	private String email;
	private String userPassword;
	private String phoneNo;
	private String role;

	public PersonBean() {
	}

	/**
	 * Constructor which will instantiate a new person with the argument details.
	 */
	public PersonBean(String newFirstName, String newLastName, String newEmail, String newUserPassword, String newPhoneNo, String newRole) {
		this.fname = newFirstName;
		this.lname = newLastName;
		this.email = newEmail;
		this.userPassword = newUserPassword;
		this.phoneNo = newPhoneNo;
		this.role = newRole;
	}

	public void setHasLogin(Boolean newData) {
		this.hasLogin = newData;
	}

	public void setPersonId(String newData) {
		this.personID = newData;
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

	public boolean getHasLogin() {
		return hasLogin;
	}

	public String getPersonID() {
		return personID;
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

	/**
	 * Inserts a new Person Bean with the argumented details into the database.
	 */
	public void addUserToTheSystem(String firstName, String lastName, String email, String password, String phoneNo, String role) {
		try {
			String query = "INSERT INTO person VALUES (NEWID(), ?, ?, ?, ?, ?, ?)";
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);

			statement.setString(1, firstName);
			statement.setString(2, lastName);
			statement.setString(3, email);
			statement.setString(4, password);
			statement.setString(5, phoneNo);
			statement.setString(6, role);

			statement.executeUpdate();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}
	}

	/**
	 * Checks if the argument username and password are in the database.
	 * If the username and password are in the database this method will assign the Person Bean
	 * attributes with the ones found in the database.
	 */
	public void login(String userName, String password) {
		try {
			String query = "SELECT * FROM person Where [email]=? AND [userPassword]=? ";
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, userName);
			statement.setString(2, password);
			ResultSet result = statement.executeQuery();

			while (result.next()) {
				hasLogin = true;
				this.setPersonId(result.getString("personID"));
				this.setFname(result.getString("first_name"));
				this.setLname(result.getString("last_name"));
				this.setEmail(result.getString("email"));
				this.setPhoneNo(result.getString("phoneNo"));
				this.setUserPassword(result.getString("userPassword"));
				this.setRoleInSystem(result.getString("roles"));
			}
			
			result.close();
			statement.close();
			connection.close();
		}
		catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}
	}

	/**
	 * Checks if the argument username exists in the database.
	 */
	public boolean isExist(String userName) {
		boolean isExist = false;
		try {
			String query = "SELECT * FROM person Where [email]=? ";
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
			System.err.println(e.getStackTrace());
		}

		return isExist;
	}

	/**
	 * Removes an account from the database depending on the argumented id.
	 */
	public static void removeUserFromSystem(String id) {
		String query = "DELETE FROM person WHERE [personID]=?";
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			statement.setString(1, id);
			statement.executeUpdate();
			statement.close();
			connection.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}
	}

	/**
	 * Generates and returns an arraylist of all non-admin users in the database.
	 */
	public static ArrayList<PersonBean> getNonAdminUsers(){
		String query = "SELECT * FROM person";
		ArrayList<PersonBean> userList = new ArrayList<>();

		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = connection.prepareStatement(query);
			ResultSet result = statement.executeQuery();

			while (result.next()){
				String id = result.getString(1);
				String firstName = result.getString(2);
				String lastName = result.getString(3);
				String email = result.getString(4);
				String password = result.getString(5);
				String phoneNumber = result.getString(6);
				String role = result.getString(7);

				if (role.equals("admin")){
					continue;
				}
				
				PersonBean person = new PersonBean(firstName, lastName, email, password, phoneNumber, role);
				person.setPersonId(id);
				userList.add(person);
			}
			statement.close();
			connection.close();
		} catch (SQLException e){
			e.printStackTrace();
		}

		return userList;
	}

	/**
	 * Edits the account details of the account with the argumented id.
	 * If an argument is empty then that field will not be updated.
	 */
	public static void editUser(String id, String firstName, String lastName, String email, String password, String phoneNo, String role){
		try {
			Connection connection = ConfigBean.getConnection();
			PreparedStatement statement = null;

			if (!firstName.equals("")){
				String query = "UPDATE person SET [first_name] = ? WHERE [personID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, firstName);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!lastName.equals("")){
				String query = "UPDATE person SET [last_name] = ? WHERE [personID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, lastName);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!email.equals("")){
				String query = "UPDATE person SET [email] = ? WHERE [personID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, email);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!password.equals("")){
				String query = "UPDATE person SET [userPassword] = ? WHERE [personID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, password);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!phoneNo.equals("")){
				String query = "UPDATE person SET [phoneNo] = ? WHERE [personID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, phoneNo);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			if (!role.equals("")){
				String query = "UPDATE person SET [roles] = ? WHERE [personID] = ?";
				statement = connection.prepareStatement(query);

				statement.setString(1, role);
				statement.setString(2, id);
				statement.executeUpdate();
			}

			statement.close();
			connection.close();
		} catch (Exception e){
			e.printStackTrace();
		}
	}

}
