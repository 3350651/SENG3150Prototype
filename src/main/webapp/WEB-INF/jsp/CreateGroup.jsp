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
         <div class="titleContainer">
            <h1>Create a Group</h1>
         </div>

<div id="createGroupFormContainer">
                <form method="POST" action="CreateGroup" onsubmit="return createGroupForm()">
                    <label for="groupName">Group Name: </label>
                    <input type="text" id="groupName" name="groupName"><br>

                    <button type="submit" name="createGroup" value="createGroup">Create Group</button>
                </form>
                 <form name="returnHome" action="Homepage" method="POST">
                       <button type="submit" name="home" value="true">Cancel</button>
                 </form>
            </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>