<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.UserBean" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<% String isReturnResults = (String) request.getParameter("isReturnResults"); %>

<div class="gridParent" id="simple">
    <% SearchBean search;
        if (isReturnResults.equalsIgnoreCase("false")) {
            search = (SearchBean) session.getAttribute("searchResults");
        }
        else {
            search = (SearchBean) session.getAttribute("returnFlightResults");
        }
        //SearchBean search = isReturnResults.equalsIgnoreCase("false") ? (SearchBean) session.getAttribute("flightResults") : (SearchBean) session.getAttribute("returnFlightResults");
        LinkedList<FlightPathBean> flightResults = search.getResults();

        if (isReturnResults.equalsIgnoreCase("false")) {
            session.setAttribute("flightResultList", flightResults);
        }
        else {
            session.setAttribute("returnFlightResultList", flightResults);
        }

    if(flightResults.size() !=0 ){
    int i = 0; for (FlightPathBean flightPath : flightResults ) { %>
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
                        <input type="hidden" name="flightIndex" value="<%= flightResults.indexOf(flightPath) %>">

                            <div class="bookmarkFlight">
                                <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/bookmark.png" alt="Bookmark Flight Logo" name="bookmark" value="bookmark">
                            </div>
                            <div class="favouriteDestination">
                                <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/favouriteStar.png" alt="Favourite Destination Logo" name="favourite" value="favourite">
                            </div>
                        </form>
                        <form name="addToAGroupList" class="groupFavouritesForm" action="GroupHomepage" method="POST">
                        <input type="hidden" name="flightIndex" value="<%= flightResults.indexOf(flightPath) %>">
                        <div class="addToGroupFavouriteList">
                            <input type="image" class="btn-image" src="${pageContext.request.contextPath}/images/addToGroupList.png" alt="Add To Group Favourite List Logo" name="addToAGroupList" value="addToAGroupList">
                        </div>
                        </form>
                        <% } %>
                        <form method="POST" action="flightSearch">
                        <input type="hidden" name='<%= (isReturnResults.equals("false") ? "flightIndex" : "returnFlightIndex" )%>' value="<%= flightResults.indexOf(flightPath) %>">
                        <input type="hidden" name="isReturnResults" value="<%= isReturnResults %>">
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
    <% i++; }
    } else {%>
        <div>Sorry, there were no flights found for this search. Please try again.</div>
    <%}%>
</div>