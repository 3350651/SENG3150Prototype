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
<jsp:include page='c-Sidebar-Account.jsp'></jsp:include>
<div class="main-content">
<%--            Edit user form                 --%>
    <h1>Edit user account</h1>
    <form method="POST" action="AccountSettings" onsubmit="">
        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="firstName" value="<%= user.getFname() %>"><br>

        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="lastName" value="<%=user.getLname()%>"><br>

        <label for="email">Email:</label>
        <input type="text" id="email" name="email" value="<%=user.getEmail()%>"><br>

        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" value="<%=user.getPhoneNo()%>"><br>

        <label for="address">Address: </label>
        <input type="text" id="address" name="address" value="<%=user.getAddress()%>"><br>

        <label for="dateOfBirth">Birth Date:</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%=user.getDateOfBirth()%>">

        <input type="hidden" name="themePreference" value="Light">
        <input type="hidden" name="defaultTimezone" value="AEST">
        <input type="hidden" name="defaultCurrency" value="AUD">
        <input type="hidden" name="role" value="User">
        <input type="hidden" name="questionnaireCompleted" value="No">
        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="editPersonalDetails" value="editPersonalDetails">Update Details</button>
    </form>
</div>
</body>
<script type="text/javascript" src="webapp/javascript/script.js"></script>
</html>