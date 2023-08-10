<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>

<%
LinkedList<FlightPathBean> bookmarkedFlights = new LinkedList<>();
if (user != null && user.getBookmarkedFlights() != null) {
    bookmarkedFlights = user.getBookmarkedFlights();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit user account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page='c-Sidebar-Account.jsp'></jsp:include>

<div class="main-content">
    <h1>Modify Bookmarked Flights</h1>
    <div class="bookmarkedFlight">
        <% int i = 0;
        for (FlightPathBean flightPath : bookmarkedFlights) { %>
            <div class="recResults">
                <div class="FlightSearchResult">
                    <div class="simpleFlightCardColumn1">
                    <div class="flightInfo">
                        <div class="searchResultRow1">
                            <%for(int x= flightPath.getFlightPath().size()-1; x >=0; x--){%>
                                <div class="DepartureLocationResult"><%=flightPath.getFlightPath().get(x).getDeparture().getDestinationName()%></div>
                                <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                            <%}%>
                            <div class="DestinationLocationResult"><%=flightPath.getInitialFlight().getDestination().getDestinationName()%></div>
                        </div>
                        <div class="searchResultRow2">
                            <div class="priceResult">$$$</div>
                            <div class="dateResult"><%=flightPath.getInitialFlight().getFlightTime()%></div>
                            <div class="numPassengersResult">#Passengers</div>
                        </div>
                    </div>
                        <div class="searchResultButtons">
                            <form method="POST" action="flightSearch">
                            <!-- TODO: allow flightDetailsViewingFromHere -->
                                <div class="viewFlightDetailsButton">
                                    <button type="submit" id="flightDetailsModifyBookmarked" class="button" name="viewFlight" value="viewFlight">View Details</button>
                                </div>
                            </form>
                            <!-- Form for removing a bookmarked flight -->
                            <form name="removeBookmarkedFlight<%= i %>" action="AccountSettings" method="POST">
                                <!-- Hidden form fields to store flight information -->
                                <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                                <input type="hidden" name="bookmarkedFlightID" id="bookmarkedFlightId" value="<%=flightPath.getId()%>">
                                <button type="submit" class="button" id="removeBookmarkedFlight" name="removeBookmarkedFlight" value="removeBookmarkedFlight">Remove Bookmarked Flight</button>
                            </form>
                        </div>
                    </div>
                    <div class="destinationImage">
                        <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" id="imageModifyBookmarkedFlight" alt="Brisbane Logo" class="smallBrisbaneLogo" >
                    </div>
                </div>
            </div>
        <% i++;
        } %>
    </div>
</div>

</body>
<script type="text/javascript" src="script.js"></script>
</html>
