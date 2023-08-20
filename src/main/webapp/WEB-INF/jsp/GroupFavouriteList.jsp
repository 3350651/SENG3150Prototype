<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.GroupFaveFlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%
UserBean user = (UserBean) session.getAttribute("userBean");
GroupBean group = (GroupBean) session.getAttribute("group");
LinkedList<GroupFaveFlightBean> faveFlights = (LinkedList<GroupFaveFlightBean>) session.getAttribute("faveFlights");
LinkedList<String> destinations = (LinkedList<String>) session.getAttribute("destinations");
Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
int size = 0;
if(faveFlights != null && !faveFlights.isEmpty()){
    size = faveFlights.size();
}
boolean lockedIn = (boolean) session.getAttribute("lockedIn");
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
                    GroupFaveFlightBean faveFlight = faveFlights.peek();
                    faveFlights.add(faveFlights.removeFirst());
                    String dest = destinations.peek();
                    destinations.add(destinations.removeFirst());
                %>
                    <% if(isAdmin) { %>
                        <div class="DepartureLocationResult"><%=faveFlight.getFlightPath().getInitialFlight().getDeparture().getDestinationName() %> &nbsp;</div>
                        <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                        <div class="DestinationLocationResult">&nbsp;<%=faveFlight.getFlightPath().getLastFlight().getDestination().getDestinationName() %> &nbsp; </div>
                        <% if(faveFlight.getFlightPath().getFlightPath().size() == 2){ %>
                        <div class="QuantityOfStops">  (1 stopover) </div>
                        <%}%>
                        <% if(faveFlight.getFlightPath().getFlightPath().size() > 2){ %>
                        <div class="QuantityOfStops">  (<%=faveFlight.getFlightPath().getFlightPath().size()-1 %> stopovers) </div>
                        <%}%>
                        <form method="POST" action="GroupHomepage">
                            <button class="groupButton" type="submit" name="viewFaveFlight" value="viewFaveFlight">View Flight</button><br><br>
                            <input type="hidden" name="flightIndex" value="<%= faveFlights.indexOf(faveFlight) %>">
                            <div class="viewFlightDetailsButton">
                                <button type="submit" class="viewFlightDetailsButton" name="viewFlight" value="viewFlight">View Details</button>
                            </div>
                        </form>
                        <% if(!lockedIn) { %>
                        <form method="POST" action="GroupHomepage">
                            <button class="groupButton" type="submit" name="removeFlight" value="removeFlight">Remove Flight</button><br><br>
                            <input type="hidden" id="getGroupFaveList" name="getGroupFaveList" value="getGroupFaveList">
                            <input type="hidden" id="faveFlightID" name="faveFlightID" value="<%= faveFlight.getGroupFaveFlightID()%>">
                        </form>
                        <%}%>
                    <% } else { %>
                <div class="DepartureLocationResult"><%=faveFlight.getFlightPath().getInitialFlight().getDeparture().getDestinationName() %> &nbsp;</div>
                <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                <div class="DestinationLocationResult">&nbsp;<%=faveFlight.getFlightPath().getLastFlight().getDestination().getDestinationName() %> &nbsp; </div>
                <% if(faveFlight.getFlightPath().getFlightPath().size() == 2){ %>
                <div class="QuantityOfStops">  (1 stopover) </div>
                <%}%>
                <% if(faveFlight.getFlightPath().getFlightPath().size() > 2){ %>
                <div class="QuantityOfStops">  (<%=faveFlight.getFlightPath().getFlightPath().size()-1 %> stopovers) </div>
                <%}%>
                <form method="POST" action="GroupHomepage">
                    <button class="groupButton" type="submit" name="viewFaveFlight" value="viewFaveFlight">View Flight</button><br><br>
                    <input type="hidden" name="flightIndex" value="<%= faveFlights.indexOf(faveFlight) %>">
                    <div class="viewFlightDetailsButton">
                        <button type="submit" class="viewFlightDetailsButton" name="viewFlight" value="viewFlight">View Details</button>
                    </div>
                </form>
                <% } }
            } else { %>
              <p>There are currently no favourited flights for the group!</p>
            <%}%>
        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>