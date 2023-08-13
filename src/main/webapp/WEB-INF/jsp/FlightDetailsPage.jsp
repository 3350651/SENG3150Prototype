<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>

<% FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight"); %>
<% LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList"); %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<% boolean viewReturnFlightSearchResults = (Boolean) session.getAttribute("viewReturnFlightSearchResults"); %>
<% boolean viewReturnFlightDetails = (Boolean) session.getAttribute("viewReturnFlightDetails"); %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>startUp.FlightDetailsPage</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <main>
            <header>
                <button class="button" type="button" name="back" onclick="history.back()">Back</button>

                <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                    alt="FlightPub Logo" class="centreLogo">
                <br />
                <br />
                <label for="progress">
                    <h2>Progress</h2>
                </label>
                <div class="outerProgress">
                    <div class="innerProgress" id="progress" style="width:33%">33%</div>
                </div>

                <h1 style="margin-top: 50px;">
                    <%= flightPath.getInitialFlight().getDeparture().getDestinationName() %>
                    To
                    <%= flightPath.getLastFlight().getDestination().getDestinationName()%>
                </h1>
            </header>


            <table>
            <% int i = 0; for (FlightBean flight : flightList ) { %>
                <tr>
                    <!-- TODO: figure out how to get images from the destination -->
                    <td class="filledSection"><img
                            src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                            alt="Destination Image" width="250px" height="auto"
                            class="destinationImage">
                    </td>
                    <td class="filledSection">
                        <div class="mainFlightDetailCell">
                            <h3>Flight Details:</h3>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn2">
                                    <p>
                                        <strong>
                                        <%=flight.getDeparture().getDestinationName().toUpperCase()%>
                                         &#8212;
                                        <%=flight.getDestination().getDestinationName().toUpperCase()%>
                                        </strong>
                                    </p>
                                    <p>
                                        <%=flight.getFlightTime().toLocalDateTime().getDayOfMonth()%>
                                        <%=flight.getMonthName(flight.getFlightTime())%>
                                        <%=flight.getFlightTime().toLocalDateTime().getYear()%>
                                        <br />
                                        <%=flight.getCivilianTime(flight.getFlightTime())%>
                                        <br />
                                    </p>

                                    <p>
                                        <%=flight.getFlightArrivalTime().toLocalDateTime().getDayOfMonth()%>
                                        <%=flight.getMonthName(flight.getFlightArrivalTime())%>
                                        <%=flight.getFlightArrivalTime().toLocalDateTime().getYear()%>
                                        <br />
                                        <%=flight.getCivilianTime(flight.getFlightArrivalTime())%>
                                        <br />
                                    </p>
                                </div>
                                <div class="flightDetailsColumn2">
                                    <p>
                                        <%=flight.getFlightName()%>
                                    </p>
                                    <p>
                                        <strong>DEPARTURE</strong>
                                        <br />
                                        <%=flight.getDeparture().getDestinationName()%>
                                    </p>
                                    <p>
                                        <strong>ARRIVAL</strong>
                                        <br />
                                        <%=flight.getDestination().getDestinationName()%>
                                    </p>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumnLeft">
                                    <p>Flight operated by: </p>
                                    <p>Plane model: </p>
                                </div>
                                <div class="flightDetailsColumnLeft">
                                    <p><%=flight.getAirlineName()%></p>
                                    <p><%=flight.getPlaneType()%></p>
                                </div>
                                <div class="flightDetailsColumnRight">
                                    <p>Minimum price: <%=flight.getMinCost()%></p>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <% i++; %>
            <% } %>
                <tr>
                    <td class="filledSection">
                        <p><strong>Tags:</strong>

                            <%LinkedList<String> tags = flightPath.getLastFlight().getDestination().getTags();
                            if(tags != null){
                                for(String tag: tags){
                                    if(tag != tags.getLast()){ %>
                                        <%=tag +", "%>
                                    <% }
                                    else { %>
                                        <%=tag + " ."%>
                                    <%}%>
                                <%}%>
                            <%}%>
                        </p>
                    </td>
                    <td class="filledSection">
                        <p>
                            <%= flightPath.getLastFlight().getDestination().getDestinationDescription()%>
                            <br />
                            <strong>Reputation Score: </strong>
                            <%= flightPath.getLastFlight().getDestination().getReputationScore()%>
                        </p>
                    </td>
                </tr>

                <% if(user==null){%>
            </table>
                    <% }else{ %>

                    <tr>
                        <td class="filledSection" colspan="2" style="text-align: center;">
                            <div class="floatGroupFavButton">
                                <form name="addToGroupFaveList" action="GroupHomepage" method="GET">
                                    <button class="button" type="submit" class="addToGroupFaveList" name="addToGroupFaveList"
                                        id="addToGroupFaveList" value="addToGroupFaveList">Add To Group Favourite List</button>
                                </form>
                            </div>
                        </td>
                    </tr>
            </table>

            <% if (!viewReturnFlightSearchResults && !viewReturnFlightDetails) { %>
                <fieldset class="background">
                    <form action="flightSearch" method="POST">
                        <label for="returnDate">Return Date:</label>
                        <input type="date" id="returnDate" name="returnDate" value="<%= flightPath.getLastFlight().getTomorrow() %>" min="<%= flightPath.getLastFlight().getTomorrow() %>">
                        <input type="hidden" name="departureLocation" value="<%= flightPath.getLastFlight().getDestination().getDestinationCode() %>">
                        <input type="hidden" name="arrivalLocation" value="<%= flightPath.getInitialFlight().getDeparture().getDestinationCode() %>">
                        <br />
                        <button name="searchResults" type="submit" value="simpleReturnSearchResults" class="search">Search</button>
                    </form>
                    <br />
                    <form action="createBooking" method="POST">
                        <input type="hidden" name="details" value="true">
                        <label for="numPassengers">Passengers: </label>
                        <input type="number" name="numPassengers" id="numPassengers">
                        <div class="recurringBookingInput">
                            <label for="check">Recurring Booking: </label>
                            <input id="recurCheck" name="recurCheck" type="checkbox">
                            <div class="recurringWeeklyOrBiWeekly" name="recurringWeeklyOrBiWeekly"
                                id="recurringWeeklyOrBiWeekly">
                                <label>
                                    <input type="radio" name="frequency" value="weekly">
                                    Weekly
                                </label>
                                <label>
                                    <input type="radio" name="frequency" value="biweekly">
                                    Biweekly
                                </label>
                            </div>
                        </div>

                        <button class="button" type="submit" name="oneWay" value="oneWay">
                            Continue One Way
                        </button>
                        <br />
            <% } %>
            <% if (viewReturnFlightSearchResults) { %>
                <div class="centeringtext"> <h1>Search Results</h1> </div>
                <jsp:include page="c-searchResultsRow.jsp">
                    <jsp:param name="isReturnResults" value="true" />
                </jsp:include>
            <% } %>
            <%
                if (viewReturnFlightDetails) {
                FlightPathBean returnFlightPath = (FlightPathBean) session.getAttribute("returnFlight");
                LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList");
            %>
                <h1 style="margin-top: 50px;">
                    <%= returnFlightPath.getInitialFlight().getDeparture().getDestinationName() %>
                    To
                    <%= returnFlightPath.getLastFlight().getDestination().getDestinationName()%>
                </h1>
                <br />

                </header>

                <table>
                    <% int j = 0; for (FlightBean flight : returnFlightList ) { %>
                    <tr>
                        <!-- TODO: figure out how to get images from the destination -->
                        <td class="filledSection"><img
                                src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                                alt="Destination Image" width="250px" height="auto"
                                class="destinationImage">
                        </td>
                        <td class="filledSection">
                            <div class="mainFlightDetailCell">
                                <h3>Flight Details:</h3>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn2">
                                        <p>
                                            <strong>
                                                <%=flight.getDeparture().getDestinationName().toUpperCase()%>
                                                &#8212;
                                                <%=flight.getDestination().getDestinationName().toUpperCase()%>
                                            </strong>
                                        </p>
                                        <p>
                                            <%=flight.getFlightTime().toLocalDateTime().getDayOfMonth()%>
                                            <%=flight.getMonthName(flight.getFlightTime())%>
                                            <%=flight.getFlightTime().toLocalDateTime().getYear()%>
                                            <br />
                                            <%=flight.getCivilianTime(flight.getFlightTime())%>
                                            <br />
                                        </p>

                                        <p>
                                            <%=flight.getFlightArrivalTime().toLocalDateTime().getDayOfMonth()%>
                                            <%=flight.getMonthName(flight.getFlightArrivalTime())%>
                                            <%=flight.getFlightArrivalTime().toLocalDateTime().getYear()%>
                                            <br />
                                            <%=flight.getCivilianTime(flight.getFlightArrivalTime())%>
                                            <br />
                                        </p>
                                    </div>
                                    <div class="flightDetailsColumn2">
                                        <p>
                                            <%=flight.getFlightName()%>
                                        </p>
                                        <p>
                                            <strong>DEPARTURE</strong>
                                            <br />
                                            <%=flight.getDeparture().getDestinationName()%>
                                        </p>
                                        <p>
                                            <strong>ARRIVAL</strong>
                                            <br />
                                            <%=flight.getDestination().getDestinationName()%>
                                        </p>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumnLeft">
                                        <p>Flight operated by: </p>
                                        <p>Plane model: </p>
                                    </div>
                                    <div class="flightDetailsColumnLeft">
                                        <p><%=flight.getAirlineName()%></p>
                                        <p><%=flight.getPlaneType()%></p>
                                    </div>
                                    <div class="flightDetailsColumnRight">
                                        <p>Minimum price: <%=flight.getMinCost()%></p>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    <tr>
                        <td class="filledSection">
                            <p><strong>Tags:</strong>

                                <%LinkedList<String> returnTags = returnFlightPath.getLastFlight().getDestination().getTags();
                                    if(tags != null){
                                        for(String tag: tags){
                                            if(tag != tags.getLast()){ %>
                                            <%=tag +", "%>
                                            <% }
                                            else { %>
                                            <%=tag + " ."%>
                                            <%}%>
                                        <%}%>
                                    <%}%>
                            </p>
                        </td>
                        <td class="filledSection">
                            <p>
                                <%= flightPath.getLastFlight().getDestination().getDestinationDescription()%>
                                <br />
                                <strong>Reputation Score: </strong>
                                <%= flightPath.getLastFlight().getDestination().getReputationScore()%>
                            </p>
                        </td>
                    </tr>

                    <% if(user==null){%>
                </table>
                <% }else{ %>

                    <tr>
                        <td class="filledSection" colspan="2" style="text-align: center;">
                            <div class="floatGroupFavButton">
                                <form name="addToGroupFaveList" action="GroupHomepage" method="GET">
                                    <button class="button" type="submit" class="addToGroupFaveList" name="addToGroupFaveList"
                                            id="addToGroupFaveList" value="addToGroupFaveList">Add To Group Favourite List</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    </table>
                <% } %>
            <% } %>


                        <!-- RETURN FLIGHTS
                                                <%LinkedList<FlightBean> returnFlights = (LinkedList<FlightBean>) request.getAttribute("returnFlights");
                                                if(returnFlights != null){
                                                    request.setAttribute("returnFlights", returnFlights);
                                                    int index = 0;
                                                    for(FlightBean returnFlight : returnFlights){ %>
                                                        <fieldset class="foreground">
                                                            <button class="selectFlight" type="submit" name="returnFlight"
                                                                value=<%=index%>>Select</button>
                                                            <p class="flightDetails">
                                                                <strong>Airline: </strong>
                                                                <%=returnFlight.getAirlineName()%>
                                                                    <br />
                                                                    <strong>Departure Time:</strong>
                                                                    <%=returnFlight.getFlightTime()%>
                                                                        <br />
                                                                        <strong>Flight Name:</strong>
                                                                        <%=returnFlight.getFlightName()%>
                                                                            <br />
                                                                            <strong>Plane Model:</strong>
                                                                            <%=returnFlight.getPlaneType()%>
                                                                                <br />
                                                                                <h3>Minimum price:
                                                                                    <%=returnFlight.getMinCost()%>
                                                                                </h3>
                                                            </p>
                                                        </fieldset>
                                                        <% index++;
                                                    }%>
                                                <%}%>
                        -->
                    </form>
                </fieldset>
                <%}%>
        </main>
    </body>

</html>