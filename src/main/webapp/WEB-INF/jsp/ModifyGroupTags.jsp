<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.TagBean" %>


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


    <div class="main-content">
        <%-- Edit user tagset form --%>
        <h1>Modify Tag Set</h1>
        <h2>Your Current Tags</h2>
        <form method="POST" action="ManageGroup" onsubmit="return modifyTags()">
            <div class="tag-grid">
                <% LinkedList<String> tagSet = group.getTagSet();
                    for (String tag : tagSet) { %>
                <div class="tag-item remove-tags-form">
                    <input type="checkbox" name="tagsToRemove[]" value="<%= tag %>" id="remove_<%= tag %>">
                    <label for="remove_<%= tag %>"><%= tag %></label>
                </div>
                <% } %>
            </div>

            <input type="hidden" name="userID" value="<%=group.getGroupID()%>">
            <button type="submit" name="removeTags" value="removeTags" class="button">Remove Tag(s)</button>
        </form>
        <br>

        <h2> Add New Tags </h2>
        <form method="POST" action="ManageGroup" onsubmit="return modifyTags()">
            <div class="tag-grid">
                <% LinkedList<String> allTags = TagBean.getAllTags();
                    for (String tag : allTags) {
                        if (!tagSet.contains(tag)) { %>
                <div class="tag-item add-tags-form">
                    <input type="checkbox" name="tagsToAdd[]" value="<%= tag %>" id="<%= tag %>">
                    <label for="<%= tag %>"><%= tag %></label>
                </div>
                <% }
                } %>
            </div>

            <input type="hidden" name="groupID" value="<%=group.getGroupID()%>">
            <button type="submit" name="addTags" value="addTags" class="button">Add New Tag(s)</button>
        </form>
    </div>

</main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>