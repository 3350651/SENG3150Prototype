!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FlightPub</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="hompage-simplesearch-loggedin">
<jsp:include page='c-Sidebar-Homepage.jsp'></jsp:include>
<div class="main-content">
    <div class="viewAccountSettings">
        <form method="POST" action="MockUpAccountSettings">
            <button name="viewAccountSettings" class="accountButton" value="viewAccountSettings">View Profile</button>
        </form>
    </div>
    <div class="searchParametersSent">
        <h2 class="headingForSearchParameters">Search </h2>
        <p class="summaryOfSearch">Departure: Newcastle Destination: Queensland <br> Date: 28/12/23 Flexibility: 5 days Passengers: 2 adults </p>
    </div>

    <div class="searchResults">
        <div class="FlightSearchResult">
            <div class="flightInfo">
                <div class="searchResultRow1">
                    <div class="DepartureLocationResult">Newcastle</div>
                    <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                    <div class="DestinationLocationResult">Brisbane</div>
                </div>
                <div class="searchResultRow2">
                    <div class="priceResult">$662</div>
                    <div class="dateResult">26/12/23</div>
                    <div class="numPassengersResult">2 adults</div>
                </div>
                <div class="searchResultButtons">
                <form name="flightActions" class="flightSearchResultButtons" action="Search" method="POST">
                    <div class="bookmarkFlight">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="bookmark" value="bookmark">
                    </div>
                    <div class="favouriteDestination">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="favourite" value="favourite">
                    </div>
                    <div class="addToGroupFavouriteList">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="add-to-list" value="add-to-list">
                    </div>
                    <div class="viewFlightDetailsButton">
                        <button type="submit" class="viewFlightDetailsButton" name="viewFlightDetails" value="viewFlightDetails">View Details</button>
                    </div>
                </form>
                </div>
            </div>
            <div class="destinationImage">
                <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
            </div>
        </div>

        <div class="FlightSearchResult">
            <div class="flightInfo">
                <div class="searchResultRow1">
                    <div class="DepartureLocationResult">Newcastle</div>
                    <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                    <div class="DestinationLocationResult">Brisbane</div>
                </div>
                <div class="searchResultRow2">
                    <div class="priceResult">$462</div>
                    <div class="dateResult">2/1/24</div>
                    <div class="numPassengersResult">2 adults</div>
                </div>
                <div class="searchResultButtons">
                <form name="flightActions" class="flightSearchResultButtons" action="Flight" method="POST">
                    <div class="bookmarkFlight">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="action" value="bookmark">
                    </div>
                    <div class="favouriteDestination">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="action" value="favourite">
                    </div>
                    <div class="addToGroupFavouriteList">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="action" value="add-to-list">
                    </div>
                    <div class="viewFlightDetailsButton">
                        <button type="submit" class="viewFlightDetailsButton" name="viewFlightDetails" value="viewFlightDetails">View Details</button>
                    </div>
                </form>
                </div>
            </div>
            <div class="destinationImage">
                <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
            </div>
        </div>

        <div class="FlightSearchResult">
            <div class="flightInfo">
                <div class="searchResultRow1">
                    <div class="DepartureLocationResult">Newcastle</div>
                    <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                    <div class="DestinationLocationResult">Gold Coast</div>
                </div>
                <div class="searchResultRow2">
                    <div class="priceResult">$572</div>
                    <div class="dateResult">1/1/24</div>
                    <div class="numPassengersResult">2 adults</div>
                </div>
                <div class="searchResultButtons">
                <form name="flightActions" class="flightSearchResultButtons" action="Flight" method="POST">
                    <div class="bookmarkFlight">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="action" value="bookmark">
                    </div>
                    <div class="favouriteDestination">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="action" value="favourite">
                    </div>
                    <div class="addToGroupFavouriteList">
                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="action" value="add-to-list">
                    </div>
                    <div class="viewFlightDetailsButton">
                        <button type="submit" class="viewFlightDetailsButton" name="viewFlightDetails" value="viewFlightDetails">View Details</button>
                    </div>
                </form>
                </div>
            </div>
            <div class="destinationImage">
                <img src="${pageContext.request.contextPath}/images/goldCoast.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>