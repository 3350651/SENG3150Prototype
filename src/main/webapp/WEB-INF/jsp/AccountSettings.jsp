<%@ page import="startUp.UserBean" %>
<!DOCTYPE html>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit user account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="AccountSettingsHomePage">
<div class="containerForLogoAndLinks">
<img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" style="width:150px;height:150px; >
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

    <h1>Personal Details</h1>
    <h3>Name: <%= user.getFname() %> <%= user.getLname() %> </h3>
    <h3>Email: <%= user.getEmail() %> </h3>
    <h3>PhoneNo: <%= user.getPhoneNo() %> </h3>
    <h3>Role: <%= user.getRole() %> </h3>
    <h3>Address:<%= user.getAddress() %> </h3>
    <h3>Default Search Mode: <%= user.getDefaultSearch() %> </h3>
    <h3>Default Currency: <%= user.getDefaultCurrency() %> </h3>
    <h3>Default Timezone: <%= user.getDefaultTimeZone() %> </h3>
    <h3>Theme Preference: <%= user.getThemePreference() %> </h3>
    <h3>Questionnaire Complete?: <%= user.isQuestionnaireCompleted() %> </h3>
    <h3>Date Of Birth: <%= user.getDateOfBirth() %> </h3>

</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>