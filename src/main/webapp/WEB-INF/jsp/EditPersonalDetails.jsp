<%@ page import="startUp.UserBean" %>
<!DOCTYPE html>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit user account</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
<%--        Home page button         --%>
    <form name="returnHome" action="Homepage" method="POST">
        <button type="submit" name="home" value="true">Return to Home</button>
    </form>
    <div class="viewAccountSettings">
        <form method="POST" action="AccountSettings">
            <button name="viewAccountSettings" value="viewAccountSettings">Back to Account</button>
        </form>
    </div>

<%--            Edit user form                 --%>
    <h1>Edit user account</h1>
    <form method="POST" action="AccountSettings" onsubmit="return modifyPersonalDetails()">
        <label for="firstName">First Name:</label><br>
        <input type="text" id="firstName" name="firstName" value="<%= user.getFname() %>"><br>

        <label for="lastName">Last Name:</label><br>
        <input type="text" id="lastName" name="lastName" value="<%= user.getLname() %>"><br>

        <label for="email">Email:</label><br>
        <input type="text" id="email" name="email" value="<%= user.getEmail() %>"><br>

        <label for="phoneNumber">Phone Number:</label><br>
        <input type="text" id="phoneNumber" name="phoneNumber" value="<%= user.getPhoneNo() %>"><br>

        <label for="address">Address: </label>
        <input type="text" id="address" name="address" value="<%= user.getAddress() %>"><br>

        <label for="defaultCurrency">Default Currency: </label>
        <input type="text" id="defaultCurrency" name="defaultCurrency" value="<%= user.getDefaultCurrency() %>"><br>

        <label for="defaultTimezone">Default Timezone: </label>
        <input type="text" id="defaultTimezone" name="defaultTimezone" value="<%= user.getDefaultTimeZone() %>"><br>

        <label for="dateOfBirth">Birth Date:</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= user.getDateOfBirth() %>">

        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="editPersonalDetails" value="editPersonalDetails">Update Details</button>
    </form>
</body>
<script type="text/javascript" src="script.js"></script>
</html>