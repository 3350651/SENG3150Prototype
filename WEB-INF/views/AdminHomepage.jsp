<%@ page import="webapp.PersonBean" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <main>
        
        <header>
            <div class="logoutContainer">
                <form method="POST" action="Homepage">
                    <button name="logout" value="logout">Logout</button>
                </form>
            </div>
                <h1>Admin Homepage</h1>
        </header>

            <div id="systemUserContainer">
<%--                displaying all admin users in table. Has edit and delete buttons            --%>
                <table>
                <% for (PersonBean person : PersonBean.getNonAdminUsers()) { %>
                    <tr>
                        <td><%= person.getEmail() %></td>
                        <td><%= person.getRoleInSystem() %></td>
                        <td>
                            <form method="POST" action="EditUser">
                            <button name="edit" value='<%= person.getPersonID() %>'>Edit user</button>
                        </form>
                        </td>
                        <td>
                            <form method="POST" action="Homepage">
                            <button type="submit" name="remove" value='<%= person.getPersonID() %>'>Remove user</button>
                        </form>
                        </td>
                   </tr>
                <% } %>
                </table>
            </div>
<%--                Form for adding users to the system              --%>
            <div id="addUserFormContainer">
                <form method="POST" action="Homepage" onsubmit="return addUserForm()">
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
                        <option value="">Please select...</option>
                        <option value="user">User</option>
                        <option value="staff">IT Staff</option>
                        <option value="admin">Admin</option>
                    </select><br>

                    <button type="submit" name="addUser" value="addUser">Add user</button>
                </form>
            </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>