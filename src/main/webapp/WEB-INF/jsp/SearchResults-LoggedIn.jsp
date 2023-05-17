!DOCTYPE html>

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
    <form name="BackToHome" action="login" method="GET">
        <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> --%>
        <button type="submit" class="button" name="home" value="backToHome">Home</button>
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
        <button type="submit" class="button" name="goToGroup1" value="goToGroup1">Group 1</button>
        <button type="submit" class="button" name="createGroup" value="createGroup">Create New Group</button>
    </form>
</div>
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
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>