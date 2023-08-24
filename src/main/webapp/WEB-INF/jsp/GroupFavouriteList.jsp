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
            <div class="titleContainer">
                <h1>Group Favourite List</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div class="manageGroupContent">
            <%
            if(size > 0){
                for (GroupFaveFlightBean faveFlight : faveFlights){
                %>
            <div class="favouriteFlight">
                    <% if(isAdmin) { %>
                        <div class="flightInformation">
                            <div class="infoRow1">
                                <div class="DepartureLocationResult"><%=faveFlight.getFlightPath().getInitialFlight().getDeparture().getDestinationName() %> &nbsp;</div>
                                <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" id="groupFavouriteList">
                                <div class="DestinationLocationResult">&nbsp;<%=faveFlight.getFlightPath().getLastFlight().getDestination().getDestinationName() %> &nbsp; </div>
                            </div>
                            <div class="infoRow2">
                                <% if(faveFlight.getFlightPath().getFlightPath().size() == 2){ %>
                                <div class="QuantityOfStops">  (1 stopover) </div>
                                <%}%>
                                <% if(faveFlight.getFlightPath().getFlightPath().size() > 2){ %>
                                <div class="QuantityOfStops">  (<%=faveFlight.getFlightPath().getFlightPath().size()-1 %> stopovers) </div>
                                <%}%>
                                <div class="FaveFlightScore">  (<%=faveFlight.getScore() %> Score) </div>
                            </div>
                        </div>
                        <form method="POST" action="GroupHomepage">
                            <input type="hidden" name="flightIndex" value="<%= faveFlights.indexOf(faveFlight) %>">
                            <div class="viewFlightDetailsButton">
                                <button type="submit" class="viewGroupFaveFlight" name="viewFaveFlight" value="viewFaveFlight">View Group Favourite Flight</button><br>
                                <button type="submit" class="viewGroupFaveFlight" name="viewFlight" value="viewFlight">View Flight Details</button>
                            </div>

                        <% if(!lockedIn) { %>
                            <button class="removeFavouritedFlight" type="submit" name="removeFlight" value="removeFlight">Remove Flight</button> <br> <br>
                            <input type="hidden" id="faveFlightID" name="faveFlightID" value="<%= faveFlight.getGroupFaveFlightID()%>">
                        </form>
                        <%} else{%>
                        </form> <% } %>
                    <% } else { %>

            <div class="flightInformation">
                <div class="infoRow1">
                    <div class="DepartureLocationResult"><%=faveFlight.getFlightPath().getInitialFlight().getDeparture().getDestinationName() %> &nbsp;</div>
                    <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" id="groupFavouriteList">
                    <div class="DestinationLocationResult">&nbsp;<%=faveFlight.getFlightPath().getLastFlight().getDestination().getDestinationName() %> &nbsp; </div>
                </div>
                <div class="infoRow2">
                    <% if(faveFlight.getFlightPath().getFlightPath().size() == 2){ %>
                    <div class="QuantityOfStops">  (1 stopover) </div>
                    <%}%>
                    <% if(faveFlight.getFlightPath().getFlightPath().size() > 2){ %>
                    <div class="QuantityOfStops">  (<%=faveFlight.getFlightPath().getFlightPath().size()-1 %> stopovers) </div>
                    <%}%>
                    <div class="FaveFlightScore">  (<%=faveFlight.getScore() %> Score) </div>
                </div>
            </div>
            <form method="POST" action="GroupHomepage">

                <input type="hidden" name="flightIndex" value="<%= faveFlights.indexOf(faveFlight) %>">

                <div class="viewFlightDetailsButton">
                    <button class="viewGroupFaveFlight" type="submit" name="viewFaveFlight" value="viewFaveFlight">View Group Favourite Flight</button><br>
                    <button type="submit" class="viewGroupFaveFlight" name="viewFlight" value="viewFlight">View Flight Details</button> <br>
                </div>
            </form>
                <% }%> </div> <% }
            } else { %>
              <p>There are currently no favourited flights for the group!</p>
            <%}%>
        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>