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