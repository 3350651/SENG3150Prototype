<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%
String message = (String) session.getAttribute("message");
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
        </header>
        <div>
            <%= message %>
        </div>
        <div id="continueFormContainer">
            <form method="POST" action="GroupHomepage">
                <button type="submit" name="addFlightContinue" value="continue">Continue</button>
            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>