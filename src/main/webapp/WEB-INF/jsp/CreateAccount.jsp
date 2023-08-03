<%@ page import="startUp.UserBean" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <main>
        <jsp:include page='c-Sidebar-CreateAccount.jsp'></jsp:include>
            <div class="main-content">
                <form method="POST" action="CreateAccount" onsubmit="return addUserForm()">
                <label for="firstName">First Name: </label>
                <input type="text" id="firstName" name="firstName"><br>

                <label for="lastName">Last Name: </label>
                <input type="text" id="lastName" name="lastName"><br>

                <label for="email">Email: </label>
                <input type="text" id="email" name="email"><br>

                <label for="password">Password: </label>
                <input type="password" id="password" name="password"><br>

                <label for="phoneNumber">Phone Number: </label>
                <input type="text" id="phoneNumber" name="phoneNumber"><br>

                <label for="role">Role: </label>
                <select id="role" name="role">
                    <option value="user">User</option>
                </select><br>

                <label for="address">Address: </label>
                <input type="text" id="address" name="address"><br>

                <label for="defaultSearch">Default Search Mode: </label>
                <select id="defaultSearch" name="defaultSearch">
                    <option value="Simple">Simple</option>
                    <option value="Recommend">Recommend</option>
                </select><br>

                <label for="defaultCurrency">Default Currency: </label>
                <input type="text" id="defaultCurrency" name="defaultCurrency"><br>

                <label for="defaultTimezone">Default Timezone: </label>
                <input type="text" id="defaultTimezone" name="defaultTimezone"><br>

                <label for="themePreference">Theme Preference: </label>
                <select id="themePreference" name="themePreference">
                    <option value="Light">Light Mode</option>
                    <option value="Dark">Dark Mode</option>
                </select><br>

                <input type="hidden" name="questionnaireCompleted" value="No">

                <label for="dateOfBirth">Birth Date:</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth">
                <br>
                <button type="submit" name="addUser" value="addUser" class="button">Create Account</button>
                </form>
            </div>
    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>