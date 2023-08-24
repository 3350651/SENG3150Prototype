<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
  UserBean user = (UserBean) session.getAttribute("userBean");
  LinkedList<SearchBean> savedSearches = new LinkedList<>();
  if (user != null) {
    savedSearches = user.getSavedSearches();
}
%>

<div class="simpleSearchSupports">
    <div class="savedSearches">
        <% if (user != null && savedSearches != null) { %>
            <h2 class="savedSearchesHeading">Saved Searches</h2> <%
            for (int i = 0; i < savedSearches.size(); i++) {
                SearchBean savedSearch = savedSearches.get(i);
            %>

            <%  Timestamp timestamp = savedSearch.getDepartureDate();
                String timestampAsString = String.valueOf(timestamp);

                String[] parts = timestampAsString.split(" ");
                String date= parts[0]; %>

            <form method="POST" action="flightSearch">
                <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                <input type="hidden" name="departureLocation" value="<%= savedSearch.getDeparture() %>">
                <input type="hidden" name="arrivalLocation" value="<%= savedSearch.getDestination() %>">
                <input type="hidden" name="departureDate" value="<%= date %>">
                <input type="hidden" name="departureLocation" value="<%= savedSearch.getDeparture() %>">
                <input type="hidden" name="flexibleDays" value="<%= savedSearch.getFlexible() %>">
                <% if(savedSearch.getFlexible() == 0){ %>
                <input type="hidden" name="flexibleDate" value="<%= false %>">
                <% } else { %>
                <input type="hidden" name="flexibleDate" value="<%= true %>">
                <% } %>
                <input type="hidden" name="numberOfAdults" value="<%= savedSearch.getAdultPassengers() %>">
                <input type="hidden" name="numberOfChildren" value="<%= savedSearch.getChildPassengers() %>">
                <button name="searchResults" type="submit" value="simpleSearchResults"
                        class="savedParameter">
                    <%= savedSearch.getDeparture() %> > <%= savedSearch.getDestination() %> <br>
                    <fmt:formatDate value="<%= savedSearch.getDepartureDate() %>" pattern="dd-MM-yyyy" />
                    <%= savedSearch.getAdultPassengers() %> Adults, <%= savedSearch.getChildPassengers() %> Children
                </button><br>
            </form>
            <% }
           } %>
    </div>
</div>