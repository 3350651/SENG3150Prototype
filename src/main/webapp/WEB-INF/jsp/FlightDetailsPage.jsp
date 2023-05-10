<%@ page import="startUp.FlightBean" %>
    <!DOCTYPE html>
    <html lang="en">

    <%FlightBean flight=(FlightBean) session.getAttribute("Flight");%>

        <head>
            <meta charset="UTF-8">
            <title>startUp.FlightDetailsPage</title>
            <link rel="stylesheet" href="Style.css">
        </head>

        <body>
            <main>
                <header>
                    <h1>
                        <%= flight.getDeparture().getDestinationName()%> To <%=
                                flight.getDestination().getDestinationName()%>
                    </h1>
                    <!--Progress bar here-->
                </header>

                <fieldset>
                    <legend>Flight Details:</legend>
                    <br/>
                    <h2>
                        Airline: <%=flight.getAirlineName()%>
                    </h2>
                    <br/>
                    <h2>Departure Time: <%=flight.getFlightTime().toString()%>
                    </h2>
                    <br/>
                    <h2>Flight Name: <%=flight.getFlightName()%>
                    </h2>
                    <br/>
                    <h2>Plane Model: <%=flight.getPlaneType()%>
                    </h2>
                </fieldset>
                <!--Add reputation score and destination description here-->
                <form name="addToGroupList" method="POST" action="">
                    <button type="submit" name="addToGroupFavList" value=<%=flight.getAirline() + "," +
                        flight.getFlightName() + "," + flight.getFlightTime()%>>Add To Group Favourite List</button>
                </form>
                <form name="returnFlightOrContinue" method="POST" action="createBooking">
                    <!--Add return flight search function here. Maybe add return flight to the session as "returnFlight" to retrieve object in servlet-->
                    <button type="submit" name="continue">Continue</button>
                <input type="hidden" name="details" value="true"/>
                </form>
            </main>
        </body>

    </html>