<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.BookingBean" %>
        <%@ page import="startUp.AvailabilityBean" %>
            <%@ page import="java.util.LinkedList" %>
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
                                    <%LinkedList<AvailabilityBean> seats = departureFlight.getSeatAvailability();
                                        for(AvailabilityBean seat : seats){
                                        %>
                                        
                                        <input type="radio"
                                            id="departure<%=seat.getClassName()%><%=seat.getTicketTypeName()%>"
                                            name="departureClass" value=<%=seat.getClassCode() +
                                            seat.getTicketTypeName()%>
                                            <label for="departure<%=seat.getClassName()%><%=seat.getTicketTypeName()%>">
                                                <%=seat.getClassName() + " " + seat.getTicketTypeName()%>
                                            </label>
                                        
                                        </br>
                                        <%}%>

                                </fieldset>
                                <!-- <fieldset>
                            <legend>Return Flight</legend>
                        </fieldset> -->
                            </form>

                        </main>
                    </body>

                </html>