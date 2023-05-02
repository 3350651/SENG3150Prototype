<%@ page import="webapp.PersonBean" %>
<%@ page import="webapp.IssuesBean" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
<%//getting issues to display from the servlet
    List<IssuesBean> userIssues = (List<IssuesBean>) session.getAttribute("sorted");
%>
    <main>
        
        <header>
            <div class="logoutContainer">
                <form method="POST" action="Homepage">
                    <button name="logout" value="logout">Logout</button>
                </form>
            </div>
            <div class="titleContainer">
                <h1>User Homepage</h1>
            </div>
        </header>


            <div class="issueContainer">
                <h2>Knowledge Base Articles</h2>

                <form name="sortIssues" action="issues" method="POST">
                    <button type="submit">Sort Issues by Status</button>
                    <input type="hidden" name="sort" value="true"/>
                </form>

                <!--If there are no issues then display a message to the user, otherwise, display all the
                    issues available to the user in the database-->
                <%  if(userIssues != null){
                    for(IssuesBean issue: userIssues){
                        if(issue.getIssueState().contains("WAITING ON THIRD PARTY") || issue.getIssueState().contains("COMPLETED")){%>
                <fieldset class="notification">
                    <h3><%=issue.getTitle()%></h3>
                    <section>
                        <p>Status: <%=issue.getIssueState()%><br>
                            Reported on: <%=issue.getDateReported()%>, <%=issue.getTimeReported()%></p>
                        <form name="viewIssue" action="issues" method="POST">
                            <button type="submit">View Issue</button>
                            <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                        </form>
                    </section>
                </fieldset>
                <%} else{%>
                <fieldset class="singleIssue">
                    <h3><%=issue.getTitle()%></h3>
                    <section>
                        <p>Status: <%=issue.getIssueState()%><br>
                            Reported on: <%=issue.getDateReported()%>, <%=issue.getTimeReported()%></p>
                        <form name="viewIssue" action="issues" method="POST">
                            <button type="submit">View Issue</button>
                            <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>
                        </form>
                    </section>
                </fieldset>
                <%}}} else{%>
                <fieldset>
                    <h3>No current issues in the database</h3>
                </fieldset>
                <%}%>
            </div>

            <div class="reportFormContainer">
                <fieldset>
                    <form name="report" id="report" method="POST" action="reportIssue" onsubmit="return reportForm()">

                        <label for="title">Title of Issue: </label>
                        <input type="text" name="title" id="title">
                        <br>

                        <label for="subCategory">Select the best fit for your issue: </label>
                        <select name="subCategory" id="subCategory">
                            <option value="">Please select an option...</option>
                            <option value="Cannot connect to internet">Cannot connect to internet</option>
                            <option value="Slow internet">Slow internet</option>
                            <option value="Constant internet dropouts">Constant internet dropouts</option>
                            <option value="Application slow to load">Software Issue</option>
                            <option value="Application won't load">Software Issue</option>
                            <option value="Computer has no power">Computer won't turn on</option>
                            <option value="Blue screen">Blue Screen</option>
                            <option value="Disk drive issue">Disk drive Issue</option>
                            <option value="peripherals">Issue with peripherals</option>
                            <option value="email send">Email won't send</option>
                            <option value="email receive">Cannot receive emails</option>
                            <option value="spam phishing email">Spam or phishing email</option>
                            <option value="Incorrect account details">Incorrect account details</option>
                            <option value="Password reset">Reset password</option>
                        </select>
                        <br>

                        <label for="location">Please enter your location. E.g. ES105.: </label>
                        <input type="text" name="location" id="location">
                        <br>

                        <input type="submit" value="Continue">

                        <input type="hidden" name="page" value="1">

                    </form>
                </fieldset>
            </div>


    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>