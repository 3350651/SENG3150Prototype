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
                        <%= flight.getDestination().getDestinationName()%>
                    </h1>
                </header>
            </main>
        </body>

    </html>