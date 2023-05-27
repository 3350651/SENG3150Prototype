<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.SearchBean" %>
        <%@ page import="startUp.UserBean" %>
            <%@ page import="startUp.DestinationBean" %>
                <%@ page import="java.util.LinkedList" %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <%FlightBean flight=(FlightBean) session.getAttribute("flightDetails");%>

                        <head>
                            <meta charset="UTF-8">
                            <title>startUp.FlightDetailsPage</title>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                        </head>

                        <body>
                            <main>
                                <header>
                                    <form class="backButton">
                                        <button>Back</button>
                                    </form>
                                    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                                        alt="FlightPub Logo" class="centreLogo">
                                    <h1>
                                        <%= flight.getDeparture().getDestinationName()%> To <%=
                                                flight.getDestination().getDestinationName()%>
                                    </h1>
                                    <br />
                                    <label for="progress">
                                        <h2>Progress</h2>
                                    </label>
                                    <div class="outerProgress">
                                        <div class="innerProgress" id="progress" style="width:33%">33%</div>
                                    </div>
                                </header>

                                <table>
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
                                                <p class="flightDetails">

                                                    <strong>Airline: </strong>
                                                    <%=flight.getAirlineName()%>

                                                        <br />
                                                        <strong>Departure Time:</strong>
                                                        <%=flight.getFlightTime()%>

                                                            <br />
                                                            <strong>Flight Name:</strong>
                                                            <%=flight.getFlightName()%>

                                                                <br />
                                                                <strong>Plane Model:</strong>
                                                                <%=flight.getPlaneType()%>
                                                                    <br />
                                                                    <h3>Minimum price: <%=flight.getMinCost()%>
                                                                    </h3>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="filledSection">
                                            <p><strong>Tags:</strong>
                                                <%LinkedList<String> tags = flight.getDestination().getTags();
                                                    if(tags != null){
                                                    for(String tag: tags){
                                                    if(tag != tags.getLast()){
                                                    %>
                                                    <%=tag +", "%>
                                    
                                <%}else{%>
                                    <%=tag + " ."%>
                                                        <%}%>
                                                            <%}%>
                                                                <%}%>
                                            </p>
                                        </td>
                                        <td class="filledSection">
                                            <p>
                                                <%=flight.getDestination().getDestinationDescription()%><br>
                                                    <strong>Reputation Score: </strong>
                                                    <%=flight.getDestination().getReputationScore()%>
                                            </p>
                                        </td>
                                    </tr>

                                    <%UserBean user=(UserBean) session.getAttribute("userBean"); if(user==null){%>
                                </table>
                                <%}else{%>

                                    <tr>
                                        <td class="filledSection" colspan="2" style="text-align: center;">
                                            <div class="floatGroupFavButton">
                                                <button class="button" class="addToGroupFav" name="addToGroupFavList"
                                                    id="addToGroupFavList">Add To Group
                                                    Favourite List</button>
                                            </div>
                                        </td>
                                    </tr>
                                    </table>
                                    <fieldset class="background">
                                        <form action="flight" method="POST">
                                            <label for="returnDate">Return Date:</label>
                                            <input type="date" id="returnDate" name="returnDate" value="2014-01-03">
                                            <input type="hidden" name="returnSearch" value="true">
                                            <br />
                                            <button class="button" type="submit">Search</button>
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

                                            <button class="button" type="submit" name="oneWay" value="oneWay">Continue
                                                One
                                                Way</button>
                                            <br />
                                            <%LinkedList<FlightBean> returnFlights = (LinkedList<FlightBean>)
                                                    request.getAttribute("returnFlights");
                                                    if(returnFlights != null){
                                                    request.setAttribute("returnFlights", returnFlights);
                                                    int index = 0;
                                                    for(FlightBean returnFlight : returnFlights){
                                                    %>
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
                                                    <% index++; }%>
                                                        <%}%>
                                        </form>
                                    </fieldset>
                                    <%}%>

                            </main>
                        </body>

                    </html>