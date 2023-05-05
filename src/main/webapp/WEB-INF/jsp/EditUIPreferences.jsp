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
    <h1>Edit user <%=user.getUserID()%> account</h1>
    <form method="POST" action="AccountSettings" onsubmit="return modifyUIPreferences()">
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
        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="updateUIPreferences" value="updateUIPreferences">Update UI Preferences</button>
    </form>
</body>
<script type="text/javascript" src="script.js"></script>
</html>