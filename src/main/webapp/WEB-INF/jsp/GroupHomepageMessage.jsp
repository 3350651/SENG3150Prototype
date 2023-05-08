<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
String message = (String) session.getAttribute("message");
boolean goHome = (boolean) session.getAttribute("goHome");
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
                <h1>Group Update Message</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>
        <div>
            <%= message %>
        </div>
        <div id="continueFormContainer">
            <form method="POST" action="ManageGroup">
                <button type="submit" name="continue" value="continue">Continue</button>

                <%if(goHome){%>
                <input type="hidden" id="goHome" name="goHome" value="<%= goHome %>">
                <%}%>
            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>