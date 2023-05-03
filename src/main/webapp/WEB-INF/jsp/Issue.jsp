<%@ page import="seng2050.IssuesBean" %>
<%@ page import="seng2050.CommentsBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.PersonBean" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    IssuesBean issue = (IssuesBean) session.getAttribute("issue");
    String authorName = (String) session.getAttribute("authorName");
    LinkedList<CommentsBean> comments = (LinkedList<CommentsBean>) session.getAttribute("comments");
    PersonBean person = (PersonBean) session.getAttribute("personBean");
%>

<html>
    <head>
        <title>Issue</title>
        <link rel="stylesheet" href="Style.css">
    </head>
    <body>

        <!--Home button-->
        <form name="returnHome" action="issues" method="POST">
            <button type="submit" name="return" value="true">Return to Home</button>
        </form>


        <h1>Viewing Issue</h1>

        <h2><%=issue.getTitle()%></h2>

        <p>Posted by: <%=authorName%></p>

        <p>Category: <%=issue.getCategory()%> | Subcategory: <%=issue.getSubCategory()%> |
            Date/time Reported: <%=issue.getDateReported()%>, <%=issue.getTimeReported()%></p>
        <p>
            Issue Description:<br>
            <%=issue.getDescription()%>
        </p>


        <div>
            <h3>Extra Details</h3>

            <p>Issue Status: <%=issue.getIssueState()%></p>

            <!--If the issue is COMPLETED then do the following-->
            <% if(issue.getIssueState().contains("COMPLETED")){ %>

                <!--If the person is a user, then they can accept the resolution or decline it-->
                <%if(person.getRoleInSystem().contains("user") || person.getPersonID().contains(issue.getPersonId())){%>
                    <form name="acceptResolution" action="issues" method="POST">
                        <button type="submit" name="accept" value="true">Accept Resolution</button>
                        <button type="submit" name="decline" value="true">Decline Resolution</button>
                        <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                    </form>
                <%}%>

            <p>
                Resolution Date: <%=issue.getDateSolved()%><br>
                Issue Resolution: <%=issue.getResolutionDetails()%>
            </p>

            <fieldset>
                <legend>Add Another Comment</legend>
                <form name="addComment" action="issues" method="POST" onsubmit="return commentValidation()">
                    <textarea name="newComment" id="newComment" cols="50" rows="10"></textarea>
                    <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                    <button type="submit">Post</button>
                </form>
            </fieldset>

            <!--If issue is NEW, IN PROGRESS or WAITING ON THIRD PARTY, do the following-->
            <% } else if(issue.getIssueState().contains("NEW") || issue.getIssueState().contains("IN PROGRESS")
            || issue.getIssueState().contains("WAITING ON THIRD PARTY")) {%>

            <!--If the issue is either IN PROGRESS or WAITING ON THIRD PARTY, the staff can change the state-->
            <% if(person.getRoleInSystem().contains("staff")){%>
                <% if(issue.getIssueState().contains("IN PROGRESS")){%>
                <form name="changeState" action="issues" method="POST">
                    <button type="submit" name="wftp" value="true">Waiting for Third Party</button>
                    <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                </form>
                <%} else if(issue.getIssueState().contains("WAITING ON THIRD PARTY")){%>
                <form name="changeState" action="issues" method="POST">
                    <button type="submit" name="inProgress" value="true">In Progress</button>
                    <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                </form>
                <%} else{%>
                <form name="changeState" action="issues" method="POST">
                    <button type="submit" name="inProgress" value="true">In Progress</button>
                    <button type="submit" name="wftp" value="true">Waiting for Third Party</button>
                    <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                </form>
                <%}%>
            <%}%>

            <fieldset>
                <legend>Add Another Comment</legend>
                <form name="addComment" action="issues" method="POST" onsubmit="return commentValidationA()">
                    <textarea name="newComment" id="newCommentA" cols="50" rows="10"></textarea>
                    <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                    <button type="submit">Post</button>
                </form>
            </fieldset>

            <fieldset>
                <legend>Provide Resolution</legend>
                <form name="resolveIssue" action="issues" method="POST" onsubmit="return resolveValidation()">
                    <textarea name="resolveIssue" id="resolveIssue" cols="50" rows="10"></textarea>
                    <button type="submit" name="resolve" value="true">Resolve</button>
                    <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                </form>
            </fieldset>

            <!--If the issue is in the Knowledge Base then do the following-->
            <%} else if(issue.getKBArticle()){ %>

                <p>
                    Resolution Date: <%=issue.getDateSolved()%><br>
                    Issue Resolution: <%=issue.getResolutionDetails()%>
                </p>
                <fieldset>
                    <legend>Add Another Comment</legend>
                    <form name="addComment" action="issues" method="POST" onsubmit="return commentValidationB()">
                        <textarea name="newComment" id="newCommentB" cols="50" rows="10"></textarea>
                        <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                        <button type="submit">Post</button>
                    </form>
                </fieldset>

            <!--If the issue is RESOLVED then do the following-->
            <%} else if(issue.getIssueState().contains("RESOLVED")){%>
                <p>
                    Resolution Date: <%=issue.getDateSolved()%><br>
                    Issue Resolution: <%=issue.getResolutionDetails()%>
                </p>

                <!--Staff may add a RESOLVED issue to the Knowledge Base-->
                <%if(!issue.getKBArticle() && person.getRoleInSystem().contains("staff")){%>
                    <form name="KB" action="issues" method="POST">
                        <button type="submit" name="KB" value="true">Add to Knowledge Base</button>
                        <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                    </form>
                <%}%>

                <fieldset>
                    <legend>Add Another Comment</legend>
                        <form name="addComment" action="issues" method="POST" onsubmit="return commentValidationC()">
                            <textarea name="newComment" id="newCommentC" cols="50" rows="10"></textarea>
                            <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                            <button type="submit">Post</button>
                        </form>
                </fieldset>
            <%}%>

        </div>

        <div id="commentContainer">
            <h3>Comments on Issue</h3>

            <!--All Comments belonging to an Issue are displayed. If the person is staff, they may delete a comment
            belonging to the Knowledge Base-->
            <%if(issue.getKBArticle() && person.getRoleInSystem().contains("staff")){%>
                <%
                    while(!comments.isEmpty()){
                        CommentsBean comment = comments.removeFirst();
                        comment.getAuthorName();
                %>
                    <fieldset>
                        <p>Comment Author: <%=comment.getPersonName()%></p>
                        <p>Post date & time: <%=comment.getCommentDate()%>, <%=comment.getCommentTime()%></p>
                        <p>
                            Comment Contents:<br>
                            <%=comment.getDescription()%>
                        </p>

                        <form name="deleteComment" action="issues" method="POST">
                            <button name="deleteComment" value="true">Delete this Comment</button>
                            <input type="hidden" name="commentID" value=/"<%=comment.getCommentID()%>"/>
                            <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                            <input type="hidden" name="deleteComment" value="true">
                        </form>
                    </fieldset>
                <%}%>
            <%} else {%>
                <%
                    while(!comments.isEmpty()){
                        CommentsBean comment = comments.removeFirst();
                        comment.getAuthorName();
                %>
                    <fieldset>
                        <p>Comment Author: <%=comment.getPersonName()%></p>
                        <p>Post date & time: <%=comment.getCommentDate()%>, <%=comment.getCommentTime()%></p>
                        <p>
                            Comment Contents:<br>
                        <%=comment.getDescription()%>
                        </p>
                    </fieldset>
                <%}%>
            <%}%>
        </div>
    </body>
    <script type="text/javascript" src="script.js"></script>
</html>
