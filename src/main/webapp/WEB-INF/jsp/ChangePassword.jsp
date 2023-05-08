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
</body>
<script type="text/javascript" src="script.js"></script>
</html>