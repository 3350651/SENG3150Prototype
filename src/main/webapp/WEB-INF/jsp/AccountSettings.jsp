<%@ page import="startUp.UserBean" %>
<!DOCTYPE html>
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
<%--            Edit user form                 --%>
    <h1>Edit user account</h1>
    <form method="POST" action="EditUser" onsubmit="return addUserForm()">
        <label for="firstName">First Name:</label><br>
        <input type="text" id="firstName" name="firstName"><br>

        <label for="lastName">Last Name:</label><br>
        <input type="text" id="lastName" name="lastName"><br>

        <label for="email">Email:</label><br>
        <input type="text" id="email" name="email"><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password"><br>

        <label for="phoneNumber">Phone Number:</label><br>
        <input type="text" id="phoneNumber" name="phoneNumber"><br>

        <button type="submit" name="submit" value="true">Submit</button>
    </form>
</body>
<script type="text/javascript" src="script.js"></script>
</html>