<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.TagBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
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
<%--            Edit user tagset form                 --%>
    <h1>Modify Tag Set</h1>
    <h2> Add New Tags </h2>
    <form method="POST" action="AccountSettings" onsubmit="return modifyTags()">
        <% LinkedList<String> allTags = TagBean.getAllTags();
           LinkedList<String> tagSet = user.getTagSet();
           for (String tag : allTags) {
               if (!tagSet.contains(tag)) { %>
                   <input type="checkbox" name="tags[]" value="<%= tag %>"> <%= tag %><br>
               <% }
           } %>

        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="addTags" value="addTags">Add Tags</button>
    </form>
<br>
    <h2> Remove Tags </h2>
        <form method="POST" action="AccountSettings" onsubmit="return modifyTags()">
    <%
        for (String tag : tagSet) {
        %>
            <input type="checkbox" name="tags[]" value="<%= tag %>"> <%= tag %><br>
        <%
        }
    %>
            <input type="hidden" name="userID" value="<%=user.getUserID()%>">
            <button type="submit" name="removeTags" value="removeTags">Remove Tags</button>
        </form>
</div>
</body>
<script type="text/javascript" src="script.js"></script>
</html>
