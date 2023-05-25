<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
LinkedList<GroupBean> groups = (LinkedList<GroupBean>) session.getAttribute("groups");

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
            <div class="titleContainer">
                <h1>Add Flight to Group Favourite List</h1>
            </div>
        </header>

        <div id="addGroupFaveFlight">
        <form method="POST" action="GroupHomepage">
            <%
                if(!groups.isEmpty()){
                    int size = groups.size();
                    String name = "";
                    for(int i = 0; i < size; i++){
                        GroupBean group = groups.pop();
                        name = group.getGroupName(); %>
                        <input type="checkbox" id="groupFaveFlight" name="groupName" value="<%= name %>"
                        <label for="<%= name %>"><%= name %></label><br>
                        <%
                        groups.addLast(group);
                    } %>
                    <button name="addToGroupFaveList" value="addToGroupFaveList">Add!</button>
              <%  }
            %>
            </form>
            <form method="POST" action="GroupHomepage">
               <button type="submit" name="doNotAddFaveFlight" value="true">Cancel</button>
            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>