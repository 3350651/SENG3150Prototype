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
boolean lockedIn = (boolean) session.getAttribute("lockedIn");
%>

<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
     <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>
        <header>

           <form name="backToGroup" action="GroupHomepage" method="GET">
                   <button class="groupButton" type="submit" name="groupHomepage" value="true">Return to Group Homepage</button>
           </form>

            <div class="titleContainer">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Manage Group</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div class="manageGroupContent">
        <% if(!lockedIn) { %>
        <div>
           <form name="addMember" action="ManageGroup" method="POST">
                  <button class="groupButton"type="submit" name="addMember" value="addMember">Add Member</button>
           </form>
        </div>
        <div>
           <form name="removeMember" action="ManageGroup" method="POST">
                 <button class="groupButton" type="submit" name="removeMember" value="removeMember">Remove Member</button>
           </form>
        </div>
        <% }if(!depositMade) {%>
            <div>
               <form name="deleteGroup" action="ManageGroup" method="POST">
                     <button class="groupButton" type="submit" name="deleteGroup" value="deleteGroup">Delete Group</button>
               </form>
            </div>
        <%}%>
        <form name="completeQuestionnaire" action="ManageGroup" method="GET">
             <button class="groupButton" type="submit" name="manageGroup" value="true">Complete Questionnaire</button>
        </form>
        <form name="modifyTags" action="ManageGroup" method="GET">
                     <button class="groupButton" type="submit" name="manageGroup" value="true">Modify Tags</button>
                </form>
        </div>


    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>