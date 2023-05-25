<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.SearchBean" %>
        <%@ page import="java.util.LinkedList" %>
            <%@ page import="startUp.UserBean" %>
                <%@ page import="startUp.GroupBean" %>
                    <% UserBean user=(UserBean) session.getAttribute("userBean");%>

                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <title>Flight Search</title>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                        </head>

                        <% SearchBean search=(SearchBean) session.getAttribute("results"); LinkedList<FlightBean>
                            results =
                            search.getResults();%>
                            <% LinkedList<GroupBean> groups = (LinkedList<GroupBean>) session.getAttribute("groups");%>

                                    <body class="searchresults-loggedin">
                                        <div class="sidebar">
                                            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                                                alt="FlightPub Logo" class="logo">
                                            <%-- Home page button --%>
                                                <!-- TODO: go to recommended search -->
                                                <form name="SearchSelect" action="recSearch" method="GET">
                                                    <h2>Toggle Search Mode</h2>
                                                    <%-- <button type="submit" class="button" name="home"
                                                        value="simpleSearch">Simple
                                                        Search</button> --%>
                                                        <button type="submit" class="button" name="home"
                                                            value="recommendSearch">Recommend
                                                            Search</button>
                                                </form>
                                                <%-- Favourited Flights --%>
                                                    <!-- TODO: go to flight details page -->
                                                    <form name="goToBookmarkedFlight" action="ViewFlight" method="POST">
                                                        <h2>Bookmarked Flights</h2>
                                                    </form>
                                                    <%-- Groups You're In --%>
                                                        <% if(user !=null){%>
                                                            <h2>Group Membership</h2>
                                                            <!-- TODO: go to group -->
                                                            <% if(groups !=null && !groups.isEmpty()){ int
                                                                size=groups.size(); String name="" ; for(int i=0; i <
                                                                size; i++){ GroupBean group=groups.pop();
                                                                name=group.getGroupName(); %>
                                                                <div class="goGroup">
                                                                    <form method="GET" action="GroupHomepage">
                                                                        <button name="goGroup" value="goGroup">
                                                                            <%= name %>
                                                                        </button>
                                                                        <input type="hidden" id="groupName"
                                                                            name="groupName" value="<%= name %>">
                                                                    </form>
                                                                </div>
                                                                <% groups.addLast(group); } } %>
                                                                    <form name="goToGroup" action="CreateGroup"
                                                                        class="groups" method="GET">
                                                                        <button type="submit" class="button"
                                                                            name="createGroup"
                                                                            value="createGroup">Create
                                                                            New Group</button>
                                                                    </form>
                                                                    <%}%>
                                        </div>
                                        <div class="main-content">
                                            <div class="viewAccountSettings">
                                                <%if(user == null){%>
                                                    <% if (user==null) { %>
                                                        <div class="createAccount">
                                                            <form method="GET" action="CreateAccount">
                                                                <button name="viewAccountSettings" class="accountButton"
                                                                    value="viewAccountSettings">Create Account</button>
                                                            </form>
                                                        </div>
                                                        <div class="logInToAccount">
                                                            <form method="GET" action="login">
                                                                <button name="viewAccountSettings" class="accountButton"
                                                                    value="viewAccountSettings">Log In</button>
                                                            </form>
                                                        </div>
                                                        <% } %>

                                                    <%}else{%>
                                                        <!-- TODO: link to actual Account settings -->
                                                        <form method="POST" action="AccountSettings">
                                                            <button name="viewAccountSettings" class="accountButton"
                                                                value="viewAccountSettings">View Profile</button>
                                                        </form>
                                                        <%}%>

                                            </div>
                                            <div class="searchParametersSent">
                                                <h2 class="headingForSearchParameters">Search </h2>
                                            </div>

                                            <div class="searchResults">
                                                <% int i=0; for(FlightBean flight : results){ %>

                                                    <div class="FlightSearchResult">
                                                        <div class="flightInfo">
                                                            <div class="searchResultRow1">
                                                                <div class="DepartureLocationResult">
                                                                    <%=flight.getDeparture().getDestinationName()%>
                                                                </div>
                                                                <img src="${pageContext.request.contextPath}/images/planeLogo.png"
                                                                    alt="Plane Logo" class="smallPlaneLogo">
                                                                <div class="DestinationLocationResult">
                                                                    <%=flight.getDestination().getDestinationName()%>
                                                                </div>
                                                            </div>
                                                            <div class="searchResultRow2">
                                                                <div class="priceResult">
                                                                    <%= "$" + flight.getMinCost()%>
                                                                </div>
                                                                <div class="dateResult">
                                                                    <%=flight.getFlightTime()%>
                                                                </div>
                                                                <div class="numPassengersResult">
                                                                    <%=search.getAdultPassengers() + " Adults" %>
                                                                </div>
                                                            </div>
                                                            <div class="searchResultButtons">
                                                                <form name="flightActions"
                                                                    class="flightSearchResultButtons" action="Search"
                                                                    method="POST">
                                                                    <div class="bookmarkFlight">
                                                                        <input type="image" class="btn-image"
                                                                            src="${pageContext.request.contextPath}/images/bookmark.png"
                                                                            alt="Bookmark Flight Logo" name="bookmark"
                                                                            value=<%="bookmark," + i %>>
                                                                    </div>
                                                                    <div class="favouriteDestination">
                                                                        <input type="image" class="btn-image"
                                                                            src="${pageContext.request.contextPath}/images/favouriteStar.png"
                                                                            alt="Favourite Destination Logo"
                                                                            name="favourite" value=<%="favourite," + i
                                                                            %>>
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
                                                            <!-- TODO: figure out how to get images of the destination here -->
                                                            <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                                                                alt="Brisbane Logo" class="smallBrisbaneLogo">
                                                        </div>
                                                    </div>

                                                    <% i++; }%>
                                            </div>
                                        </div>
                                    </body>

                        </html>