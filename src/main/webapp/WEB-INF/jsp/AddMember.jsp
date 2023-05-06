<%@ page import="startUp.UserBean" %>
<%@ page import="java.util.List" %>


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

<div id="addMemberFormContainer">
                <form method="POST" action="ManageGroup" onsubmit="return addMemberForm()">
                    <label for="firstName">User email: </label>
                    <input type="text" id="userEmail" name="userEmail"><br>

                    <button type="submit" name="addMember" value="addMember">Add Member</button>
                </form>
            </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>