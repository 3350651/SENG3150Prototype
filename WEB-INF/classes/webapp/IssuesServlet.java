package webapp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import static webapp.CommentsBean.findAndDeleteComment;
import static webapp.IssuesBean.*;


/**
 * Servlet used to determine the flow of the program, in terms of the issues being displayed in the list, and single
 * issues, depending on the person and their role in the system. The servlet maintains the database, by adding comments,
 * as well as changing the state of issues, allowing issues to be added to the knowledge base, and many more.
 * This servlet allows for a large amount of the webapps functionality.
 */
@WebServlet(urlPatterns = { "/issues" })
public class IssuesServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/Unauthorised.jsp").forward(request,response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        PersonBean person = (PersonBean) session.getAttribute("personBean");

        if(person.getRoleInSystem().contains("staff")) {

            //Variables taken from parameters and session attributes.
            boolean sort = Boolean.parseBoolean(request.getParameter("sort"));
            String issueID = request.getParameter("issueID");
            String newComment = request.getParameter("newComment");
            boolean inProgress = Boolean.parseBoolean(request.getParameter("inProgress"));
            boolean WFTP = Boolean.parseBoolean(request.getParameter("wftp"));
            boolean resolve = Boolean.parseBoolean(request.getParameter("resolve"));
            String resolution = request.getParameter("resolveIssue");
            boolean KB = Boolean.parseBoolean(request.getParameter("KB"));
            boolean returnHomepage = Boolean.parseBoolean(request.getParameter("return"));
            boolean accept = Boolean.parseBoolean(request.getParameter("accept"));
            boolean decline = Boolean.parseBoolean(request.getParameter("decline"));
            boolean deleteComment = Boolean.parseBoolean(request.getParameter("deleteComment"));
            String commentID = request.getParameter("commentID");

            //Return to the homepage.
            if(returnHomepage){
                List<IssuesBean> staffIssues = IssuesBean.getIssuesForIT("SELECT * FROM Issues");
                session.setAttribute("sorted", staffIssues);
                request.getRequestDispatcher("/WEB-INF/views/StaffHomepage.jsp").forward(request, response);
            }
            //Change status of issue.
            else if(inProgress && issueID != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setIssueState("IN PROGRESS");
                changeState(issue, "IN PROGRESS");
                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //Change status again.
            else if(WFTP && issueID != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setIssueState("WAITING ON THIRD PARTY");
                changeState(issue, "WAITING ON THIRD PARTY");

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //Give the issue a resolution.
            else if(resolve && issueID != null && resolution != null){

                IssuesBean issue = IssuesBean.getIssue(issueID);
                if(issue.getPersonId().contains(person.getPersonID())){
                    issue.setIssueState("RESOLVED");
                    changeState(issue, "RESOLVED");
                    addResolution(issue, resolution);
                }
                else {
                    issue.setIssueState("COMPLETED");
                    changeState(issue, "COMPLETED");
                    addResolution(issue, resolution);
                }

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //Add issue to the knowledge base.
            else if(KB && issueID != null){

                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setKBArticle(1);
                addIssueToKB(issue);

                CommentsBean.deleteAllComments(issue);

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //Then a new comment has been added.
            else if(issueID != null && newComment != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                session.setAttribute("issue", issue);

                CommentsBean.addComment(issue, newComment, person);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //Find and delete a comment.
            else if(deleteComment && commentID != null && issueID != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                findAndDeleteComment(issue, commentID);

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //If the staff member that created the issue has accepted the resolution for their issue, then make the issue resolved.
            else if(accept && issueID != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setIssueState("RESOLVED");
                changeState(issue, "RESOLVED");

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //If the staff member that created the issue has rejected the resolution for their issue.
            else if(decline && issueID != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setIssueState("IN PROGRESS");
                changeState(issue, "IN PROGRESS");
                issue.setKBArticle(0);
                removeIssueFromKB(issue);
                removeResolution(issue);

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //Staff wants to view a single issue.
            else if (!sort && issueID != null) {
                IssuesBean issue = IssuesBean.getIssue(issueID);
                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //The staff want to order the issues.
            else if (sort) {
                List<IssuesBean> staffIssues = IssuesBean.getIssuesForIT("SELECT * FROM Issues " +
                        "ORDER BY CASE WHEN issueState = 'NEW' THEN '1' " +
                        "WHEN issueState = 'IN PROGRESS' THEN '2' " +
                        "WHEN issueState = 'WAITING ON THIRD PARTY' THEN '3' " +
                        "WHEN issueState = 'COMPLETED' THEN '4' " +
                        "ELSE issueState END, dateReported;");
                session.setAttribute("sorted", staffIssues);
                request.getRequestDispatcher("/WEB-INF/views/StaffHomepage.jsp").forward(request, response);
            }
            //Show the issues not in order.
            else if(!sort){
                List<IssuesBean> staffIssues = IssuesBean.getIssuesForIT("SELECT * FROM Issues");
                session.setAttribute("sorted", staffIssues);
                request.getRequestDispatcher("/WEB-INF/views/StaffHomepage.jsp").forward(request, response);
            }
        }

        //Otherwise, the person is a user.
        else if(person.getRoleInSystem().contains("user")){

            //Variables taken from parameters and session attributes.
            boolean sort = Boolean.parseBoolean(request.getParameter("sort"));
            String issueID = request.getParameter("issueID");
            boolean accept = Boolean.parseBoolean(request.getParameter("accept"));
            boolean decline = Boolean.parseBoolean(request.getParameter("decline"));
            boolean resolve = Boolean.parseBoolean(request.getParameter("resolve"));
            String resolution = request.getParameter("resolveIssue");
            boolean returnHomepage = Boolean.parseBoolean(request.getParameter("return"));
            String newComment = request.getParameter("newComment");

            //Return to the homepage.
            if(returnHomepage){
                List<IssuesBean> userIssues = IssuesBean.getIssuesForUser("SELECT * FROM Issues", person);
                session.setAttribute("sorted", userIssues);
                request.getRequestDispatcher("/WEB-INF/views/UserHomepage.jsp").forward(request, response);
            }
            //If the user has accepted the resolution for their issue, then make the issue resolved.
            else if(accept && issueID != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setIssueState("RESOLVED");
                changeState(issue, "RESOLVED");

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //If the user has rejected the resolution for their issue.
            else if(decline && issueID != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setIssueState("IN PROGRESS");
                changeState(issue, "IN PROGRESS");
                issue.setKBArticle(0);
                removeIssueFromKB(issue);
                removeResolution(issue);

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //The user has provided a resolution to the issue.
            else if(resolve && issueID != null && resolution != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                issue.setIssueState("RESOLVED");
                changeState(issue, "RESOLVED");
                addResolution(issue, resolution);

                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //A new comment has been added.
            else if(issueID != null && newComment != null){
                IssuesBean issue = IssuesBean.getIssue(issueID);
                session.setAttribute("issue", issue);

                CommentsBean.addComment(issue, newComment, person);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //The user wants to view a single issue.
            else if (!sort && issueID != null) {
                IssuesBean issue = IssuesBean.getIssue(issueID);
                session.setAttribute("issue", issue);

                String authorName = issue.getAuthorName(issue);
                session.setAttribute("authorName", authorName);

                //Get all comments relating to that Issue.
                LinkedList<CommentsBean> comments = CommentsBean.getAllComments(issue);
                session.setAttribute("comments", comments);

                request.getRequestDispatcher("/WEB-INF/views/Issue.jsp").forward(request, response);
            }
            //Sort issues in order based off category.
            else if (sort) {
                List<IssuesBean> staffIssues = IssuesBean.getIssuesForUser("SELECT * FROM Issues " +
                        "ORDER BY CASE WHEN issueState = 'NEW' THEN '1' " +
                        "WHEN issueState = 'IN PROGRESS' THEN '2' " +
                        "WHEN issueState = 'WAITING ON THIRD PARTY' THEN '3' " +
                        "WHEN issueState = 'COMPLETED' THEN '4' " +
                        "ELSE issueState END, dateReported;", person);
                session.setAttribute("sorted", staffIssues);
                request.getRequestDispatcher("/WEB-INF/views/UserHomepage.jsp").forward(request, response);
            }
            //Display all available issues in no order.
            else if(!sort){
                List<IssuesBean> userIssues = IssuesBean.getIssuesForUser("SELECT * FROM Issues", person);
                session.setAttribute("sorted", userIssues);
                request.getRequestDispatcher("/WEB-INF/views/UserHomepage.jsp").forward(request, response);
            }
        }

    }

}
