<%@ page import="startUp.FlightBean" %>
    <!DOCTYPE html>
    <html lang="en">

    <%FlightBean flight=(FlightBean) session.getAttribute("Flight");%>

        <head>
            <meta charset="UTF-8">
            <title>startUp.FlightDetailsPage</title>
            <link rel="stylesheet" href="/css/Style.css">
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
                    </br>
                    <h2>
                        Airline: <%=flight.getAirlineName()%>
                    </h2>
                    </br>
                    <h2>Departure Time: <%=flight.getFlightTime().toString()%>
                    </h2>
                    </br>
                    <h2>Flight Name: <%=flight.getFlightName()%>
                    </h2>
                    </br>
                    <h2>Plane Model: <%=flight.getPlaneType()%>
                    </h2>
                </fieldset>
                <!--Add reputation score and destination description here-->
                <form name="addToGroupList" method="post" action="">
                    <button type="submit" name="addToGroupFavList" value=<%=flight.getAirline() + "," +
                        flight.getFlightName() + "," + flight.getFlightTime()%>>Add To Group Favourite List</button>
                </form>
            </main>
        </body>

    </html>