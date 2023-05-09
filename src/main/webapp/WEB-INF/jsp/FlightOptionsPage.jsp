<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.BookingBean" %>
        <!DOCTYPE html>
        <html lang="en">

        <% BookingBean booking=(BookingBean) session.getAttribute("booking"); FlightBean
            departureFlight=booking.getDepartureFlight();%>

            <head>
                <meta charset="UTF-8">
                <title>startUp.FlightDetailsPage</title>
                <link rel="stylesheet" href="Style.css">
            </head>

            <body>
                <header>
                    <h1>Select Flight Options</h1>
                </header>
                <main>
                    <form name="flightOptions" method="POST" action="createBooking">
                        <fieldset>
                            <legend>Departure Flight</legend>
                            <h2>Select Ticket Class</h2>
                            <input type="radio" id="departureClass" name="departureClass" value=<%=departureFlight.get%>
                        </fieldset>
                        <!-- <fieldset>
                            <legend>Return Flight</legend>
                        </fieldset> -->
                    </form>

                </main>
            </body>

        </html>