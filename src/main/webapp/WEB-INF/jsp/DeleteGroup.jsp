<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
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
                <h1>Delete Group</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

<div id="addMemberFormContainer">
        <div><b>ARE YOU SURE YOU WANT TO DELETE THE GROUP?</b></div>
                <form method="POST" action="ManageGroup">
                   <button class="groupButton" type="submit" name="confirmDeleteGroup" value="true">YES DELETE GROUP</button>
                </form>
                <form method="POST" action="ManageGroup">
                   <button class="groupButton" type="submit" name="confirmDeleteGroup" value="false">CANCEL</button>
                </form>
            </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>