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
            <div id="questionnaire">
                <form method="POST" action="ManageGroup" onsubmit="return questionnaire()">
                    <%--@declare id="travelgoals"--%><%--@declare id="locations"--%><%--@declare id="valueadds"--%><label for="travelGoals" style="font-size: large; font-weight: bold">What are your main goals when travelling?</label><br>
                    <label for="exploring">Exploring</label>
                    <input type="checkbox" id="exploring" name="travelGoals[]" value="Exploration">
                    <label for="outdoors">Outdoor Adventures</label>
                    <input type="checkbox" id="outdoors" name="travelGoals[]" value="Outdoor Adventures">
                    <label for="relaxing">Relaxing</label>
                    <input type="checkbox" id="relaxing" name="travelGoals[]" value="Relaxing">
                    <label for="culture">Experiencing New Cultures</label>
                    <input type="checkbox" id="culture" name="travelGoals[]" value="Experiencing New Cultures">
                    <label for="landmarks">Visiting landmarks</label>
                    <input type="checkbox" id="landmarks" name="travelGoals[]" value="Famous For Landmarks">

                    <br>

                    <label for="locations" style="font-size: large; font-weight: bold">What sort of locations interest you most?</label><br>
                    <label for="tropical">Tropical</label>
                    <input type="checkbox" id="tropical" name="locations[]" value="Tropical">
                    <label for="tourist">Tourist</label>
                    <input type="checkbox" id="tourist" name="locations[]" value="Tourist">
                    <label for="remote">Remote</label>
                    <input type="checkbox" id="remote" name="locations[]" value="Remote">
                    <label for="snowy">Snowy</label>
                    <input type="checkbox" id="snowy" name="locations[]" value="Snowy">
                    <label for="cities">Big Cities</label>
                    <input type="checkbox" id="cities" name="locations[]" value="Cities">

                    <br>

                    <label for="valueAdds" style="font-size: large; font-weight: bold">Which of these things do you value?</label><br>
                    <label for="budget">Budget Flights</label>
                    <input type="checkbox" id="budget" name="valueAdds[]" value="Budget">
                    <label for="family">Family Friendly</label>
                    <input type="checkbox" id="family" name="valueAdds[]" value="Family">
                    <label for="popular">Popular</label>
                    <input type="checkbox" id="popular" name="valueAdds[]" value="Popular">

                    <br>

                    <button type="submit" name="submitQuestionnaire" value="submitQuestionnaire" class="button" id="submitQuestionnaire">Submit</button>
                </form>
            </div>
           <div id="SkipQuestionnaireButton">
                <form method="POST" action="ManageGroup">
                    <button type="submit" name="skipQuestionnaire" value="skipQuestionnaire" class="button" id="skipQuestionnaire">Skip Questionnaire</button>
                </form>
           </div>
            </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>