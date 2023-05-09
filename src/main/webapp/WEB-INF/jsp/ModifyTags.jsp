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
    <%--        Personal Details button         --%>
    <form name="goToPersonalDetails" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToPersonalDetails" value="goToPersonalDetails">Modify Personal Details</button>
    </form>
    <%--        UI Preferences button         --%>
    <form name="goToUIPreferences" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToUIPreferences" value="goToUIPreferences">Modify UI Preferences</button>
    </form>
    <%--        Change Password button         --%>
    <form name="goToChangePassword" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToChangePassword" value="goToChangePassword">Change Password</button>
    </form>
</div>

<div class="main-content">
<%--            Edit user form                 --%>
    <h1>Modify User Interface Preferences</h1>
    <form method="POST" action="AccountSettings" onsubmit="return modifyTags()">
        <input type="checkbox" id="tropical" name="tags[]" value="12341234">
        <label for="tropical">Tropical</label><br>
        <input type="checkbox" id="snowy" name="tags[]" value="snowy">
        <label for="snowy">Snowy</label><br>
        <input type="checkbox" id="budget" name="tags[]" value="budget">
        <label for="budget">Budget</label><br>
        <input type="checkbox" id="family" name="tags[]" value="family">
        <label for="family">Family</label><br>
        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="modifyTags" value="modifyTags">Modify Tags</button>
    </form>
</div>
</body>
<script type="text/javascript" src="script.js"></script>
</html>