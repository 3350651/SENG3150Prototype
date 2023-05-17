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
    <form name="returnHome" action="login" method="GET">
        <button type="submit" class="button" name="home" value="backToHome">Return to Home</button>
    </form>
    <%--    Back to User Profile--%>
    <form method="POST" action="MockUpAccountSettings">
        <button name="viewAccountSettings" class="button" value="viewAccountSettings">Back to Account</button>
    </form>
    <%--        Personal Details button         --%>
    <form name="goToPersonalDetails" action="MockUpAccountSettings" method="POST">
        <button type="submit" class="button" name="goToPersonalDetails" value="goToPersonalDetails">Modify Personal Details</button>
    </form>
    <%--        Change Password button         --%>
    <form name="goToChangePassword" action="MockUpAccountSettings" method="POST">
        <button type="submit" class="button" name="goToChangePassword" value="goToChangePassword">Change Password</button>
    </form>
    <form name="goToModifyTags" action="MockUpAccountSettings" method="POST">
        <button type="submit" class="button" name="goToModifyTags" value="goToModifyTags">Modify Tags</button>
    </form>
</div>

<div class="main-content">
<%--            Edit user form                 --%>
    <h1>Modify User Interface Preferences</h1>
    <form method="POST" action="AccountSettings" onsubmit="">
        <label for="themePreference">Theme Preference: </label>
            <select id="themePreference" name="themePreference">
                <option value="Light">Light Mode</option>
                <option value="Dark">Dark Mode</option>
            </select><br>

       <label for="defaultSearch">Default Search Mode: </label>
           <select id="defaultSearch" name="defaultSearch">
               <option value="Simple">Simple</option>
               <option value="Recommend">Recommend</option>
           </select><br>
        <input type="hidden" name="userID" value=123456789">
        <button type="submit" name="updateUIPreferences" value="updateUIPreferences">Update UI Preferences</button>
    </form>
</div>
</body>
<script type="text/javascript" src="script.js"></script>
</html>