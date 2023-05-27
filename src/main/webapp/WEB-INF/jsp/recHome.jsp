<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.recSearchBean" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.recSearchBean" %>
<%
    UserBean user = (UserBean) session.getAttribute("userBean");
    LinkedList<FlightBean> bookmarkedFlights = new LinkedList<>();
    if (user != null && user.getBookmarkedFlights() != null) {
        bookmarkedFlights = user.getBookmarkedFlights();
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>FlightPub - Recommended Search</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="hompage-simplesearch-loggedin">
<jsp:include page='c-Sidebar-recPage.jsp'></jsp:include>
<div class="main-content">
    <jsp:include page='c-AccountAccess.jsp'></jsp:include>
    <br><br>
    <jsp:include page='c-recSearchBar.jsp'></jsp:include>
    <%---<jsp:include page='c-SimpleSearchUtilities.jsp'></jsp:include>---%>
</div>
    <div class="centeringtext"> <h1>Recommended Flights for You</h1> </div>
    <div class="gridParent">
    <% recSearchBean search = (recSearchBean) session.getAttribute("recFlights"); LinkedList<FlightBean> searchResults = search.getFlightResults();%>
    <% int i = 0; for (FlightBean flight : searchResults ) { %>
        <form method="POST" action="recSearch">
            <div class="recResults">
                <div class="FlightSearchResult1">
                    <div class="flightInfo">
                        <div class="searchResultRow1">
                            <input type="hidden" name="departure" id="departure" value="<%=flight.getDeparture().getDestinationName()%>">
                            <div class="DepartureLocationResult"><%=flight.getDeparture().getDestinationName()%></div>
                            <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                            <input type="hidden" name="destination" id="destination" value="<%=flight.getDestination().getDestinationName()%>">
                            <div class="DestinationLocationResult"><%=flight.getDestination().getDestinationName()%></div>
                        </div>
                        <div class="searchResultRow2">
                            <div class="priceResult">$662</div>
                            <input type="hidden" name="flightTime" id="flightTime" value="<%=flight.getFlightTime()%>">
                            <input type="hidden" name="AirlineName" id="AirlineName" value="<%=flight.getAirlineName()%>">
                            <input type="hidden" name="FlightName" id="FlightName" value="<%=flight.getFlightName()%>">
                            <input type="hidden" name="PlaneType" id="PlaneType" value="<%=flight.getPlaneType()%>">
                            <div class="dateResult"><%=flight.getFlightTime()%></div>
                            <div class="numPassengersResult">2 adults</div>
                        </div>

                        <div class="tagsParent">
                            <div class="tag1">Mild</div>
                            <div class="tag2">Family</div>
                            <div class="tag2"> Reputation: <input type="range" min="1" max="100" value="95" class="slider">95%</div>
                        </div>
                        <span class="brmedium"></span>

                        <div class="searchResultButtons">
                            <form name="flightActions" class="flightSearchResultButtons" action="flightSearch" method="POST">
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
                                    <button type="submit" class="viewFlightDetailsButton" name="viewFlight" value="viewFlight">View Details</button>
                                </div>
                            </form>
                        </div>

                    </div>
                    <div class="destinationImage">
                        <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
                    </div>
                </div>
            </div>
        </form>
    <% i++; }%>
</div>
<div class="centeringtext"> <h1>Most Popular Flights for You</h1> </div>
<div class="gridParent">
    <% int j = 0; for (FlightBean flight : searchResults ) { %>
    <form method="POST" action="recSearch">
        <div class="recResults">
            <div class="FlightSearchResult1">
                <div class="flightInfo">
                    <div class="searchResultRow1">
                        <input type="hidden" name="departure" id="departure" value="<%=flight.getDeparture().getDestinationName()%>">
                        <div class="DepartureLocationResult"><%=flight.getDeparture().getDestinationName()%></div>
                        <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                        <input type="hidden" name="destination" id="destination" value="<%=flight.getDestination().getDestinationName()%>">
                        <div class="DestinationLocationResult"><%=flight.getDestination().getDestinationName()%></div>
                    </div>
                    <div class="searchResultRow2">
                        <div class="priceResult">$662</div>
                        <input type="hidden" name="flightTime" id="flightTime" value="<%=flight.getFlightTime()%>">
                        <input type="hidden" name="AirlineName" id="AirlineName" value="<%=flight.getAirlineName()%>">
                        <input type="hidden" name="FlightName" id="FlightName" value="<%=flight.getFlightName()%>">
                        <input type="hidden" name="PlaneType" id="PlaneType" value="<%=flight.getPlaneType()%>">
                        <div class="dateResult"><%=flight.getFlightTime()%></div>
                        <div class="numPassengersResult">2 adults</div>
                    </div>

                    <div class="tagsParent">
                        <div class="tag1">Mild</div>
                        <div class="tag2">Family</div>
                        <div class="tag2"> Reputation: <input type="range" min="1" max="100" value="95" class="slider">95%</div>
                    </div>
                    <span class="brmedium"></span>

                    <div class="searchResultButtons">
                        <form name="flightActions" class="flightSearchResultButtons" action="flightSearch" method="POST">
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
                                <button type="submit" class="viewFlightDetailsButton" name="viewFlight" value="viewFlight">View Details</button>
                            </div>
                        </form>
                    </div>

                </div>
                <div class="destinationImage">
                    <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
                </div>
            </div>
        </div>
    </form>
    <% j++; }%>
</div>
<div class="centeringtext"> <h1>Budget Flights for You</h1> </div>
<div class="gridParent">
    <% int k = 0; for (FlightBean flight : searchResults ) { %>
    <form method="POST" action="recSearch">
        <div class="recResults">
            <div class="FlightSearchResult1">
                <div class="flightInfo">
                    <div class="searchResultRow1">
                        <input type="hidden" name="departure" id="departure" value="<%=flight.getDeparture().getDestinationName()%>">
                        <div class="DepartureLocationResult"><%=flight.getDeparture().getDestinationName()%></div>
                        <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                        <input type="hidden" name="destination" id="destination" value="<%=flight.getDestination().getDestinationName()%>">
                        <div class="DestinationLocationResult"><%=flight.getDestination().getDestinationName()%></div>
                    </div>
                    <div class="searchResultRow2">
                        <div class="priceResult">$662</div>
                        <input type="hidden" name="flightTime" id="flightTime" value="<%=flight.getFlightTime()%>">
                        <input type="hidden" name="AirlineName" id="AirlineName" value="<%=flight.getAirlineName()%>">
                        <input type="hidden" name="FlightName" id="FlightName" value="<%=flight.getFlightName()%>">
                        <input type="hidden" name="PlaneType" id="PlaneType" value="<%=flight.getPlaneType()%>">
                        <div class="dateResult"><%=flight.getFlightTime()%></div>
                        <div class="numPassengersResult">2 adults</div>
                    </div>

                    <div class="tagsParent">
                        <div class="tag1">Mild</div>
                        <div class="tag2">Family</div>
                        <div class="tag2"> Reputation: <input type="range" min="1" max="100" value="95" class="slider">95%</div>
                    </div>
                    <span class="brmedium"></span>

                    <div class="searchResultButtons">
                        <form name="flightActions" class="flightSearchResultButtons" action="flightSearch" method="POST">
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
                                <button type="submit" class="viewFlightDetailsButton" name="viewFlight" value="viewFlight">View Details</button>
                            </div>
                        </form>
                    </div>

                </div>
                <div class="destinationImage">
                    <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
                </div>
            </div>
        </div>
    </form>
    <% k++; }%>
</div>
<%--</div>--%>
</body>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>