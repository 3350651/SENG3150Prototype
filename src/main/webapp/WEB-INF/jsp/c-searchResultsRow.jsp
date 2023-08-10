<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.UserBean" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>

<div class="gridParent">
    <% SearchBean search = (SearchBean) session.getAttribute("flightResults"); 
    LinkedList<FlightPathBean> searchResults = search.getResults();
    session.setAttribute("flightResults", searchResults);
    %>
    <% int i = 0; for (FlightPathBean flightPath : searchResults ) { %>
            <div class="recResults">
                <div class="FlightSearchResult1">
                    <div class="flightInfo">
                        <div class="searchResultRow1">
                            <div class="DepartureLocationResult"><%=flightPath.getInitialFlight().getDeparture().getDestinationName()%></div>
                            <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                            <div class="DestinationLocationResult"><%=flightPath.getLastFlight().getDestination().getDestinationName()%></div>
                        </div>
                        <div class="searchResultRow2">
                            <div class="priceResult">Stopovers: <%=flightPath.getFlightPathStopOvers()%></div>
                            <div class="priceResult">$<%=flightPath.getMinPrice()%></div>
                            <div class="dateResult"><%=flightPath.getInitialFlight().getFlightTime()%></div>
                            <div class="numPassengersResult"><%="Adults: " + search.getAdultPassengers() + ", Children: " + search.getChildPassengers()%></div>
                        </div>

                        <div class="tagsParent">
                            <div class="tag1">Mild</div>
                            <div class="tag2">Family</div>
                            <div class="tag2"> Reputation: <input type="range" min="1" max="100" value="95" class="slider">95%</div>
                        </div>
                        <span class="brmedium"></span>

                        <div class="searchResultButtons">
                            <form name="flightActions" class="flightSearchResultButtons" action="Search" method="POST">
                                <input type="hidden" name="userID" value="<%= user.getUserID() %>">
                                <input type="hidden" name="flightIndex" value="<%= searchResults.indexOf(flightPath) %>">
                                    <div class="bookmarkFlight">
                                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="bookmark" value="bookmark">
                                    </div>
                                    <div class="favouriteDestination">
                                        <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="favourite" value="favourite">
                                    </div>
                            </form>

                            <form name="groupFavourite" action="GroupHomepage" method="POST">
                                <div class="addToGroupFavouriteList">
                                    <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="addToGroupFaveList" value=<%=searchResults.indexOf(flightPath)%>>
                                </div>
                            </form>

                            <form method="POST" action="flightSearch">
                                <input type="hidden" name="flightIndex" value="<%= searchResults.indexOf(flightPath) %>">
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