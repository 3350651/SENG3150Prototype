<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%--<%
  UserBean user = (UserBean) session.getAttribute("userBean");
  LinkedList<SearchBean> savedSearches = new LinkedList<>();
  if (user != null && user.getSavedSearches() != null) {
    savedSearches = user.getSavedSearches();
}
%>--%>

<div class="simpleSearchSupports">
    <div class="savedSearches">
        <h2 class="savedSearchesHeading">Saved Searches</h2>
        <form method="POST" action="Search">
            <input type="hidden" value="savedParameter1">
            <button name="savedParameter" type="submit" value="savedParameter1"
                class="savedParameter">placeholder</button><br>
        </form>
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