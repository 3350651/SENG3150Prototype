<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.SearchBean" %>
<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="java.util.LinkedList" %>

<% FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight"); %>
<% LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList"); %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<% LinkedList<String> destinationTags = (LinkedList<String>) session.getAttribute("destinationTags"); %>
<% boolean viewReturnFlightSearchResults = (Boolean) session.getAttribute("viewReturnFlightSearchResults"); %>
    <% viewReturnFlightSearchResults = (session.getAttribute("viewReturnFlightSearchResults") == null ? false : viewReturnFlightSearchResults); %>
<% boolean viewReturnFlightDetails = (Boolean) session.getAttribute("viewReturnFlightDetails"); %>
    <% viewReturnFlightDetails = (session.getAttribute("viewReturnFlightDetails") == null ? false : viewReturnFlightDetails); %>
<% int numAdults = (Integer) session.getAttribute("numAdults"); int numChildren = (Integer) session.getAttribute("numChildren"); %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Flight Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <script src="${pageContext.request.contextPath}/scripts/script.js"></script>
    </head>

    <body>
        <main>
            <header>
                <form method="POST" action="createBooking" class="back" name="back">
                    <button name="back" type="submit" value="back" class="search">Back</button>
                </form>

                <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                    alt="FlightPub Logo" class="centreLogo">
                <h1>Flight Details</h1>
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
                            <h3>Flight Details: </h3>
                            <div class="flightDetailsRow">
                                    <p>
                                        <strong>
                                            <%=flight.getDeparture().getDestinationName().toUpperCase()%>
                                            &#8212;
                                            <%=flight.getDestination().getDestinationName().toUpperCase()%>
                                        </strong>
                                    </p>
                            </div>
                        <div class="flightDetailsRow">
                            <div class="flightDetailsColumnLeft" style="width:auto;">
                                <p>
                                    <strong>Departure Airport: </strong>
                                    <br />
                                    <strong>Departure Date: </strong>
                                    <br />
                                    <strong>Departure Time: </strong>
                                </p>
                            </div>
                            <div class="flightDetailsColumnLeft" style="width:18%;">
                                <p>
                                    <span><%=flight.getDeparture().getDestinationName()%></span>
                                    <br />
                                    <span>
                                        <%=flight.getFlightTime().toLocalDateTime().getDayOfMonth()%>
                                        <%=flight.getMonthName(flight.getFlightTime())%>
                                        <%=flight.getFlightTime().toLocalDateTime().getYear()%>
                                    </span>
                                    <br />
                                    <span><%=flight.getCivilianTime(flight.getFlightTime())%></span>
                                    <br />
                                </p>
                            </div>
                            <div class="flightDetailsColumnLeft" style="width:auto;">
                                <p>
                                    <strong>Arrival Airport: </strong>
                                    <br />
                                    <strong>Arrival Date: </strong>
                                    <br />
                                    <strong>Arrival Time: </strong>
                                </p>
                            </div>
                            <div class="flightDetailsColumnLeft" style="width:auto;">
                                <p>
                                    <span><%=flight.getDestination().getDestinationName()%></span>
                                    <br />
                                    <span>
                                                <%=flight.getFlightArrivalTime().toLocalDateTime().getDayOfMonth()%>
                                                <%=flight.getMonthName(flight.getFlightArrivalTime())%>
                                                <%=flight.getFlightArrivalTime().toLocalDateTime().getYear()%>
                                            </span>
                                    <br />
                                    <span><%=flight.getCivilianTime(flight.getFlightArrivalTime())%></span>
                                </p>
                            </div>
                        </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumnLeft" style="width: auto;">
                                    <p>
                                        <span>Flight operated by: </span>
                                        <br />
                                        <span>Flight number: </span>
                                        <br/>
                                        <span>Plane model: </span>
                                    </p>
                                    <% if (flight.getSelectedPrice() == -1) { %>
                                        <p>Minimum price:</p>
                                    <% }
                                    else { %>
                                    <p>
                                        <span><strong>SELECTED PRICE:</strong></span>
                                        <br />
                                        <span>Class: </span>
                                        <br />
                                        <span>Ticket type:</span>
                                    </p>
                                    <% } %>
                                </div>
                                <div class="flightDetailsColumnLeft">
                                    <p>
                                        <span><%=flight.getAirlineName()%></span>
                                        <br />
                                        <span><%=flight.getFlightName()%></span>
                                        <br />
                                        <span><%=flight.getPlaneType()%></span>
                                    </p>
                                    <% if (flight.getSelectedPrice() == -1) { %>
                                        <p>$<%=flight.getMinCost()%></p>
                                    <% }
                                    else { %>
                                    <p>
                                        <span><strong>$<%=flight.getSelectedPrice()%></strong></span>
                                        <br />
                                        <span><%= flight.getClassNameOfAvailability(flight.getSelectedPrice()) %></span>
                                        <br />
                                        <span><%= flight.getTicketTypeNameOfAvailability(flight.getSelectedPrice()) %></span>
                                    </p>
                                    <% } %>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumnLeft">
                                    <button class="button" onclick="toggleVisibility('<%= flight.getFlightTime() %>')">Select Ticket</button>
                                </div>
                            </div>
                            <!--TICKET SELECTION-->
                            <% String[] classCodes = {"ECO", "PME", "BUS", "FIR"}; %>
                            <% String[] ticketTypes = {"A", "B", "C", "D", "E", "F", "G"}; %>
                            <div class="ticketSelection" id="<%= flight.getFlightTime() %>" style="display:none;">
                                <div class="flightDetailsRow" id="<%= flight.getFlightTime() %>classDiv">

                                    <% for (String classCode : classCodes) {%>
                                    <div class="flightDetailsColumn4">
                                        <% if (classCode.equals("ECO")) {%>
                                        <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">Economy</button>
                                        <% } %>
                                        <% if (classCode.equals("PME")) {%>
                                        <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">Premium Economy</button>
                                        <% } %>
                                        <% if (classCode.equals("BUS")) {%>
                                        <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">Business</button>
                                        <% } %>
                                        <% if (classCode.equals("FIR")) {%>
                                        <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">First Class</button>
                                        <% } %>
                                    </div>
                                    <% } %>
                                    <!--TICKET TYPE SELECTION -->
                                    <% for (String classCode : classCodes) {%>
                                    <div id="<%= flight.getFlightTime() %><%= classCode %>" style="display:none">
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6Header">
                                                <% if (classCode.equals("ECO")) {%>
                                                <p class="classView"><strong>ECONOMY</strong></p>
                                                <% } %>
                                                <% if (classCode.equals("PME")) {%>
                                                <p class="classView"><strong>PREMIUM ECONOMY</strong></p>
                                                <% } %>
                                                <% if (classCode.equals("BUS")) {%>
                                                <p class="classView"><strong>BUSINESS</strong></p>
                                                <% } %>
                                                <% if (classCode.equals("FIR")) {%>
                                                <p class="classView"><strong>FIRST CLASS</strong></p>
                                                <% } %>
                                            </div>
                                            <div class="flightDetailsColumn6Header">
                                                <p class="classOptions">Transferable</p>
                                            </div>
                                            <div class="flightDetailsColumn6Header">
                                                <p class="classOptions">Refundable</p>
                                            </div>
                                            <div class="flightDetailsColumn6Header">
                                                <p class="classOptions">Exchangeable</p>
                                            </div>
                                            <div class="flightDetailsColumn6Header">
                                                <p class="classOptions">FrequentFlyerPoints</p>
                                            </div>
                                            <div class="flightDetailsColumn6Header">
                                                <p class="classOptions">Price</p>
                                            </div>
                                        </div>
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">Standby</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <form class="classOptions" action="flight" method="POST">
                                                    <input type="hidden" name="isReturnResults" value="false" />
                                                    <input type="hidden" name="flightIndex" value="<%= i %>" />
                                                    <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "A") %>' />
                                                    <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? flight.getPriceOfAvailability(classCode, "A") : "SOLD OUT")%>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">Premium Discounted</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <form class="classOptions" action="flight" method="POST">
                                                    <input type="hidden" name="isReturnResults" value="false" />
                                                    <input type="hidden" name="flightIndex" value="<%= i %>" />
                                                    <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "B") %>' />
                                                    <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? flight.getPriceOfAvailability(classCode, "B") : "SOLD OUT")%>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">Discounted</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <form class="classOptions" action="flight" method="POST">
                                                    <input type="hidden" name="isReturnResults" value="false" />
                                                    <input type="hidden" name="flightIndex" value="<%= i %>" />
                                                    <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "C") %>' />
                                                    <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? flight.getPriceOfAvailability(classCode, "C") : "SOLD OUT")%>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">Standard</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <form class="classOptions" action="flight" method="POST">
                                                    <input type="hidden" name="isReturnResults" value="false" />
                                                    <input type="hidden" name="flightIndex" value="<%= i %>" />
                                                    <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "D") %>' />
                                                    <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? flight.getPriceOfAvailability(classCode, "D") : "SOLD OUT")%>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">Premium</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">-</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <form class="classOptions" action="flight" method="POST">
                                                    <input type="hidden" name="isReturnResults" value="false" />
                                                    <input type="hidden" name="flightIndex" value="<%= i %>" />
                                                    <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "E") %>' />
                                                    <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? flight.getPriceOfAvailability(classCode, "E") : "SOLD OUT")%>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">ld</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <form class="classOptions" action="flight" method="POST">
                                                    <input type="hidden" name="isReturnResults" value="false" />
                                                    <input type="hidden" name="flightIndex" value="<%= i %>" />
                                                    <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "F") %>' />
                                                    <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? flight.getPriceOfAvailability(classCode, "F") : "SOLD OUT")%>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                        <div class="flightDetailsRow">
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">Platinum</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <p class="classOptions">&#10003</p>
                                            </div>
                                            <div class="flightDetailsColumn6">
                                                <form class="classOptions" action="flight" method="POST">
                                                    <input type="hidden" name="isReturnResults" value="false" />
                                                    <input type="hidden" name="flightIndex" value="<%= i %>" />
                                                    <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "G") %>' />
                                                    <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? flight.getPriceOfAvailability(classCode, "G") : "SOLD OUT")%>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <% } %>
                                </div>
                                <!--END TICKET TYPE SELECTION -->
                            </div>
                            <!--END TICKET SELECTION-->
                        </div>
                        <br />
                    </td>
                </tr>
                <% i++; %>
            <% } %>
                <tr>
                    <td class="filledSection">
                        <p><strong>Tags:</strong>

                            <%
                                if(destinationTags != null){
                                    for(String tag: destinationTags){
                                        if(tag != destinationTags.getLast()){ %>
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
                        </p>
                    </td>
                </tr>

                <% if(user==null){%>
            </table>
                    <% }else{ %>

                    <tr>
                        <td class="filledSection" colspan="2" style="text-align: center;">
                            <div class="groupFavButton">
                                <form name="addSelectedFlight" class="groupFavouritesForm" action="GroupHomepage" method="POST">
                                    <input type="hidden" name="isReturnResults" value='false'>
                                    <button class="button" type="submit" class="addToGroupFaveList" name="addSelectedFlight"
                                            id="addToGroupFaveList" value="addSelectedFlight">Add To Group Favourite List</button>
                                </form>
                            </div>
                        </td>
                    </tr>
            </table>

            <% if (!viewReturnFlightSearchResults && !viewReturnFlightDetails) { %>
                <fieldset class="background">
                    <form action="flightSearch" method="POST">
                        <label for="returnDate">Return Date:</label>
                        <input type="date" id="returnDate" name="returnDate" value="<%= flightPath.getLastFlight().getTomorrow() %>" min="<%= flightPath.getLastFlight().getTomorrow() %>"><br /><br />
                        <input type="hidden" id="numReturnPassengers" name="numReturnPassengers" value="<%= numAdults + numChildren %>">
                        <input type="hidden" name="departureLocation" value="<%= flightPath.getLastFlight().getDestination().getDestinationCode() %>">
                        <input type="hidden" name="arrivalLocation" value="<%= flightPath.getInitialFlight().getDeparture().getDestinationCode() %>">
                        <br />
                        <button name="searchResults" type="submit" value="simpleReturnSearchResults" class="search">Search</button>
                    </form>
                    <br />
                    <form action="createBooking" method="POST">
                        <input type="hidden" name="details" value="true">
                        <div class="recurringBookingInput">
                            <label for="recurCheck">Recurring Booking: </label>
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
                    </form>
                </fieldset>
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
                    LinkedList<String> returnTags = (LinkedList<String>) session.getAttribute("returnTags");
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
                                <h3>Flight Details: </h3>
                                <div class="flightDetailsRow">
                                    <p>
                                        <strong>
                                            <%=flight.getDeparture().getDestinationName().toUpperCase()%>
                                            &#8212;
                                            <%=flight.getDestination().getDestinationName().toUpperCase()%>
                                        </strong>
                                    </p>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumnLeft" style="width:auto;">
                                        <p>
                                            <strong>Departure Airport: </strong>
                                            <br />
                                            <strong>Departure Date: </strong>
                                            <br />
                                            <strong>Departure Time: </strong>
                                        </p>
                                    </div>
                                    <div class="flightDetailsColumnLeft" style="width:18%;">
                                        <p>
                                            <span><%=flight.getDeparture().getDestinationName()%></span>
                                            <br />
                                            <span>
                                        <%=flight.getFlightTime().toLocalDateTime().getDayOfMonth()%>
                                        <%=flight.getMonthName(flight.getFlightTime())%>
                                        <%=flight.getFlightTime().toLocalDateTime().getYear()%>
                                    </span>
                                            <br />
                                            <span><%=flight.getCivilianTime(flight.getFlightTime())%></span>
                                            <br />
                                        </p>
                                    </div>
                                    <div class="flightDetailsColumnLeft" style="width:auto;">
                                        <p>
                                            <strong>Arrival Airport: </strong>
                                            <br />
                                            <strong>Arrival Date: </strong>
                                            <br />
                                            <strong>Arrival Time: </strong>
                                        </p>
                                    </div>
                                    <div class="flightDetailsColumnLeft" style="width:auto;">
                                        <p>
                                            <span><%=flight.getDestination().getDestinationName()%></span>
                                            <br />
                                            <span>
                                                <%=flight.getFlightArrivalTime().toLocalDateTime().getDayOfMonth()%>
                                                <%=flight.getMonthName(flight.getFlightArrivalTime())%>
                                                <%=flight.getFlightArrivalTime().toLocalDateTime().getYear()%>
                                            </span>
                                            <br />
                                            <span><%=flight.getCivilianTime(flight.getFlightArrivalTime())%></span>
                                        </p>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumnLeft" style="width: auto;">
                                        <p>
                                            <span>Flight operated by: </span>
                                            <br />
                                            <span>Flight number: </span>
                                            <br/>
                                            <span>Plane model: </span>
                                        </p>
                                        <% if (flight.getSelectedPrice() == -1) { %>
                                        <p>Minimum price:</p>
                                        <% }
                                        else { %>
                                        <p>
                                            <span><strong>SELECTED PRICE:</strong></span>
                                            <br />
                                            <span>Class: </span>
                                            <br />
                                            <span>Ticket type:</span>
                                        </p>
                                        <% } %>
                                    </div>
                                    <div class="flightDetailsColumnLeft">
                                        <p>
                                            <span><%=flight.getAirlineName()%></span>
                                            <br />
                                            <span><%=flight.getFlightName()%></span>
                                            <br />
                                            <span><%=flight.getPlaneType()%></span>
                                        </p>
                                        <% if (flight.getSelectedPrice() == -1) { %>
                                        <p>$<%=flight.getMinCost()%></p>
                                        <% }
                                        else { %>
                                        <p>
                                            <span><strong>$<%=flight.getSelectedPrice()%></strong></span>
                                            <br />
                                            <span><%= flight.getClassNameOfAvailability(flight.getSelectedPrice()) %></span>
                                            <br />
                                            <span><%= flight.getTicketTypeNameOfAvailability(flight.getSelectedPrice()) %></span>
                                        </p>
                                        <% } %>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumnLeft">
                                        <button class="button" onclick="toggleVisibility('<%= flight.getFlightTime() %>')">Select Ticket</button>
                                    </div>
                                </div>
                                <!--TICKET SELECTION-->
                                <% String[] classCodes = {"ECO", "PME", "BUS", "FIR"}; %>
                                <% String[] ticketTypes = {"A", "B", "C", "D", "E", "F", "G"}; %>
                                <div class="ticketSelection" id="<%= flight.getFlightTime() %>" style="display:none;">
                                    <div class="flightDetailsRow" id="<%= flight.getFlightTime() %>classDiv">

                                        <% for (String classCode : classCodes) {%>
                                        <div class="flightDetailsColumn4">
                                            <% if (classCode.equals("ECO")) {%>
                                            <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">Economy</button>
                                            <% } %>
                                            <% if (classCode.equals("PME")) {%>
                                            <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">Premium Economy</button>
                                            <% } %>
                                            <% if (classCode.equals("BUS")) {%>
                                            <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">Business</button>
                                            <% } %>
                                            <% if (classCode.equals("FIR")) {%>
                                            <button class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this)">First Class</button>
                                            <% } %>
                                        </div>
                                        <% } %>
                                        <!--TICKET TYPE SELECTION -->
                                        <% for (String classCode : classCodes) {%>
                                        <div id="<%= flight.getFlightTime() %><%= classCode %>" style="display:none">
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6Header">
                                                    <% if (classCode.equals("ECO")) {%>
                                                    <p class="classView"><strong>ECONOMY</strong></p>
                                                    <% } %>
                                                    <% if (classCode.equals("PME")) {%>
                                                    <p class="classView"><strong>PREMIUM ECONOMY</strong></p>
                                                    <% } %>
                                                    <% if (classCode.equals("BUS")) {%>
                                                    <p class="classView"><strong>BUSINESS</strong></p>
                                                    <% } %>
                                                    <% if (classCode.equals("FIR")) {%>
                                                    <p class="classView"><strong>FIRST CLASS</strong></p>
                                                    <% } %>
                                                </div>
                                                <div class="flightDetailsColumn6Header">
                                                    <p class="classOptions">Transferable</p>
                                                </div>
                                                <div class="flightDetailsColumn6Header">
                                                    <p class="classOptions">Refundable</p>
                                                </div>
                                                <div class="flightDetailsColumn6Header">
                                                    <p class="classOptions">Exchangeable</p>
                                                </div>
                                                <div class="flightDetailsColumn6Header">
                                                    <p class="classOptions">FrequentFlyerPoints</p>
                                                </div>
                                                <div class="flightDetailsColumn6Header">
                                                    <p class="classOptions">Price</p>
                                                </div>
                                            </div>
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">Standby</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <form class="classOptions" action="flight" method="POST">
                                                        <input type="hidden" name="isReturnResults" value="true" />
                                                        <input type="hidden" name="flightIndex" value="<%= j %>" />
                                                        <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "A") %>' />
                                                        <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? "" : "disabled") %> >
                                                        <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? flight.getPriceOfAvailability(classCode, "A") : "SOLD OUT")%>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">Premium Discounted</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <form class="classOptions" action="flight" method="POST">
                                                        <input type="hidden" name="isReturnResults" value="true" />
                                                        <input type="hidden" name="flightIndex" value="<%= j %>" />
                                                        <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "B") %>' />
                                                        <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? "" : "disabled") %> >
                                                        <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? flight.getPriceOfAvailability(classCode, "B") : "SOLD OUT")%>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">Discounted</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <form class="classOptions" action="flight" method="POST">
                                                        <input type="hidden" name="isReturnResults" value="true" />
                                                        <input type="hidden" name="flightIndex" value="<%= j %>" />
                                                        <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "C") %>' />
                                                        <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? "" : "disabled") %> >
                                                        <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? flight.getPriceOfAvailability(classCode, "C") : "SOLD OUT")%>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">Standard</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <form class="classOptions" action="flight" method="POST">
                                                        <input type="hidden" name="isReturnResults" value="true" />
                                                        <input type="hidden" name="flightIndex" value="<%= j %>" />
                                                        <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "D") %>' />
                                                        <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? "" : "disabled") %> >
                                                        <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? flight.getPriceOfAvailability(classCode, "D") : "SOLD OUT")%>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">Premium</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">-</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <form class="classOptions" action="flight" method="POST">
                                                        <input type="hidden" name="isReturnResults" value="true" />
                                                        <input type="hidden" name="flightIndex" value="<%= j %>" />
                                                        <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "E") %>' />
                                                        <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? "" : "disabled") %> >
                                                        <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? flight.getPriceOfAvailability(classCode, "E") : "SOLD OUT")%>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">ld</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <form class="classOptions" action="flight" method="POST">
                                                        <input type="hidden" name="isReturnResults" value="true" />
                                                        <input type="hidden" name="flightIndex" value="<%= j %>" />
                                                        <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "F") %>' />
                                                        <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? "" : "disabled") %> >
                                                        <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? flight.getPriceOfAvailability(classCode, "F") : "SOLD OUT")%>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                            <div class="flightDetailsRow">
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">Platinum</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <p class="classOptions">&#10003</p>
                                                </div>
                                                <div class="flightDetailsColumn6">
                                                    <form class="classOptions" action="flight" method="POST">
                                                        <input type="hidden" name="isReturnResults" value="true" />
                                                        <input type="hidden" name="flightIndex" value="<%= j %>" />
                                                        <input type="hidden" name="selectedPrice" value='<%= flight.getPriceOfAvailability(classCode, "G") %>' />
                                                        <button type="submit" name="updatePrice" class="priceButton" <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? "" : "disabled") %> >
                                                        <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? flight.getPriceOfAvailability(classCode, "G") : "SOLD OUT")%>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <% } %>
                                    </div>
                                    <!--END TICKET TYPE SELECTION -->
                                </div>
                                <!--END TICKET SELECTION-->
                            </div>
                            <br />
                        </td>
                    </tr>
                    <% j++; %>
                    <% } %>
                    <tr>
                        <td class="filledSection">
                            <p><strong>Tags:</strong>

                                <%
                                    if(returnTags != null){
                                        for(String tag: returnTags){
                                            if(tag != returnTags.getLast()){ %>
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
                        </td>
                    </tr>

                    <% if(user==null){%>
                </table>
                <% }else{ %>

                    </table>
                <% } %>
            <br />
            <fieldset class="background">
                <br />
                <form action="createBooking" method="POST">
                    <input type="hidden" name="details" value="true">
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

                    <button class="button" type="submit" name="hasReturn" value="hasReturn">
                        Continue Booking
                    </button>
                    <br />
                </form>
            </fieldset>
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


                <%}%>
        </main>
    </body>

</html>