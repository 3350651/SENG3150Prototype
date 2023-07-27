<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.GroupFaveFlightBean" %>
<%
UserBean user = (UserBean) session.getAttribute("userBean");
GroupBean group = (GroupBean) session.getAttribute("group");
LinkedList<GroupFaveFlightBean> faveFlights = (LinkedList<GroupFaveFlightBean>) session.getAttribute("faveFlights");
LinkedList<String> destinations = (LinkedList<String>) session.getAttribute("destinations");
int size = 0;
if(faveFlights != null && !faveFlights.isEmpty()){
    size = faveFlights.size();
}
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
           <form name="backtoGroupHomepage" action="GroupHomepage" method="GET">
                   <button class="groupButton" type="submit" name="groupHomepage" value="true">Return to Group Homepage</button>
           </form>

            <div class="titleContainer">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Group Favourite List</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div class="manageGroupContent">
            <%
            if(size > 0){
                for(int i = 0; i < size; i++){
                    GroupFaveFlightBean faveFlight = faveFlights.removeFirst();
                    String dest = destinations.removeFirst();
                %>
                    <%= faveFlight.getFlightName() %>:<br>
                    To <%= dest %><br>
                    <form method="POST" action="GroupHomepage">
                        <button class="groupButton" type="submit" name="viewFaveFlight" value="viewFaveFlight">View Flight</button><br><br>
                        <input type="hidden" id="airlineCode" name="airlineCode" value="<%= faveFlight.getAirlineCode() %>">
                        <input type="hidden" id="flightName" name="flightName" value="<%= faveFlight.getFlightName() %>">
                        <input type="hidden" id="flightTime" name="flightTime" value="<%= faveFlight.getFlightTime() %>">
                        <input type="hidden" id="getFlight" name="getFlight" value="true">
                    </form>
                <% faveFlights.addLast(faveFlight);
                   destinations.addLast(dest);
                }
            } else { %>
                <p>There are currently no favourited flights for the group!</p>
            <%}
            %>
        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>