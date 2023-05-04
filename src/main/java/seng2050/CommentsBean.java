package seng2050;

import startUp.ConfigBean;
import startUp.UserBean;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedList;

public class CommentsBean implements Serializable {

  private String commentID;
  private String personID;
  private String description;
  private String issueID;
  private String personName;
  private String commentTime;
  private String commentDate;

  public CommentsBean() {
  }

  public void setCommentsID(String id) {
    this.commentID = id;
  }

  public void setPersonId(String pd) {

    personID = pd;
  }

  public void setDescription(String nd) {

    description = nd;
  }

  public void setIssueID(String id) {
    this.issueID = id;
  }

  public void setPersonName(String name) {
    this.personName = name;
  }

  public void setCommentTime(String time){
    this.commentTime = time;
  }

  public void setCommentDate(String date){
    this.commentDate = date;
  }

  public String getCommentID() {
    return this.commentID;
  }

  public String getPersonId() {
    return personID;
  }

  public String getDescription() {
    return description;
  }

  public String getIssueID() {
    return this.issueID;
  }

  public String getPersonName() {
    return this.personName;
  }

  public String getCommentTime(){
    return this.commentTime;
  }

  public String getCommentDate() {
    return this.commentDate;
  }


  public static LinkedList<CommentsBean> getAllComments(IssuesBean issue){

    LinkedList<CommentsBean> comments = new LinkedList<>();
    String query = "SELECT DISTINCT c.* FROM Comments c, Issues i " +
    "WHERE (c.issueID ='" + issue.getIssueId() + "')";


    try(Connection connection = ConfigBean.getConnection();

        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery(query);){
      while(result.next()){
        CommentsBean comment = new CommentsBean();
        comment.setCommentsID(result.getString(1));
        comment.setPersonId(result.getString(2));
        comment.setDescription(result.getString(3));
        comment.setIssueID(result.getString(4));
        comment.setCommentDate(result.getString(5));
        comment.setCommentTime(result.getString(6));

        comments.add(comment);
      }
    }
    catch(SQLException e){
      System.err.println(e.getMessage());
      System.err.println(e.getStackTrace());
    }

    return comments;
  }


  public void getAuthorName(){

    String query = "SELECT DISTINCT p.first_name, p.last_name FROM Person p JOIN Comments c ON (p.personID ='"+
             this.personID + "')";

    try(Connection connection = ConfigBean.getConnection();

        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery(query);){
      while(result.next()){
        this.setPersonName(result.getString(1) + " " + result.getString(2));
      }
    }
    catch(SQLException e){
      System.err.println(e.getMessage());
      System.err.println(e.getStackTrace());
    }

  }


  public static void addComment(IssuesBean issue, String description, UserBean person){

    Time time = new Time(System.currentTimeMillis());
    String t = time.toString();

    Date date = new Date(System.currentTimeMillis());
    String d = date.toString();


    try {
      String query = "INSERT INTO Comments VALUES (NEWID(), ?, ?, ?, ?, ?)";
      Connection connection = ConfigBean.getConnection();
      PreparedStatement statement = connection.prepareStatement(query);

      statement.setString(1, person.getUserID());
      statement.setString(2, description);
      statement.setString(3, issue.getIssueId());
      statement.setString(4, d);
      statement.setString(5, t);
      statement.executeUpdate();
      statement.close();
      connection.close();

    }
    catch(SQLException e){
      System.err.println(e.getMessage());
      System.err.println(e.getStackTrace());
      System.err.println("here");
    }

  }


  //Find a comment and delete it (associated with a certain issue).
  public static void findAndDeleteComment(IssuesBean issue, String commentID){

    CommentsBean comment;
    LinkedList<CommentsBean> allComments = getAllComments(issue);
    boolean found = false;

    while(!found && !allComments.isEmpty()){

      comment = allComments.remove();

      if(commentID.contains(comment.getCommentID())){
        deleteComment(comment);
        found = true;
      }
    }

  }


  //Delete a comment.
  public static void deleteComment(CommentsBean comment){

    String query = "DELETE FROM Comments WHERE commentsID='" + comment.getCommentID() + "'";

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

  public static void deleteAllComments(IssuesBean issue){

    String query = "DELETE FROM Comments WHERE issueID='" + issue.getIssueId() + "'";

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

}