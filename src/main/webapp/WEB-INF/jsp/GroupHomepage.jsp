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

        <jsp:include page='c-SimpleSearchBar.jsp'></jsp:include>

            <div class="sidebar">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                    alt="FlightPub Logo" class="logo">
                    <h2><%= group.getGroupName() %></h2>

             <form name="returnHome" action="Homepage" method="POST">
                               <button class="groupButton" type="submit" name="home" value="true">Return to Home</button>
                       </form>


                <%
                if(isAdmin){ %>
                <form name="manageGroup" action="ManageGroup" method="GET">
                   <button class="groupButton" type="submit" name="manageGroup" value="manageGroup">Manage Group</button>
                </form>
                <%}%>

                <div class = "GroupActions">
                    <div class="filledSection">
                        <form name="groupFaveList" id="groupFaveList" method="POST" action="GroupHomepage">
                         <button class="groupButton" type="submit" name="getGroupFaveList" value="getGroupFaveList">Group Favourite List</button>
                        </form>
                    </div>

                    <!--Need to add button only when available, instead it should have window that says pool not available yet.-->
                    <div class="filledSection">
                        <form name="pool" id="pool" method="POST" action="GroupHomepage">
                         <button class="groupButton" type="submit" name="getPool" value="getPool">Money Pool</button>
                        </form>
                    </div>

                    <div class="filledSection">
                        <form name="calendar" id="calendar" method="POST" action="GroupHomepage">
                         <button class="groupButton" type="submit" name="getCalendar" value="getCalendar">Group Calendar</button>
                        </form>
                    </div>
                </div>
            </div>
    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>