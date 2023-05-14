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
                        Sydney To San Francisco
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
                        <td class="filledSection"><img src="${pageContext.request.contextPath}/images/sanFrancisco.png"
                                alt="Destination Image" class="destinationImage"></td>
                        <td class="filledSection">
                            <h3>Flight Details:</h3>
                            <p class="flightDetails">
                                <strong>Airline: </strong>American Airlines

                                <br />
                                <strong>Departure Time:</strong> 11:50 am 11/05/2014

                                <br />
                                <strong>Flight Name:</strong> F1375

                                <br />
                                <strong>Plane Model:</strong> A380
                                <br />
                            <h3>Minimum price: $500</h3>
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td class="filledSection">
                            <p><strong>Tags:</strong> Landmark, America, Food</p>
                        </td>
                        <td class="filledSection">
                            <p>San Francisco is a city in the USA that is quite popular and famous<br />
                                <strong>Reputation Score: </strong>90
                            </p>
                        </td>
                    </tr>
                </table>

                <button class="button" name="addToGroupFavList" id="addToGroupFavList">Add To Group Favourite
                    List</button>
                <br />
                <form action="FlightToPassengers" method="POST">
                    <fieldset class="background">

                        <label for="returnDate">Return Date:</label>
                        <input type="date" id="returnDate" name="returnDate" value="2014-05-18">
                        <br />
                        <label for="check">Recurring Booking: </label>
                        <input id="check" type="checkbox">
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

    </html>