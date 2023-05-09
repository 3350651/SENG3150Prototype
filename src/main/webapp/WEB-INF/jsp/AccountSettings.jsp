<%@ page import="startUp.UserBean" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
  String dateOfBirthFormatted = user.getDateOfBirth().format(formatter); %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit user account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="AccountSettingsHomePage">
<div class="sidebar">
<img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
<%--        Home page button         --%>
    <form name="returnHome" action="Homepage" method="POST">
        <button type="submit" class="button" name="home" value="true">Return to Home</button>
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
<div class="main-content">
    <h1>User Profile Details & Settings</h1>

    <h2>Personal Details</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="labelOfSetting">Name </p> <p class="valueOfSetting"> <%= user.getFname() %> <%= user.getLname() %> </p> </li>
        <li><p class="labelOfSetting">Email </p> <p class="valueOfSetting"> <%= user.getEmail() %> </p> </li>
        <li><p class="labelOfSetting">Date of Birth </p> <p class="valueOfSetting"> <%= dateOfBirthFormatted %> </p> </li>
    </ul>
    </div>
    <h2>Contact Information</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="labelOfSetting">Phone No </p><p class="valueOfSetting"> <%= user.getPhoneNo() %> </p> </li>
        <li><p class="labelOfSetting">Address </p><p class="valueOfSetting"> <%= user.getAddress() %> </p> </li>
    </ul>
    </div>
    <h2>Preferences</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="labelOfSetting">Default Search Mode </p><p class="valueOfSetting"> <%= user.getDefaultSearch() %> </p> </li>
        <li><p class="labelOfSetting">Default Currency </p><p class="valueOfSetting"> <%= user.getDefaultCurrency() %> </p> </li>
        <li><p class="labelOfSetting">Default Timezone </p><p class="valueOfSetting"> <%= user.getDefaultTimeZone() %> </p> </li>
        <li><p class="labelOfSetting">Theme Preference </p><p class="valueOfSetting"> <%= user.getThemePreference() %> </p> </li>
        <li><p class="labelOfSetting">Questionnaire Completed? </p><p class="valueOfSetting"> <%= user.isQuestionnaireCompleted() %> </p> </li>
    </ul>
    </div>
    <h2>Tagset</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="valueOfSetting">TagExample</p> </li>
    </ul>
    </div>
    <h2>Bookmarked Flights</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="valueOfSetting">FlightExample</p> </li>
    </ul>
    </div>
    <h2>Favourite Destinations</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="valueOfSetting">DestinationExample</p> </li>
    </ul>
    </div>
    <h2>Saved Searches</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="valueOfSetting">SearchExample</p> </li>
    </ul>
    </div>
</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>