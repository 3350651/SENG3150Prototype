<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
LinkedList<String> memberIDs = (LinkedList<String>) session.getAttribute("memberIDs");
LinkedList<String> memberNames = (LinkedList<String>) session.getAttribute("memberNames");
int size = (int) session.getAttribute("size");
GroupBean group = (GroupBean) session.getAttribute("group");
LinkedList<Boolean> hasDeposited = (LinkedList<Boolean>) session.getAttribute("hasDeposited");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Remove Member</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>
        <header>
           <form name="backToManageGroup" action="ManageGroup" method="GET">
                   <button class="groupButton" type="submit" name="manageGroup" value="true">Return to Manage Group</button>
           </form>

            <div class="titleContainer">
             <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Remove Group Member</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div class="removeMember">

                <% if(size > 0) {
                    for(int i = 0; i < size; i++){
                    String name = memberNames.pop();
                    String id = memberIDs.pop();
                    Boolean deposited = hasDeposited.pop();
                    %>
                        <p>Member Name: <%= name %></p>
                        <p>Member ID: <%= id %></p>
                        <%if(!deposited){%>
                        <form method="POST" action="ManageGroup" onsubmit="return removeMemberForm()">
                            <button class="groupButton" type="submit" name="removeMember" value="removeMember">Remove</button>
                            <input type="hidden" id="memberID" name="memberID" value="<%= id %>">
                        </form>
                        <%} else {%>
                        <p>Cannot remove <%= name %> due to their contribution to the money pool.</p><br>
                    <% } memberNames.addLast(name);
                    memberIDs.addLast(id);
                    hasDeposited.addLast(deposited);
                    }
                } else {%>
                    <p> The group currently has no members.</p>
                <% } %>

        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>