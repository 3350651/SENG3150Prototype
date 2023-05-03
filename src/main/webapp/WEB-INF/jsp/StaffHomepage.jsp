<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="seng2050.IssuesBean"%>
<%@ page import="startUp.PersonBean" %>
<%@ page import="java.util.List" %>
<%
    List<IssuesBean> staffIssues = (List<IssuesBean>) session.getAttribute("sorted");
    PersonBean person = (PersonBean) request.getSession().getAttribute("personBean");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>startUp.Homepage</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <main>
        
        <header>

            <div>
                <form method="POST" action="Homepage">
                    <button name="logout" value="logout">Logout</button>
                </form>
                <form method="POST" action="stats" id="statsButton">
                    <button>View Statistics</button>
                </form>
            </div>
                <h1>Staff startUp.Homepage</h1>

        </header>

            <div>
                    <h2>All Issues in System</h2>

                    <form name="sortIssues" action="issues" method="POST">
                        <button type="submit">Sort Issues by Status</button>
                        <input type="hidden" name="sort" value="true"/>
                    </form><br>

                    <!--If there are no issues then display a message to the staff member, otherwise, display all the
                    issues in the database-->
                    <% if(staffIssues != null){
                        for(IssuesBean issue: staffIssues){
                    if((issue.getIssueState().contains("WAITING ON THIRD PARTY") || issue.getIssueState().contains("COMPLETED")) && issue.getPersonId().equalsIgnoreCase(person.getPersonID())){%>
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
                <%}else{%>
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

                <div>

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
                                <option value="Application slow to load">Application slow to load</option>
                                <option value="Application won't load">Application won't load</option>
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