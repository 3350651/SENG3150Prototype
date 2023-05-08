<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
LinkedList<String> memberIDs = (LinkedList<String>) session.getAttribute("memberIDs");
LinkedList<String> memberNames = (LinkedList<String>) session.getAttribute("memberNames");
int size = (int) session.getAttribute("size");
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
           <form name="backToManageGroup" action="ManageGroup" method="GET">
                   <button type="submit" name="manageGroup" value="true">Return to Manage Group</button>
           </form>

            <div class="titleContainer">
                <h1>Remove Group Member</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div>
            <%
            for(int i = 0; i < size; i++){
            String name = memberNames.pop();
            String id = memberIDs.pop();
            %>
                <p>Member Name: <%= name %></p>
                <p>Member ID: <%= id %></p>
                <form method="POST" action="ManageGroup" onsubmit="return removeMemberForm()">
                    <button type="submit" name="removeMember" value="removeMember">Remove</button>
                    <input type="hidden" id="memberID" name="memberID" value="<%= id %>">
                </form>
            <% memberNames.addLast(name);
            memberIDs.addLast(id);
            }
            %>
        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>