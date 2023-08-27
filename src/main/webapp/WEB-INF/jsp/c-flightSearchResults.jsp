<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.UserBean" %>

<%  UserBean user=(UserBean) session.getAttribute("userBean"); 
    SearchBean search1= (SearchBean) session.getAttribute("flightResults1"); 
    SearchBean search2= (SearchBean) session.getAttribute("flightResults2"); 
    SearchBean search3= (SearchBean) session.getAttribute("flightResults3"); 
    LinkedList<FlightPathBean> flightResults1 = search1 != null ? search1.getResults(): null;
    LinkedList<FlightPathBean> flightResults2 = search2 != null ? search2.getResults(): null;
    LinkedList<FlightPathBean> flightResults3 = search3 != null ? search3.getResults(): null;
%>

<div class="gridParent" id="simple">
    <%if(flightResults1 != null && flightResults1.size() > 0){%>
    <fieldset>
        <div>
            <h3>
                <%=flightResults1.get(0).getLastFlight().getDestination().getDestinationName()%>
            </h3>
            <%for (FlightPathBean flightPath : flightResults1 ) { %>
                <div class="recResults">
                    <div class="FlightSearchResult">
                        <h2></h2>
                        <div class="simpleFlightCardColumn1">
                            <div class="flightInfo">
                                <div class="searchResultRow1">
                                    <div class="DepartureLocationResult">
                                        <%=flightPath.getInitialFlight().getDeparture().getDestinationName()
                                            %> &nbsp;
                                    </div>
                                    <img src="${pageContext.request.contextPath}/images/planeLogo.png"
                                        alt="Plane Logo" class="smallPlaneLogo">
                                    <div class="DestinationLocationResult">&nbsp;
                                        <%=flightPath.getLastFlight().getDestination().getDestinationName()
                                            %> &nbsp; </div>
                                    <% if(flightPath.getFlightPath().size()==2){ %>
                                        <div class="QuantityOfStops"> (1 stopover)
                                        </div>
                                        <%}%>
                                            <% if(flightPath.getFlightPath().size()>
                                                2){ %>
                                                <div class="QuantityOfStops">
                                                    (<%=flightPath.getFlightPath().size()-1
                                                        %> stopovers) </div>
                                                <%}%>
                                </div>
                                <div class="searchResultRow2">
                                    <div class="priceResult">$
                                        <%=flightPath.getMinPrice()%>
                                    </div>
                                    <div class="dateResult">
                                        <%=flightPath.getInitialFlight().getFlightTime()%>
                                    </div>
                                    <div class="numPassengersResult">Adults:
                                        <%=search1.getAdultPassengers()%>, Children:
                                            <%=search1.getChildPassengers()%>
                                    </div>
                                </div>
                            </div>
                            <div class="searchResultButtons">
                                <% if (user !=null){ %>
                                    <%-- <div class="bookmarkFavouriteAddToGroup">
                                        --%>
                                        <form name="flightActions"
                                            class="flightSearchResultButtons"
                                            action="AccountSettings" method="POST">
                                            <input type="hidden" name="userID"
                                                value="<%= user.getUserID() %>">
                                            <input type="hidden" name="flightIndex"
                                                value="<%= flightResults1.indexOf(flightPath) %>">

                                            <div class="bookmarkFlight">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/bookmark.png"
                                                    alt="Bookmark Flight Logo"
                                                    name="bookmark"
                                                    value="bookmark">
                                            </div>
                                            <div class="favouriteDestination">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/favouriteStar.png"
                                                    alt="Favourite Destination Logo"
                                                    name="favourite"
                                                    value="favourite">
                                            </div>
                                        </form>
                                        <form name="groupFavourite"
                                            class="groupFavouritesForm"
                                            action="GroupHomepage" method="POST">
                                            <div class="addToGroupFavouriteList">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/addToGroupList.png"
                                                    alt="Add To Group Favourite List Logo"
                                                    name="addToGroupFaveList"
                                                    value=<%=flightResults1.indexOf(flightPath)%>>
                                            </div>
                                        </form>
                                        <% } %>
                                            <form method="POST"
                                                action="flightSearch">

                                                <input type="hidden"
                                                    name="dataStructure" value="1">
                                                <input type="hidden"
                                                    name="flightIndex"
                                                    value="<%= flightResults1.indexOf(flightPath) %>">
                                                <div
                                                    class="viewFlightDetailsButton">
                                                    <button type="submit"
                                                        class="viewFlightDetailsButton"
                                                        name="viewFlight"
                                                        value="viewFlight">View
                                                        Details</button>
                                                </div>
                                            </form>
                                            <%-- </div> --%>
                            </div>
                        </div>
                        <div class="destinationImage">
                            <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                                alt="Brisbane Logo" class="smallBrisbaneLogo">
                        </div>
                    </div>
                </div>
                <% }%>
    </fieldset>
    <%}%>
    <%if(flightResults2 != null && flightResults2.size() > 0){%>
    <fieldset>
        <div>
            <h3>
                <%=flightResults2.get(0).getLastFlight().getDestination().getDestinationName()%>
            </h3>
            <% for (FlightPathBean flightPath : flightResults2 ) { %>
                <div class="recResults">
                    <div class="FlightSearchResult">
                        <div class="simpleFlightCardColumn1">
                            <div class="flightInfo">
                                <div class="searchResultRow1">
                                    <div class="DepartureLocationResult">
                                        <%=flightPath.getInitialFlight().getDeparture().getDestinationName()
                                            %> &nbsp;
                                    </div>
                                    <img src="${pageContext.request.contextPath}/images/planeLogo.png"
                                        alt="Plane Logo" class="smallPlaneLogo">
                                    <div class="DestinationLocationResult">&nbsp;
                                        <%=flightPath.getLastFlight().getDestination().getDestinationName()
                                            %> &nbsp; </div>
                                    <% if(flightPath.getFlightPath().size()==2){ %>
                                        <div class="QuantityOfStops"> (1 stopover)
                                        </div>
                                        <%}%>
                                            <% if(flightPath.getFlightPath().size()>
                                                2){ %>
                                                <div class="QuantityOfStops">
                                                    (<%=flightPath.getFlightPath().size()-1
                                                        %> stopovers) </div>
                                                <%}%>
                                </div>
                                <div class="searchResultRow2">
                                    <div class="priceResult">$
                                        <%=flightPath.getMinPrice()%>
                                    </div>
                                    <div class="dateResult">
                                        <%=flightPath.getInitialFlight().getFlightTime()%>
                                    </div>
                                    <div class="numPassengersResult">Adults:
                                        <%=search2.getAdultPassengers()%>, Children:
                                            <%=search2.getChildPassengers()%>
                                    </div>
                                </div>
                            </div>
                            <div class="searchResultButtons">
                                <% if (user !=null){ %>
                                    <%-- <div class="bookmarkFavouriteAddToGroup">
                                        --%>
                                        <form name="flightActions"
                                            class="flightSearchResultButtons"
                                            action="Search" method="POST">
                                            <input type="hidden" name="userID"
                                                value="<%= user.getUserID() %>">
                                            <input type="hidden" name="flightIndex"
                                                value="<%= flightResults2.indexOf(flightPath) %>">

                                            <div class="bookmarkFlight">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/bookmark.png"
                                                    alt="Bookmark Flight Logo"
                                                    name="bookmark"
                                                    value="bookmark">
                                            </div>
                                            <div class="favouriteDestination">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/favouriteStar.png"
                                                    alt="Favourite Destination Logo"
                                                    name="favourite"
                                                    value="favourite">
                                            </div>
                                        </form>
                                        <form name="groupFavourite"
                                            class="groupFavouritesForm"
                                            action="GroupHomepage" method="POST">
                                            <div class="addToGroupFavouriteList">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/addToGroupList.png"
                                                    alt="Add To Group Favourite List Logo"
                                                    name="addToGroupFaveList"
                                                    value=<%=flightResults2.indexOf(flightPath)%>>
                                            </div>
                                        </form>
                                        <% } %>
                                            <form method="POST"
                                                action="flightSearch">

                                                <input type="hidden"
                                                    name="dataStructure" value="2">
                                                <input type="hidden"
                                                    name="flightIndex"
                                                    value="<%= flightResults2.indexOf(flightPath) %>">
                                                <div
                                                    class="viewFlightDetailsButton">
                                                    <button type="submit"
                                                        class="viewFlightDetailsButton"
                                                        name="viewFlight"
                                                        value="viewFlight">View
                                                        Details</button>
                                                </div>
                                            </form>
                                            <%-- </div> --%>
                            </div>
                        </div>
                        <div class="destinationImage">
                            <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                                alt="Brisbane Logo" class="smallBrisbaneLogo">
                        </div>
                    </div>
                </div>
                <% }%>
    </fieldset>
    <%}
    if(flightResults3 != null && flightResults3.size() > 0){ %>
    <fieldset>
        <div>
            <h3>
                <%=flightResults3.get(0).getLastFlight().getDestination().getDestinationName()%>
            </h3>
            <% for (FlightPathBean flightPath : flightResults3 ) { %>
                <div class="recResults">
                    <div class="FlightSearchResult">
                        <h2></h2>
                        <div class="simpleFlightCardColumn1">
                            <div class="flightInfo">
                                <div class="searchResultRow1">
                                    <div class="DepartureLocationResult">
                                        <%=flightPath.getInitialFlight().getDeparture().getDestinationName()
                                            %> &nbsp;
                                    </div>
                                    <img src="${pageContext.request.contextPath}/images/planeLogo.png"
                                        alt="Plane Logo" class="smallPlaneLogo">
                                    <div class="DestinationLocationResult">&nbsp;
                                        <%=flightPath.getLastFlight().getDestination().getDestinationName()
                                            %> &nbsp; </div>
                                    <% if(flightPath.getFlightPath().size()==2){ %>
                                        <div class="QuantityOfStops"> (1 stopover)
                                        </div>
                                        <%}%>
                                            <% if(flightPath.getFlightPath().size()>
                                                2){ %>
                                                <div class="QuantityOfStops">
                                                    (<%=flightPath.getFlightPath().size()-1
                                                        %> stopovers) </div>
                                                <%}%>
                                </div>
                                <div class="searchResultRow2">
                                    <div class="priceResult">$
                                        <%=flightPath.getMinPrice()%>
                                    </div>
                                    <div class="dateResult">
                                        <%=flightPath.getInitialFlight().getFlightTime()%>
                                    </div>
                                    <div class="numPassengersResult">Adults:
                                        <%=search3.getAdultPassengers()%>, Children:
                                            <%=search3.getChildPassengers()%>
                                    </div>
                                </div>
                            </div>
                            <div class="searchResultButtons">
                                <% if (user !=null){ %>
                                    <%-- <div class="bookmarkFavouriteAddToGroup">
                                        --%>
                                        <form name="flightActions"
                                            class="flightSearchResultButtons"
                                            action="Search" method="POST">
                                            <input type="hidden" name="userID"
                                                value="<%= user.getUserID() %>">
                                            <input type="hidden" name="flightIndex"
                                                value="<%= flightResults3.indexOf(flightPath) %>">

                                            <div class="bookmarkFlight">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/bookmark.png"
                                                    alt="Bookmark Flight Logo"
                                                    name="bookmark"
                                                    value="bookmark">
                                            </div>
                                            <div class="favouriteDestination">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/favouriteStar.png"
                                                    alt="Favourite Destination Logo"
                                                    name="favourite"
                                                    value="favourite">
                                            </div>
                                        </form>
                                        <form name="groupFavourite"
                                            class="groupFavouritesForm"
                                            action="GroupHomepage" method="POST">
                                            <div class="addToGroupFavouriteList">
                                                <input type="image"
                                                    class="btn-image"
                                                    src="${pageContext.request.contextPath}/images/addToGroupList.png"
                                                    alt="Add To Group Favourite List Logo"
                                                    name="addToGroupFaveList"
                                                    value=<%=flightResults3.indexOf(flightPath)%>>
                                            </div>
                                        </form>
                                        <% } %>
                                            <form method="POST"
                                                action="flightSearch">

                                                <input type="hidden"
                                                    name="dataStructure" value="3">
                                                <input type="hidden"
                                                    name="flightIndex"
                                                    value="<%= flightResults3.indexOf(flightPath) %>">
                                                <div
                                                    class="viewFlightDetailsButton">
                                                    <button type="submit"
                                                        class="viewFlightDetailsButton"
                                                        name="viewFlight"
                                                        value="viewFlight">View
                                                        Details</button>
                                                </div>
                                            </form>
                                            <%-- </div> --%>
                            </div>
                        </div>
                        <div class="destinationImage">
                            <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                                alt="Brisbane Logo" class="smallBrisbaneLogo">
                        </div>
                    </div>
                </div>
                <% }%>
    </fieldset>
    <%}
    if((flightResults1 == null || flightResults1.size() == 0) && (flightResults2 == null || flightResults2.size() == 0) && (flightResults3 == null || flightResults3.size() == 0)){%>
        <div>Sorry, we could not find any flights for this input. Please try again.</div>
    <%}%>
</div>