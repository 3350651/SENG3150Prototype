<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>


<div class="gridParent">
    <% SearchBean search = (SearchBean) session.getAttribute("flightResults"); 
    LinkedList<FlightBean> searchResults = search.getResults();%>
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
                            <form name="flightActions" class="flightSearchResultButtons" action="Search" method="POST">
                                <div class="bookmarkFlight">
                                    <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="bookmark" value="bookmark">
                                </div>
                                <div class="favouriteDestination">
                                    <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="favourite" value="favourite">
                                </div>
                            </form>
                                <form name="groupFavourite" action="GroupHomepage" method="POST">
                                <div class="addToGroupFavouriteList">
                                    <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="addToGroupFaveList" value=<%=flight.getAirline() + "," + flight.getFlightName() + "," + flight.getFlightTime()%>>
                                </div>
                                </form>
                            
                                <form method="POST" action="flightSearch">
                                <input type="hidden" name="flightTime" id="flightTime" value="<%=flight.getFlightTime()%>">
                                <input type="hidden" name="airline" id="Airline" value="<%=flight.getAirline()%>">
                                <input type="hidden" name="flightName" id="FlightName" value="<%=flight.getFlightName()%>">
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
    <% i++; }%>
</div>