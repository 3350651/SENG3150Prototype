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
<div class="sidebar">
    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
    <%--        Home page button         --%>
    <form name="returnHome" action="Homepage" method="POST">
        <button type="submit" class="button" name="home" value="true">Return to Home</button>
    </form>
    <%--    Back to User Profile--%>
    <form method="POST" action="AccountSettings">
        <button name="viewAccountSettings" class="button" value="viewAccountSettings">Back to Account</button>
    </form>
    <%--        Personal Details button         --%>
    <form name="goToPersonalDetails" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToPersonalDetails" value="goToPersonalDetails">Modify Personal Details</button>
    </form>
    <%--        UI Preferences button         --%>
    <form name="goToUIPreferences" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToUIPreferences" value="goToUIPreferences">Modify UI Preferences</button>
    </form>
    <%--        Change Password button         --%>
    <form name="goToChangePassword" action="AccountSettings" method="POST">
        <button type="submit" class="button" name="goToChangePassword" value="goToChangePassword">Change Password</button>
    </form>
</div>

<div class="main-content">
<%--            Edit user bookmarked flights form                 --%>
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
