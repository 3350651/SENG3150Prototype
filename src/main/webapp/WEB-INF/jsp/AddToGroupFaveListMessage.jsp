<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%
String message = (String) session.getAttribute("message");
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
                <h1>Group Update Message</h1>
            </div>
        </header>
        <div id="continueFormContainer">
        <div>
            <%= message %>
        </div>
            <form method="POST" action="GroupHomepage">
                <button class="groupButton" type="submit" name="addFlightContinue" value="continue">Continue</button>
            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>