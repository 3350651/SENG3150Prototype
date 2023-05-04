package seng2050;

import startUp.ConfigBean;
import startUp.UserBean;

import java.io.Serializable;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/***
 * This class provides methods and attributes associated with the Issues table in the database.
 * It allows for the addition, removal and manipulation of this data.
 */
public class IssuesBean implements Serializable {

	private String issueId;
	private String personId;
	private String issueState;
	private String category;
	private String subCategory;
	private String title;
	private String description;
	private String resolutionDetails;
	private String dateReported;
	private String timeReported;
	private String dateSolved;
	private ArrayList<CommentsBean> comments = new ArrayList<CommentsBean>();
	private String personName;
	private boolean KBArticle;

	public IssuesBean() {
	}

	public void setIssueId(String id) {
		this.issueId = id;
	}

	public void setPersonId(String id) {
		this.personId = id;
	}

	public void setIssueState(String i) {

		issueState = i;
	}

	public void setDescription(String d) {
		this.description = d;
	}

	public void setCategory(String c) {

		category = c;
	}

	public void setSubCategory(String s) {

		subCategory = s;
	}

	public void setTitle(String t) {

		title = t;
	}

	public void setResolutionDetails(String r) {

		resolutionDetails = r;
	}

	public void setDateReported(String dr) {

		dateReported = dr;
	}

	public void setTimeReported(String tr) {

		timeReported = tr;
	}

	public void setDateSolved(String ds) {

		dateSolved = ds;
	}

	public void setPersonName(String name) {
		this.personName = name;
	}

	public void setComments(ArrayList<CommentsBean> comments) {
		this.comments = comments;
	}

	public void setKBArticle(int i){
		//Issue is not in a KBArticle - false.
		if(i == 0){
			this.KBArticle = false;
		}
		else{
			this.KBArticle = true;
		}
	}

	public boolean getKBArticle(){
		return this.KBArticle;
	}

	public String getIssueId() {
		return issueId;
	}

	public String getPersonId() {
		return personId;
	}

	public String getDescription() {
		return description;
	}

	public String getIssueState() {

		return issueState;
	}

	public String getCategory() {

		return category;
	}

	public String getSubCategory() {

		return subCategory;
	}

	public String getTitle() {

		return title;
	}

	public String getResolutionDetails() {

		return resolutionDetails;
	}

	public String getDateReported() {

		return dateReported;
	}

	public String getTimeReported() {

		return timeReported;
	}

	public String getDateSolved() {

		return dateSolved;
	}


	public String getPersonName() {
		return this.personName;
	}


	/**
	 * This method returns all Issues in the database depending on the query being passed.
	 * This method is called when the person is a staff member.
	 * @param query
	 * @return List<webapp.IssuesBean>
	 */
	public static List<IssuesBean> getIssuesForIT(String query){

		LinkedList<IssuesBean> allIssues = new LinkedList<>();

		try(Connection connection = ConfigBean.getConnection();

			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(query);){
			while(result.next()){
				IssuesBean issue = new IssuesBean();
				issue.setIssueId(result.getString(1));
				issue.setPersonId(result.getString(2));
				issue.setIssueState(result.getString(3));
				issue.setCategory(result.getString(4));
				issue.setSubCategory(result.getString(5));
				issue.setTitle(result.getString(6));
				issue.setResolutionDetails(result.getString(7));
				issue.setDateReported(result.getString(8));
				issue.setTimeReported(result.getString(9));
				issue.setDateSolved(result.getString(10));
				issue.setDescription(result.getString(11));
				issue.setKBArticle(Integer.parseInt(result.getString(12)));

				allIssues.add(issue);
			}
		}
		catch(SQLException e){
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}

		return allIssues;
	}

	/**
	 * This method get the issues associated with the current user and the query being passed.
	 * @param query
	 * @param person
	 * @return LinkedList<webapp.IssuesBean>
	 */
	public static LinkedList<IssuesBean> getIssuesForUser(String query, UserBean person){

		LinkedList<IssuesBean> allIssues = (LinkedList<IssuesBean>) getIssuesForIT(query);
		LinkedList<IssuesBean> issuesForUser = new LinkedList<>();
		IssuesBean issue;

		//While there are issues, determine if they are in the knowledge base or if they are posted by the User.
		while(!allIssues.isEmpty()){

			issue = allIssues.remove();

			if(issue.getKBArticle() || issue.getPersonId().equalsIgnoreCase(person.getUserID())){
				issuesForUser.add(issue);
			}
		}
		return issuesForUser;
	}

	/**
	 * This method returns a single issue.
	 * @param issueID
	 * @return webapp.IssuesBean
	 */
	public static IssuesBean getIssue(String issueID){

		IssuesBean issue = new IssuesBean();
		LinkedList<IssuesBean> issues = (LinkedList<IssuesBean>) getIssuesForIT("SELECT * FROM Issues");
		boolean found = false;

		//Find the issue from all the issues in the database.
		while(!issues.isEmpty() && !found){
			issue = issues.remove();
			if(issueID.contains(issue.getIssueId())){
				found = true;
			}
		}
		return issue;
	}


	/**
	 * This method returns the name of the author that has posted a certain issue.
	 * @param issue
	 * @return String
	 */
	public String getAuthorName(IssuesBean issue){

		String query = "SELECT DISTINCT p.first_name, p.last_name FROM Person p RIGHT JOIN Issues i ON (p.personID ='" +
				issue.getPersonId() + "')";

		try(Connection connection = ConfigBean.getConnection();
			Statement statement = connection.createStatement();
			ResultSet result = statement.executeQuery(query);){
			while(result.next()){
				issue.setPersonName(result.getString(1) + " " + result.getString(2));
			}
		}
		catch(SQLException e) {
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}
		return issue.getPersonName();
	}


