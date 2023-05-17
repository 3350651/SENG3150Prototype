<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="startUp.PoolBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
String message = (String) session.getAttribute("message");
PoolBean pool = (PoolBean) session.getAttribute("pool");
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
            <div class="titleContainer">
                <h1>Pool Update Message</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>
        <div>
            <%= message %>
        </div>
        <div id="continueFormContainer">
            <form method="POST" action="GroupHomepage">
                <button type="submit" name="poolContinue" value="poolContinue">Continue</button>

            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>