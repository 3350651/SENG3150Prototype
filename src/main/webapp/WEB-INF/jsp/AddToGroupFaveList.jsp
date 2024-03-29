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
     <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>


 <header>
            <div class="titleContainer">
                          <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Add Flight to Group Favourite List</h1>
            </div>
        </header>

        <div id="addMemberFormContainer">
        <div>
        <form method="POST" action="GroupHomepage">
        <div style="text-align: left;">
            <%
                if(!groups.isEmpty()){
                    int size = groups.size();
                    String name = "";
                    String id = "";
                    for(int i = 0; i < size; i++){
                        GroupBean group = groups.pop();
                        name = group.getGroupName();
                        id = group.getGroupID(); %>
                        <label for="groupFaveFlight"><%= name %></label>
                        <input type="checkbox" id="groupFaveFlight" name="groupID" value="<%= id %>">

                        <%
                        groups.addLast(group);
                    } %>
                    <button class="groupButton" name="addToGroupFaveList" value="addToGroupFaveList">Add!</button>
              <%  }
            %>
            </form>
            <form method="POST" action="GroupHomepage">
               <button class="groupButton" type="submit" name="doNotAddFaveFlight" value="true">Cancel</button>
            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>