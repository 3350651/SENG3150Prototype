<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FlightPub</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="hompage-simplesearch-loggedin">
<div class="sidebar">
<img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
<%--        Home page button         --%>
    <form name="SearchSelect" action="recSearch" method="GET">
    <h2>Toggle Search Mode</h2>
        <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> --%>
        <button type="submit" class="button" name="home" value="recommendSearch">Recommend Search</button>
    </form>
<%--        Favourited Flights         --%>
    <form name="goToBookmarkedFlight" action="ViewFlight" method="POST">
    <h2>Bookmarked Flights</h2>
        <button type="submit" class="button" name="goToBookmarkedFlight1" value="goToBookmarkedFlight1">Morrocco, $1,290, 15/12/2023</button>
        <button type="submit" class="button" name="goToBookmarkedFlight2" value="goToBookmarkedFlight2">Thailand, $679, 6/10/2023</button>
    </form>
<%--        Groups You're In         --%>
    <form name="goToGroup" action="MockupGroup" class="groups" method="POST">
        <h2>Group Membership</h2>
        <button type="submit" class="button" name="goToGroup1" value="goToGroup1">Group One</button>
        <button type="submit" class="button" name="createGroup" value="createGroup">Create New Group</button>
    </form>
</div>
<div class="main-content">
    <div class="viewAccountSettings">
        <form method="POST" action="MockUpAccountSettings">
            <button name="viewAccountSettings" class="accountButton" value="viewAccountSettings">View Profile</button>
        </form>
    </div>
    <br><br>
    <div class="simpleSearch">
        <form method="POST" action="Search" class="simpleSearchForm">

            <div class="departureLocation"><label for="departureLocation">Leaving From</label><br>
            <input type="text" id="departureLocation" value="Newcastle" name="departureLocation"></div>
            <div class="arrivalLocation"><label for="arrivalLocation">Going To</label><br>
            <input type="text" id="arrivalLocation" name="arrivalLocation"></div>
            <div style="clear:both;">&nbsp;</div>
            <div class="departureDate"><label for="departureDate">Date</label><br>
            <input type="date" id="departureDate" name="departureDate"></div>
        <div class="flexibleDateDiv" id="flexibleDateDiv"><div class="dateAndCheckBox"><label for="flexibleDate">Flexible?</label> <br>
            <input type="checkbox" id="flexibleDate" name="flexibleDate"></div>
            <div class="flexibleDaysGroup" id="flexibleDaysGroup" style="display:none;">
            <label for="flexibleDays">Days flexible?</label><br>
            <input type="number" min="0" max="30" step="1" id="flexibleDays" name="flexibleDays">
            </div></div>
            <div class="numberOfAdults"><label for="numberOfAdults"># Adults</label><br>
            <input type="number" id="numberOfAdults" size="2" name="numberOfAdults"></div>
            <div class="numberOfChildren"><label for="numberOfChildren"># Children</label><br>
            <input type="number" id="numberOfChildren" size="2" name="numberOfChildren"></div>
            <div style="clear:both;">&nbsp;</div>
            <div style="clear:both;">&nbsp;</div>
            <div class="saveParam">
            <button name="saveParam" type="submit" value="saveParam" class="saveParam">Save Search Parameters</button>
            </div>
            <div class="search">
            <button name="searchLogged" type="submit" value="searchLogged" class="search">Search For Flights</button>
            </div>
        </form>
    </div>
    <div class="simpleSearchSupports">
            <div class="savedSearches">
            <h2 class="savedSearchesHeading">Saved Searches</h2>
                <form method="POST" action="Search">
                <input type="hidden" value="savedParameter1">
                <button name="savedParameter" type="submit" value="savedParameter1" class="savedParameter">NTL > BNE, 2 adults, 28/12/23 (+5d)</button><br>
                </form>
            </div>

            <div class="travelHistoryRecWithHeading">
            <h2 class="travelHistoryRecommendationHeading"> Based on your recent travel </h2>
            <div class="travelHistoryRecommendation">
                <div class="flightInfoTravelHistoryRecommendation">
                    <div class="searchResultRow1TravelHistory">
                        <div class="DepartureLocationResultTravelHistory">Newcastle  </div>
                        <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogoTravelHistory" >
                        <div class="DestinationLocationResultTravelHistory">Adelaide</div>
                    </div>
                    <div class="searchResultRow2TravelHistory">
                        <div class="priceResultTravelHistory">$422</div>
                        <div class="dateResultTravelHistory">21/06/23</div>
                        <div class="numPassengersResultTravelHistory">1 adult</div>
                    </div>

                    <form name="flightActions" class="flightSearchResultButtons" action="Search" method="POST">
                        <div class="searchResultButtonsTravelHistory">
                        <div class="bookmarkFlightTravelHistory">
                            <input type="image" class="btn-image1" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="bookmark" value="bookmark">
                        </div>
                        <div class="favouriteDestinationTravelHistory">
                            <input type="image" class="btn-image1" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="favourite" value="favourite">
                        </div>
                        <div class="addToGroupFavouriteListTravelHistory">
                            <input type="image" class="btn-image1" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="add-to-list" value="add-to-list">
                        </div>
                        </div>
                        <div class="viewFlightDetailsButtonTravelHistory">
                            <button type="submit" class="viewFlightDetailsButtonTravelHistory" name="viewFlightDetails" value="viewFlightDetails">View Details</button>
                        </div>
                    </form>

                </div>
                <div class="destinationImageTravelHistory">
                    <img src="${pageContext.request.contextPath}/images/Adelaide.jpg" alt="Adelaide Logo" class="smallBrisbaneLogo" >
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>