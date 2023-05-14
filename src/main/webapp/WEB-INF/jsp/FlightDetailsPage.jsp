<%@ page import="startUp.FlightBean" %>
    <!DOCTYPE html>
    <html lang="en">

    <%FlightBean flight=(FlightBean) session.getAttribute("Flight");%>

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
                    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo"
                        class="centreLogo">
                    <h1>
                        Newcastle To Brisbane
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

                        <td class="filledSection"><img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                                alt="Destination Image" width="250px" height="auto" class="destinationImage"></td>
                        <td class="filledSection">
                        <div class="mainFlightDetailCell">
                            <h3>Flight Details:</h3>
                            <p class="flightDetails">

                                <strong>Airline: </strong>Qantas

                                <br />
                                <strong>Departure Time:</strong> 11:50 am 26/12/2023

                                <br />
                                <strong>Flight Name:</strong> F1375

                                <br />
                                <strong>Plane Model:</strong> A380
                                <br />
                            <h3>Minimum price: $662</h3>
                            </p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="filledSection">
                            <p><strong>Tags:</strong> Landmark, America, Food</p>
                        </td>
                        <td class="filledSection">
                            <p>Brisbane is the capaital city of Queensland, Australia. It is know for the brilliant weather and scenery. <br>
                                <strong>Reputation Score: </strong>90
                            </p>
                        </td>
                    </tr>
                    <tr>
                    <td class="filledSection" colspan="2" style="text-align: center;">
                    <div class="floatGroupFavButton">
                        <button class="button" class="addToGroupFav" name="addToGroupFavList" id="addToGroupFavList">Add To Group Favourite List</button>
                    </div>
                    </td>
                    </tr>
                </table>
                <form action="FlightToPassengers" method="POST">
                    <fieldset class="background">

                        <label for="returnDate">Return Date:</label>
                        <input type="date" id="returnDate" name="returnDate" value="2014-05-18">
                        <br />
                        <div class="recurringBookingInput">
                        <label for="check">Recurring Booking: </label>
                        <input id="recurCheck" name="recurCheck" type="checkbox">
                        <div class="recurringWeeklyOrBiWeekly" name="recurringWeeklyOrBiWeekly" id="recurringWeeklyOrBiWeekly" style="display:none;">
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
                        <br />
                        <button class="button">Search</button>
                        <button class="button">Continue One Way</button>
                        <br />
                        <fieldset class="foreground">
                            <button class="selectFlight" type="submit">Select</button>
                            <p class="flightDetails">
                                <strong>Airline: </strong>American Airlines
                                <br />
                                <strong>Departure Time:</strong> 11:50 am 18/05/2014
                                <br />
                                <strong>Flight Name:</strong> F1375
                                <br />
                                <strong>Plane Model:</strong> A380
                                <br />
                            <h3>Minimum price: $500</h3>
                            </p>

                        </fieldset>
                        <fieldset class="foreground">
                            <button class="selectFlight" type="submit">Select</button>
                            <p class="flightDetails">
                                <strong>Airline: </strong>American Airlines
                                <br />
                                <strong>Departure Time:</strong> 10:50 am 18/05/2014
                                <br />
                                <strong>Flight Name:</strong> F1375
                                <br />
                                <strong>Plane Model:</strong> A380
                                <br />
                            <h3>Minimum price: $500</h3>
                            </p>
                        </fieldset>
                        <fieldset class="foreground">
                            <button class="selectFlight" type="submit">Select</button>
                            <p class="flightDetails">
                                <strong>Airline: </strong>American Airlines
                                <br />
                                <strong>Departure Time:</strong> 09:50 am 18/05/2014
                                <br />
                                <strong>Flight Name:</strong> F1375
                                <br />
                                <strong>Plane Model:</strong> A380
                                <br />
                            <h3>Minimum price: $500</h3>
                            </p>
                        </fieldset>
                    </fieldset>
                </form>

            </main>
        </body>
    <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

    </html>