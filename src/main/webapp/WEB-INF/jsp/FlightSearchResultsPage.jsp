<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.SearchBean" %>
<%@ page import="java.util.LinkedList"%>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Flight Search</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <% SearchBean search = (SearchBean) session.getAttribute("results"); 
        LinkedList<FlightBean> results = search.getResults();%>

    <body class="searchresults-loggedin">
        <div class="sidebar">
        <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
        <!--        Home page button         -->
            <form name="SearchSelect" action="MockupGroup" method="POST">
            <h2>Toggle Search Mode</h2>
                <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> --%>
                <button type="submit" class="button" name="home" value="recommendSearch">Recommend Search</button>
            </form>
        <!--        Favourited Flights         -->
            <form name="goToBookmarkedFlight" action="ViewFlight" method="POST">
            <h2>Bookmarked Flights</h2>
                <button type="submit" class="button" name="goToBookmarkedFlight1" value="goToBookmarkedFlight1">Morrocco, $1,290, 15/12/2023</button>
                <button type="submit" class="button" name="goToBookmarkedFlight2" value="goToBookmarkedFlight2">Thailand, $679, 6/10/2023</button>
            </form>
        <!--        Groups You're In         -->
            <form name="goToGroup" action="MockupGroup" class="groups" method="POST">
                <h2>Group Membership</h2>
                <button type="submit" class="button" name="goToGroup1" value="goToGroup1">Group One</button>
                <button type="submit" class="button" name="createGroup" value="createGroup">Create New Group</button>
            </form>
        </div>
        <div class="main-content">
            <div class="viewAccountSettings">
                <!-- TODO: link to actual Account settings -->
                <form method="POST" action="MockUpAccountSettings">
                    <button name="viewAccountSettings" class="accountButton" value="viewAccountSettings">View Profile</button>
                </form>
            </div>
            <div class="searchParametersSent">
                <h2 class="headingForSearchParameters">Search </h2>
            </div>
        
            <div class="searchResults">
                <% int i=0;
                for(FlightBean flight : results){ %>

                    <div class="FlightSearchResult">
                        <div class="flightInfo">
                            <div class="searchResultRow1">
                                <div class="DepartureLocationResult"><%=flight.getDeparture().getDestinationName()%></div>
                                <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                                <div class="DestinationLocationResult"><%=flight.getDestination().getDestinationName()%></div>
                            </div>
                            <div class="searchResultRow2">
                                <div class="priceResult"><%= "$" + flight.getMinCost()%></div>
                                <div class="dateResult"><%=flight.getFlightTime()%></div>
                                <div class="numPassengersResult"><%=search.getAdultPassengers() + " Adults"%></div>
                            </div>
                            <div class="searchResultButtons">
                            <form name="flightActions" class="flightSearchResultButtons" action="Search" method="POST">
                                <div class="bookmarkFlight">
                                    <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="bookmark" value=<%="bookmark" + i %>>
                                </div>
                                <div class="favouriteDestination">
                                    <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="favourite" value=<%="favourite" + i %>>
                                </div>
                                <div class="addToGroupFavouriteList">
                                    <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="add-to-list" value=<%="add-to-list" + i %>>
                                </div>
                                <div class="viewFlightDetailsButton">
                                    <button type="submit" class="viewFlightDetailsButton" name="viewFlightDetails" value=<%="viewFlightDetails" + i %>>View Details</button>
                                </div>
                            </form>
                            </div>
                        </div>
                        <div class="destinationImage">
                            <!-- TODO: figure out how to get images of the destination here -->
                            <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
                        </div>
                    </div>
                    
                    <% i++;
                }%>
            </div>
        </div>
    </body>

    </html>