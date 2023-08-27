<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.SearchBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<%
LinkedList<SearchBean> savedSearches = new LinkedList<>();
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
<body>
<jsp:include page='c-Sidebar-Account.jsp'></jsp:include>

<div class="main-content">
    <h1>Modify Saved Searches</h1>
        <% for(SearchBean savedSearch : savedSearches){ %>
            <div class="savedSearch">

            <p> <%= savedSearch.getDeparture() %> > <%= savedSearch.getDestination() %> <br>
             Departing on <fmt:formatDate value="<%= savedSearch.getDepartureDate() %>" pattern="dd-MM-yyyy" /> <br>
             <%= savedSearch.getAdultPassengers() %> Adults, <%= savedSearch.getChildPassengers() %> Children</p>

            <form method="POST" action="AccountSettings">
            <input type="hidden" name="searchID" value="<%= savedSearch.getSearchID() %>">
            <input type="hidden" name="userID" value="<%= user.getUserID() %>">
            <button name="removeSearchParameters" type="submit" value="removeSearchParameters" id="removeBookmarkedFlight" class="button">
                Delete Search Parameters From Profile
            </button><br>
            </form>

            <form method="POST" action="flightSearch" name="simpleSearchForm">
                <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                <input type="hidden" name="departureLocation" value="<%= savedSearch.getDeparture() %>">
                <input type="hidden" name="arrivalLocation" value="<%= savedSearch.getDestination() %>">
                <input type="hidden" name="departureDate" value="<%= savedSearch.formatTimestampToDate(savedSearch.getDepartureDate()) %>">
                <input type="hidden" name="numberOfAdults" value="<%= savedSearch.getAdultPassengers() %>">
                <input type="hidden" name="numberOfChildren" value="<%= savedSearch.getChildPassengers() %>">
                <input type="hidden" name="flexibleDays" value="<%= savedSearch.getFlexible() %>">
                <% if(savedSearch.getFlexible() == 0){ %>
                <input type="hidden" name="flexibleDate" value="<%= false %>">
                <% } else { %>
                <input type="hidden" name="flexibleDate" value="<%= true %>">
                <% } %>
                <button name="searchResults" type="submit" value="simpleSearchResults" class="button" id="flightDetailsModifyBookmarked">
                    Search
                </button><br>
            </form>
            </div>
        <% } %>
</div>

</body>
<script type="text/javascript" src="script.js"></script>
</html>
