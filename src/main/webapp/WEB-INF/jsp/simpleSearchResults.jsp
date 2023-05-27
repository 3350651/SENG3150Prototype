<%--
  Created by IntelliJ IDEA.
  User: colli
  Date: 26/05/2023
  Time: 9:59 pm
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.recSearchBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% UserBean user=(UserBean) session.getAttribute("userBean");%>

<html>
<head>
    <meta charset="UTF-8">
    <title>FlightPub</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
<jsp:include page='c-Sidebar-Homepage.jsp'></jsp:include>
<jsp:include page='c-AccountAccess.jsp'></jsp:include>
<% recSearchBean search = (recSearchBean) session.getAttribute("flightResults");
LinkedList<FlightBean> searchResults = search.getFlightResults();%>
<br>
<br>
<div class="centeringtext"> <h1>Search Results</h1> </div>
<div class="gridParent">
<% int i = 0; for (FlightBean flight : searchResults ) { %>
<div class="recResults">
    <div class="FlightSearchResult1">
        <div class="flightInfo">
            <div class="searchResultRow1">
                <div class="DepartureLocationResult"><%=flight.getDeparture().getDestinationName()%></div>
                <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                <div class="DestinationLocationResult"><%=flight.getDestination().getDestinationName()%></div>
            </div>
            <div class="searchResultRow2">
                <div class="priceResult">$662</div>
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
            <form name="flightActions"
                class="flightSearchResultButtons" action="Search"
                method="POST">
                <input type="hidden" name="userID" value= <%= user.getUserID() %> >
                <input type="hidden" name="destinationCode" value= <%= flight.getDestination().getDestinationCode()%> >
                <input type="hidden" name="airlineCode" value= <%= flight.getAirline() %> >
                <input type="hidden" name="flightNumber" value= <%= flight.getFlightName() %> >
                <% String flightTime = flight.getFlightTime().toString(); %>
                <input type="hidden" name="departureTime" value="<%= flightTime %>" >
                <div class="bookmarkFlight">
                    <input type="image" class="btn-image"
                        src="${pageContext.request.contextPath}/images/bookmark.png"
                        alt="Bookmark Flight Logo" name="bookmark"
                        value=<%= i %>>
                </div>
                <div class="favouriteDestination">
                    <input type="image" class="btn-image"
                        src="${pageContext.request.contextPath}/images/favouriteStar.png"
                        alt="Favourite Destination Logo"
                        name="favourite" value="favouriteDestination">
                </div>
                <div class="addToGroupFavouriteList">
                    <input type="image" class="btn-image"
                        src="${pageContext.request.contextPath}/images/addToGroupList.png"
                        alt="Add To Group Favourite List Logo"
                        name="add-to-list" value=<%="add-to-list," +
                        i %>>
                </div>
            </form>
            <form name="viewFlightsForm" class="flightSearchResultButtons" action="flight" method="POST">
                <div class="viewFlightDetailsButton">
                    <button type="submit"
                        class="viewFlightDetailsButton"
                        name="viewFlightDetails"
                        value=<%="viewFlightDetails," + i %>>View
                        Details</button>
                </div>
            </form>

        </div>

        </div>
        <div class="destinationImage">
            <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
        </div>
    </div>
</div>
<% i++; }%>
</div>
</body>
</html>
