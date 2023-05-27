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
<main>
<jsp:include page='c-Sidebar-Account.jsp'></jsp:include>
<%--            Edit user form                 --%>
<div class="main-content">
<h1>Change Password</h1>
    <form method="POST" action="AccountSettings" onsubmit="">
        <label for="currentPassword">Current Password:</label>
        <input type="password" id="currentPassword" name="currentPassword" required><br>

        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required><br>

        <label for="confirmPassword">Confirm New Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br>

        <input type="hidden" name="userID" value="<%= user.getUserID() %>">

        <button type="submit" name="changePassword" value="changePassword">Change Password</button>
    </form>
</div>
</main>
</body>

</html>