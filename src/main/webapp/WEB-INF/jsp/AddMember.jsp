<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
%>

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


 <header>
           <form name="backToManageGroup" action="ManageGroup" method="GET">
                   <button type="submit" name="manageGroup" value="true">Return to Manage Group</button>
           </form>

            <div class="titleContainer">
                <h1>Add Group Member</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div id="addMemberFormContainer">
            <form method="POST" action="ManageGroup" onsubmit="return addMemberForm()">
                <label for="userEmail">User email: </label>
                <input type="text" id="userEmail" name="userEmail"><br>

                <button type="submit" name="addMember" value="addMember">Add Member</button>
            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>