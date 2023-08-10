<%@ page import="startUp.UserBean" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
  String dateOfBirthFormatted = user.getDateOfBirth().format(formatter); %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.TagBean" %>
<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
LinkedList<FlightPathBean> bookmarkedFlights = new LinkedList<>();
LinkedList<DestinationBean> favouritedDestinations = new LinkedList<>();
LinkedList<String> userTags = new LinkedList<>();
LinkedList<SearchBean> savedSearches = new LinkedList<>();

if (user != null && user.getBookmarkedFlights() != null) {
  bookmarkedFlights = user.getBookmarkedFlights();
}
if (user != null && user.getFavouritedDestinations() != null) {
  favouritedDestinations = user.getFavouritedDestinations();
}
if (user != null && user.getTagSet() != null) {
  userTags = user.getTagSet();
}
if (user != null && user.getSavedSearches() != null) {
  savedSearches = user.getSavedSearches();
}
%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit user account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<jsp:include page='c-Sidebar-Account-Home.jsp'></jsp:include>
<div class="main-content">
    <h1>User Profile Details & Settings</h1>

    <h2>Personal Details</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="labelOfSetting">Name </p> <p class="valueOfSetting"> <%= user.getFname() %> <%= user.getLname() %> </p> </li>
        <li><p class="labelOfSetting">Email </p> <p class="valueOfSetting"> <%= user.getEmail() %> </p> </li>
        <li><p class="labelOfSetting">Date of Birth </p> <p class="valueOfSetting"> <%= dateOfBirthFormatted %> </p> </li>
    </ul>
    </div>
    <h2>Contact Information</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="labelOfSetting">Phone No </p><p class="valueOfSetting"> <%= user.getPhoneNo() %> </p> </li>
        <li><p class="labelOfSetting">Address </p><p class="valueOfSetting"> <%= user.getAddress() %> </p> </li>
    </ul>
    </div>
    <h2>Preferences</h2>
    <div class="settingsCategory">
    <ul>
        <li><p class="labelOfSetting">Default Search Mode </p><p class="valueOfSetting"> <%= user.getDefaultSearch() %> </p> </li>
        <li><p class="labelOfSetting">Default Currency </p><p class="valueOfSetting"> <%= user.getDefaultCurrency() %> </p> </li>
        <li><p class="labelOfSetting">Default Timezone </p><p class="valueOfSetting"> <%= user.getDefaultTimeZone() %> </p> </li>
        <li><p class="labelOfSetting">Theme Preference </p><p class="valueOfSetting"> <%= user.getThemePreference() %> </p> </li>
        <li><p class="labelOfSetting">Questionnaire Completed? </p><p class="valueOfSetting"> <%= user.isQuestionnaireCompleted() %> </p> </li>
    </ul>
    </div>
    <h2>Tagset</h2>
    <div class="settingsCategory">
    <ul>
    <% for(String tag : userTags) { ;%>
        <li><p class="valueOfSetting"><%= tag %></p> </li>
    <% } %>
    </ul>
    </div>
    <h2>Bookmarked Flights</h2>
    <div class="settingsCategory">
        <ul>
        <% for(FlightPathBean flightPath : bookmarkedFlights) { ;%>
            <li>
                <div class="searchResultRow1">
                    <div class="DepartureLocationResult"><%=flightPath.getFlightPath().get(flightPath.getFlightPath().size()-1).getDeparture().getDestinationName()%> &nbsp;</div>
                    <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                    <div class="DestinationLocationResult">&nbsp;<%=flightPath.getInitialFlight().getDestination().getDestinationName()%> &nbsp; </div>
                    <% if(flightPath.getFlightPath().size() == 2){ %>
                    <div class="QuantityOfStops">  (1 stopover) </div>
                    <%}%>
                    <% if(flightPath.getFlightPath().size() > 2){ %>
                    <div class="QuantityOfStops">  (<%=flightPath.getFlightPath().size()-1 %> stopovers) </div>
                    <%}%>
                </div>
            </li>
        <% } %>
        </ul>
    </div>

    <h2>Favourite Destinations</h2>
    <div class="settingsCategory">
    <ul>
    <% for(DestinationBean destination : favouritedDestinations) { ;%>
        <li><p class="valueOfSetting"><%= destination.getDestinationName() %></p> </li>
    <% } %>
    </ul>
    </div>

    <h2>Saved Searches</h2>
    <div class="settingsCategory">
    <div class="savedSearches">
        <ul>
            <% for(SearchBean savedSearch : savedSearches){ %>
            <li><p class="valueOfSetting"> <%= savedSearch.getDeparture() %> > <%= savedSearch.getDestination() %>
            <fmt:formatDate value="<%= savedSearch.getDepartureDate() %>" pattern="dd-MM-yyyy" />
            <%= savedSearch.getAdultPassengers() %> Adults, <%= savedSearch.getChildPassengers() %> Children </p></li>
            <% } %>
        </ul>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>