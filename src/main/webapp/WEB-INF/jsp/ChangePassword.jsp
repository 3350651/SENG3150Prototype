<%@ page import="startUp.UserBean" %>
<!DOCTYPE html>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit user account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="sidebar">
    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
    <%--        Home page button         --%>
    <form name="returnHome" action="Homepage" method="POST">
        <button type="submit" class="button" name="home" value="true">Return to Home</button>
    </form>
<%--    Back to User Profile--%>
    <form method="POST" action="AccountSettings">
        <button name="viewAccountSettings" class="button" value="viewAccountSettings">Back to Account</button>
    </form>
    <%--        UI Preferences button         --%>
    <form name="goToUIPreferences" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToUIPreferences" value="goToUIPreferences">Modify UI Preferences</button>
    </form>
    <%--        Personal Details button         --%>
    <form name="goToPersonalDetails" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToPersonalDetails" value="goToPersonalDetails">Modify Personal Details</button>
    </form>
    <%--        Change Password button         --%>
    <form name="goToChangePassword" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToChangePassword" value="goToChangePassword">Change Password</button>
    </form>
</div>

<%--            Edit user form                 --%>
<div class="main-content">
<h1>Change Password</h1>
    <form method="POST" action="AccountSettings" onsubmit="return changePassword()">
           <label for="currentPassword">Current Password:</label>
           <input type="password" id="currentPassword" name="currentPassword"><br>

           <label for="newPassword">New Password:</label>
           <input type="password" id="newPassword" name="newPassword"><br>

           <label for="confirmPassword">Confirm New Password:</label>
           <input type="password" id="confirmPassword" name="confirmPassword"><br>

           <input type="hidden" name="userID" value="<%=user.getUserID()%>">

        <button type="submit" name="changePassword" value="changePassword">Change Password</button>
    </form>
</div>
</body>
<script type="text/javascript" src="webapp/javascript/script.js"></script>
</html>