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

    <div class="travelHistoryRecWithHeading">
        <h2 class="travelHistoryRecommendationHeading"> Based on your recent travel </h2>
        <div class="travelHistoryRecommendation">
            <div class="flightInfoTravelHistoryRecommendation">
                <div class="searchResultRow1TravelHistory">
                    <div class="DepartureLocationResultTravelHistory">placeholder </div>
                    <img src="${pageContext.request.contextPath}/images/planeLogo.png"
                        alt="Plane Logo" class="smallPlaneLogoTravelHistory">
                    <div class="DestinationLocationResultTravelHistory"> placeholder </div>
                </div>
                <div class="searchResultRow2TravelHistory">
                    <div class="priceResultTravelHistory">xxx</div>
                    <div class="dateResultTravelHistory">yyy</div>
                    <div class="numPassengersResultTravelHistory">zzz</div>
                </div>

                <form name="flightActions" class="flightSearchResultButtons" action="Search"
                    method="POST">
                    <div class="searchResultButtonsTravelHistory">
                        <div class="bookmarkFlightTravelHistory">
                            <input type="image" class="btn-image1"
                                src="${pageContext.request.contextPath}/images/bookmark.png"
                                alt="Bookmark Flight Logo" name="bookmark" value="bookmark">
                        </div>
                        <div class="favouriteDestinationTravelHistory">
                            <input type="image" class="btn-image1"
                                src="${pageContext.request.contextPath}/images/favouriteStar.png"
                                alt="Favourite Destination Logo" name="favourite"
                                value="favourite">
                        </div>
                        <div class="addToGroupFavouriteListTravelHistory">
                            <input type="image" class="btn-image1"
                                src="${pageContext.request.contextPath}/images/addToGroupList.png"
                                alt="Add To Group Favourite List Logo" name="add-to-list"
                                value="add-to-list">
                        </div>
                    </div>
                    <div class="viewFlightDetailsButtonTravelHistory">
                        <button type="submit" class="viewFlightDetailsButtonTravelHistory"
                            name="viewFlightDetails" value="viewFlightDetails">View
                            Details</button>
                    </div>
                </form>

            </div>
            <div class="destinationImageTravelHistory">
                <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                    alt="Brisbane Logo" class="smallBrisbaneLogo">
            </div>
        </div>
    </div>
</div>