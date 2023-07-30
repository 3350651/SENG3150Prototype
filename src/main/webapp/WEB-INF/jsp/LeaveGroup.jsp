<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
UserBean user = (UserBean) session.getAttribute("userBean");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>

        <header>
            <div class="titleContainer">
             <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Leave Group</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

<div id="addMemberFormContainer">
        <div><b>Are you sure you want to leave the group?</b></div>
                <form method="POST" action="GroupHomepage">
                   <button class="groupButton" type="submit" name="confirmLeaveGroup" value="true">Yes, leave group</button>
                   <input type="hidden" name="memberID" value="<%=user.getUserID()%>">
                </form>
                <form method="GET" action="GroupHomepage">
                   <button class="groupButton" type="submit">Cancel</button>
                </form>
            </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>