	/**
	 * This method changes the state or status of an issue in the database.
	 * @param issue
	 * @param state
	 */
	public static void changeState(IssuesBean issue, String state){

		String query = "UPDATE Issues SET issueState='" + state + "' WHERE issueID='" + issue.getIssueId() + "'";

		try{
			Connection connection = ConfigBean.getConnection();
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
			statement.close();
			connection.close();
		} catch(SQLException e){
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}

	}

	/**
	 * This method adds an issue to the knowledge base, within the database.
	 * @param issue
	 */
	public static void addIssueToKB(IssuesBean issue){

		String query = "UPDATE Issues SET KBArticle=1 WHERE issueID='" + issue.getIssueId() + "'";

		try{
			Connection connection = ConfigBean.getConnection();
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
			statement.close();
			connection.close();
		} catch(SQLException e){
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}
	}

	/**
	 * This method adds an issue to the knowledge base.
	 * @param issue
	 */
	public static void removeIssueFromKB(IssuesBean issue){

		String query = "UPDATE Issues SET KBArticle=0 WHERE issueID='" + issue.getIssueId() + "'";

		try{
			Connection connection = ConfigBean.getConnection();
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
			statement.close();
			connection.close();
		} catch(SQLException e){
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}
	}

	/**
	 * This method adds a resolution to an issue.
	 * @param issue
	 * @param resolution
	 */
	public static void addResolution(IssuesBean issue, String resolution){

		Date date = new Date(System.currentTimeMillis());
		String d = date.toString();

		String query = "UPDATE Issues SET resolutionDetails='" + resolution + "', dateSolved='" + d + "' WHERE issueID='"
				+ issue.getIssueId() + "'";

		try{
			Connection connection = ConfigBean.getConnection();
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
			statement.close();
			connection.close();
		} catch(SQLException e){
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}

		issue.setResolutionDetails(resolution);
		issue.setDateSolved(d);
	}

	/**
	 * This method removes a resolution from an issue (used if a user declines a resolution).
	 * @param issue
	 */
	public static void removeResolution(IssuesBean issue){

		String query = "UPDATE Issues SET resolutionDetails=NULL, dateSolved=NULL WHERE issueID='" +
				issue.getIssueId() + "'";

		try{
			Connection connection = ConfigBean.getConnection();
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
			statement.close();
			connection.close();
		} catch(SQLException e){
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
		}

		issue.setResolutionDetails(null);
		issue.setDateSolved(null);
	}

	/**
	 * This method determines the second statistic which is required to be displayed to the staff.
	 * @return int[]
	 */
	public static int[] getSecondStat(){

		String q1, q2, q3, q4, q5, q6, q7, q8, q9, q10;
		int results[] = new int[5];

		q1 = "ALTER TABLE Issues add resDate DATETIME2";
		q2 = "UPDATE Issues SET resDate = CONVERT(DATETIME, dateSolved, 101)";
		q3 = "SELECT COUNT(*) AS resolvedIssues FROM Issues WHERE issueState='RESOLVED' AND category='Software Issue' " +
				"AND resDate BETWEEN GETDATE()-7 AND GETDATE()";
		q4 = "SELECT COUNT(*) AS resolvedIssues FROM Issues WHERE issueState='RESOLVED' AND category='Network issue' " +
				"AND resDate BETWEEN GETDATE()-7 AND GETDATE()";
		q5 = "SELECT COUNT(*) AS resolvedIssues FROM Issues WHERE issueState='RESOLVED' AND category='Hardware issue' " +
				"AND resDate BETWEEN GETDATE()-7 AND GETDATE()";
		q6 = "SELECT COUNT(*) AS resolvedIssues FROM Issues WHERE issueState='RESOLVED' AND category='Email Issue' " +
				"AND resDate BETWEEN GETDATE()-7 AND GETDATE()";
		q7 = "SELECT COUNT(*) AS resolvedIssues FROM Issues WHERE issueState='RESOLVED' AND category='Account Issue' " +
				"AND resDate BETWEEN GETDATE()-7 AND GETDATE()";
		q8 = "ALTER TABLE Issues DROP COLUMN resDate";

		try{
			Connection connection = ConfigBean.getConnection();
			Statement statement = connection.createStatement();
			statement.executeUpdate(q1);
			statement.executeUpdate(q2);

			ResultSet result = statement.executeQuery(q3);
			if(result.next()) {
				results[0] = Integer.parseInt(result.getString(1));
			}
			result = statement.executeQuery(q4);
			if(result.next()) {
				results[1] = Integer.parseInt(result.getString(1));
			}

			result = statement.executeQuery(q5);
			if(result.next()) {
				results[2] = Integer.parseInt(result.getString(1));
			}

			result = statement.executeQuery(q6);
			if(result.next()) {
				results[3] = Integer.parseInt(result.getString(1));
			}

			result = statement.executeQuery(q7);
			if(result.next()) {
				results[4] = Integer.parseInt(result.getString(1));
			}

			statement.executeUpdate(q8);

			statement.close();
			connection.close();

		} catch(SQLException e){
			System.err.println(e.getMessage());
			System.err.println(e.getStackTrace());
			System.err.println("2nd");
		}

		return results;
	}


}
