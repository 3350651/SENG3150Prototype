<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<%
LinkedList<FlightBean> bookmarkedFlights = new LinkedList<>();
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
<%--            Edit user bookmarked flights form                 --%>
    <h1>Modify Bookmarked Flights</h1>
    <form name="removeBookmarkedFlight" action="AccountSettings" method="POST">
    <ul>
        <% for(FlightBean flight : bookmarkedFlights) { ;%>
            <li><p class="valueOfSetting">From <%= flight.getDeparture().getDestinationName() %> to <%= flight.getDestination().getDestinationName() %>, departing on <%= flight.getFlightTime() %></p> </li>
            <!-- Hidden form fields to store flight information -->
                  <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                  <input type="hidden" name="airlineCode" value="<%= flight.getAirline() %>">
                  <input type="hidden" name="flightNumber" value="<%= flight.getFlightName() %>">
                  <input type="hidden" name="departureTime" value="<%= flight.getFlightTime() %>">
            <button type="submit" class="button" name="removeBookmarkedFlight" value="<%= flight %>">Remove Bookmarked Flight</button>
        <% } %>
    </ul>
    </form>
</div>


</body>
<script type="text/javascript" src="script.js"></script>
</html>
