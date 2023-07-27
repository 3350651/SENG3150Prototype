<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="startUp.PoolBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
String message = (String) session.getAttribute("message");
PoolBean pool = (PoolBean) session.getAttribute("pool");
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
                <h1>Pool Update Message</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>
        <div id="addMemberFormContainer">
        <div>
            <%= message %>
        </div>
        <div id="continueFormContainer">
            <form method="POST" action="GroupHomepage">
                <button class="groupButton" type="submit" name="poolContinue" value="poolContinue">Continue</button>

            </form>
        </div>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>