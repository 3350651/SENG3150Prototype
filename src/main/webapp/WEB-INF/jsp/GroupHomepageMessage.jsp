<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
String message = (String) session.getAttribute("message");
boolean goHome = (boolean) session.getAttribute("goHome");
boolean homepage = (boolean) session.getAttribute("homepage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
     <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>

 <header>
            <div class="titleContainer">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Group Update Message</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>
        <div id="addMemberFormContainer">
            <div>
                <%= message %>
            </div>
            <div>
            <% if(homepage) { %>
              <form name="returnHome" action="Homepage" method="POST">
                  <button class="groupButton" type="submit" name="home" value="true">Continue</button>
              </form>

            <% } else { %>
                <form method="POST" action="ManageGroup">
                    <button class="groupButton" type="submit" name="continue" value="continue">Continue</button>

                    <%if(goHome){%>
                    <input type="hidden" id="goHome" name="goHome" value="<%= goHome %>">
                    <%}%>
                </form>
                <% } %>
            </div>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>