<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.UserBean" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>

<div class="gridParent" id="simple">
    <% SearchBean search = (SearchBean) session.getAttribute("flightResults"); 
    LinkedList<FlightPathBean> searchResults = search.getResults();
    session.setAttribute("flightResults", searchResults);
    %>
    <% int i = 0; for (FlightPathBean flightPath : searchResults ) { %>
        <div class="recResults">
            <div class="FlightSearchResult">
                <div class="simpleFlightCardColumn1">
                <div class="flightInfo">
                    <div class="searchResultRow1">
                        <div class="DepartureLocationResult"><%=flightPath.getInitialFlight().getDeparture().getDestinationName() %> &nbsp;</div>
                        <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                        <div class="DestinationLocationResult">&nbsp;<%=flightPath.getLastFlight().getDestination().getDestinationName() %> &nbsp; </div>
                        <% if(flightPath.getFlightPath().size() == 2){ %>
                        <div class="QuantityOfStops">  (1 stopover) </div>
                        <%}%>
                        <% if(flightPath.getFlightPath().size() > 2){ %>
                        <div class="QuantityOfStops">  (<%=flightPath.getFlightPath().size()-1 %> stopovers) </div>
                        <%}%>
                    </div>
                    <div class="searchResultRow2">
                        <div class="priceResult">$<%=flightPath.getMinPrice()%> &nbsp;</div>
                        <div class="dateResult"><%=flightPath.getInitialFlight().getFlightTime()%> &nbsp;</div>
                        <div class="numPassengersResult">Adult: <%=search.getAdultPassengers()%>, Children: <%=search.getChildPassengers()%></div>
                    </div>
                </div>
                <div class="searchResultButtons">
                    <% if (user != null){ %>
                    <%-- <div class="bookmarkFavouriteAddToGroup"> --%>
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
                        <form name="groupFavourite" class="groupFavouritesForm" action="GroupHomepage" method="POST">
                        <div class="addToGroupFavouriteList">
                            <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="addToGroupFaveList" value=<%=searchResults.indexOf(flightPath)%>>
                        </div>
                        </form>
                        <% } %>
                        <form method="POST" action="flightSearch">
                        <input type="hidden" name="flightIndex" value="<%= searchResults.indexOf(flightPath) %>">
                        <div class="viewFlightDetailsButton">
                            <button type="submit" class="viewFlightDetailsButton" name="viewFlight" value="viewFlight">View Details</button>
                        </div>
                        </form>
                    <%-- </div> --%>
                </div>
                </div>
                <div class="destinationImage">
                    <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
                </div>
            </div>
        </div>
    <% i++; }%>
</div>