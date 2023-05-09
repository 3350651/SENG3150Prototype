<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>


<!DOCTYPE html>
<html lang="en">

<%
UserBean user = (UserBean) session.getAttribute("userBean");
GroupBean group = (GroupBean) session.getAttribute("group");
boolean depositMade = (boolean) session.getAttribute("depositMade");
if(!depositMade){
    depositMade = false;
}
%>

<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <main>
        <header>

           <form name="backToGroup" action="GroupHomepage" method="GET">
                   <button type="submit" name="groupHomepage" value="true">Return to Group Home</button>
           </form>

            <div class="titleContainer">
                <h1>Manage Group</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div>
           <form name="addMember" action="ManageGroup" method="POST">
                  <button type="submit" name="addMember" value="addMember">Add Member</button>
           </form>
        </div>
        <div>
           <form name="removeMember" action="ManageGroup" method="POST">
                 <button type="submit" name="removeMember" value="removeMember">Remove Member</button>
           </form>
        </div>
        <%if(!depositMade) {%>
            <div>
               <form name="deleteGroup" action="ManageGroup" method="POST">
                     <button type="submit" name="deleteGroup" value="deleteGroup">Delete Group</button>
               </form>
            </div>
        <%}%>


    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>