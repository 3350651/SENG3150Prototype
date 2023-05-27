<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">

<%
UserBean user = (UserBean) session.getAttribute("userBean");
GroupBean group = (GroupBean) session.getAttribute("group");
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
%>

<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>

        <header>

           <form name="returnHome" action="Homepage" method="POST">
                   <button class="groupButton" type="submit" name="home" value="true">Return to Home</button>
           </form>

            <div class="titleContainer">
             <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Group Homepage</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
            <%
            if(isAdmin){ %>
            <form name="manageGroup" action="ManageGroup" method="GET">
               <button class="groupButton" type="submit" name="manageGroup" value="manageGroup">Manage Group</button>
            </form>
            <%}%>
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

            <div>
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

            <div class="manageGroupContent">
            <div class="filledSection">
                <form name="groupFaveList" id="groupFaveList" method="POST" action="GroupHomepage">
                 <button class="groupButton" type="submit" name="getGroupFaveList" value="getGroupFaveList">Go to Group Favourite List</button>
                </form>
            </div>

            <!--Need to add button only when available, instead it should have window that says pool not available yet.-->
            <div  class="filledSection">
                <form name="pool" id="pool" method="POST" action="GroupHomepage">
                 <button class="groupButton" type="submit" name="getPool" value="getPool">Go to Money Pool</button>
                </form>
            </div>
            </div>
    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>