<%@ page import="startUp.PersonBean" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <main>
        
        <header>
            <div class="logoutContainer">
                <form method="POST" action="Homepage">
                    <button name="logout" value="logout">Logout</button>
                </form>
            </div>
            <div class="modifyAccountSettings">
                <form method="POST" action="AccountSettings">
                    <button name="logout" value="logout">Logout</button>
                </form>
            </div>
            <div class="titleContainer">
                <h1>User Homepage</h1>
            </div>
        </header>


            <div class="issueContainer">
                <h2>Flights</h2>

<%--                <form name="sortIssues" action="issues" method="POST">--%>
<%--                    <button type="submit">Sort Issues by Status</button>--%>
<%--                    <input type="hidden" name="sort" value="true"/>--%>
<%--                </form>--%>

                <!--If there are no issues then display a message to the user, otherwise, display all the
                    issues available to the user in the database-->
<%--                <%  if(userIssues != null){--%>
<%--                    for(IssuesBean issue: userIssues){--%>
<%--                        if(issue.getIssueState().contains("WAITING ON THIRD PARTY") || issue.getIssueState().contains("COMPLETED")){%>--%>
<%--                <fieldset class="notification">--%>
<%--                    <h3><%=issue.getTitle()%></h3>--%>
<%--                    <section>--%>
<%--                        <p>Status: <%=issue.getIssueState()%><br>--%>
<%--                            Reported on: <%=issue.getDateReported()%>, <%=issue.getTimeReported()%></p>--%>
<%--                        <form name="viewIssue" action="issues" method="POST">--%>
<%--                            <button type="submit">View Issue</button>--%>
<%--                            <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>--%>
<%--                        </form>--%>
<%--                    </section>--%>
<%--                </fieldset>--%>
<%--                <%} else{%>--%>
<%--                <fieldset class="singleIssue">--%>
<%--                    <h3><%=issue.getTitle()%></h3>--%>
<%--                    <section>--%>
<%--                        <p>Status: <%=issue.getIssueState()%><br>--%>
<%--                            Reported on: <%=issue.getDateReported()%>, <%=issue.getTimeReported()%></p>--%>
<%--                        <form name="viewIssue" action="issues" method="POST">--%>
<%--                            <button type="submit">View Issue</button>--%>
<%--                            <input type="hidden" name="issueID" value=/"<%=issue.getIssueId()%>"/>--%>
<%--                        </form>--%>
<%--                    </section>--%>
<%--                </fieldset>--%>
<%--                <%}}} else{%>--%>
<%--                <fieldset>--%>
<%--                    <h3>No current issues in the database</h3>--%>
<%--                </fieldset>--%>
<%--                <%}%>--%>
            </div>

            <div class="flightSearchContainer">
                <fieldset>
                    <form name="flightSearch" id="flightSearch" method="POST" action="flightSearch" onsubmit="return reportForm()">

                        <label for="destination">Destination:</label>
                        <input type="text" name="destination" id="destination">
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