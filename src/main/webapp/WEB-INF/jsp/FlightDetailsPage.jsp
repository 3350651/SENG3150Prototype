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
                    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="centreLogo" >
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

                <img src="${pageContext.request.contextPath}/images/sanFranciso.png" alt="Destination Image" class="destinationImage" />
                <fieldset class="review">
                    <h3>Flight Details:</h3>
                    <p class="flightDetails">
                        <strong>Airline: </strong>American Airlines

                        <br />
                        <strong>Departure Time:</strong> 11:50 am 11/05/2014

                        <br />
                        <strong>Flight Name:</strong> F1375

                        <br />
                        <strong>Plane Model:</strong> A380
                    </p>
                </fieldset>
                <fieldset class="destinationTags">
                    <p>Mild, Landmark, America, Food</p>
                </fieldset>
                <fieldset class="review">
                    <p>San Francisco is a city in the USA that is quite popular and famous<br />
                        <strong>Reputation Score: </strong>90
                    </p>
                </fieldset>
                <!--Add reputation score and destination description here-->
                <button class="button" name="addToGroupFavList">Add To Group Favourite List</button>
                <br />
                <form>
                    <fieldset class="selectReturn">

                        <label for="returnDate">Return Date:</label>
                        <input type="date" id="returnDate" name="returnDate" value="2014-05-18">
                        <br />
                        <button class="button">Search</button>
                        <button class="button">Continue One Way</button>

                    </fieldset>
                    <fieldset class="review">
                        <fieldset>
                            <button class="selectFlight">Select</button>
                            <p class="flightDetails">
                                <strong>Airline: </strong>American Airlines
                                <br />
                                <strong>Departure Time:</strong> 11:50 am 11/05/2014
                                <br />
                                <strong>Flight Name:</strong> F1375
                                <br />
                                <strong>Plane Model:</strong> A380
                            </p>

                        </fieldset>
                        <fieldset>
                            <button class="selectFlight">Select</button>
                            <p class="flightDetails">
                                <strong>Airline: </strong>American Airlines
                                <br />
                                <strong>Departure Time:</strong> 11:50 am 11/05/2014
                                <br />
                                <strong>Flight Name:</strong> F1375
                                <br />
                                <strong>Plane Model:</strong> A380
                            </p>
                        </fieldset>
                        <fieldset>
                            <button class="selectFlight">Select</button>
                            <p class="flightDetails">
                                <strong>Airline: </strong>American Airlines
                                <br />
                                <strong>Departure Time:</strong> 11:50 am 11/05/2014
                                <br />
                                <strong>Flight Name:</strong> F1375
                                <br />
                                <strong>Plane Model:</strong> A380
                            </p>
                        </fieldset>
                    </fieldset>
                </form>

            </main>
        </body>

    </html>