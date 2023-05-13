<%@ page import="startUp.UserBean" %>
<!DOCTYPE html>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>
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
    <form name="returnHome" action="login" method="GET">
        <button type="submit" class="button" name="home" value="backToHome">Return to Home</button>
    </form>
<%--    Back to User Profile--%>
    <form method="POST" action="MockUpAccountSettings">
        <button name="viewAccountSettings" class="button" value="viewAccountSettings">Back to Account</button>
    </form>
    <%--        UI Preferences button         --%>
    <form name="goToUIPreferences" action="MockUpAccountSettings" method="POST">
        <button type="submit" class="button" name="goToUIPreferences" value="goToUIPreferences">Modify UI Preferences</button>
    </form>
    <%--        Personal Details button         --%>
    <form name="goToPersonalDetails" action="MockUpAccountSettings" method="POST">
        <button type="submit" class="button" name="goToPersonalDetails" value="goToPersonalDetails">Modify Personal Details</button>
    </form>
    <form name="goToModifyTags" action="MockUpAccountSettings" method="POST">
        <button type="submit" class="button" name="goToModifyTags" value="goToModifyTags">Modify Tags</button>
    </form>
</div>

<%--            Edit user form                 --%>
<div class="main-content">
    <p class="top-right">Joe Swanson</p>
<h1>Change Password</h1>
    <form method="POST" action="AccountSettings" onsubmit="">
        <label for="currentPassword">Current Password:</label>
        <input type="password" id="currentPassword" name="currentPassword" required><br>

        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required><br>

        <label for="confirmPassword">Confirm New Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br>

        <input type="hidden" name="userID" value="123456789">

        <button type="submit" name="changePassword" value="changePassword">Change Password</button>
    </form>
</div>
</body>

</html>