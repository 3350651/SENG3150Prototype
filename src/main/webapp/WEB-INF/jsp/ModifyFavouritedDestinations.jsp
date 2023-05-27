<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<%
LinkedList<FlightBean> bookmarkedFlights = new LinkedList<>();
LinkedList<DestinationBean> favouritedDestinations = new LinkedList<>();
if (user != null && user.getBookmarkedFlights() != null) {
  bookmarkedFlights = user.getBookmarkedFlights();
  favouritedDestinations = user.getFavouritedDestinations();
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
    <form name="removeBookmarkedFlight" action="AccountSettings" method="POST">
    <ul>
        <% for(DestinationBean destination : favouritedDestinations) { ;%>
            <li><p class="valueOfSetting"><%= destination.getDestinationName() %></p> </li>
            <!-- Hidden form fields to store flight information -->
                  <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                  <input type="hidden" name="destinationCode" value="<%= destination.getDestinationCode() %>">
            <button type="submit" class="button" name="removeFavouritedDestination" value="<%= destination %>">Remove Destination</button>
        <% } %>
    </ul>
    </form>
</div>


</body>
<script type="text/javascript" src="script.js"></script>
</html>
