<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.BookingBean" %>
        <%@ page import="startUp.PassengerBean" %>
            <%@ page import="startUp.TicketBean" %>
<%@  page import="java.util.*" %>
                <% BookingBean booking=(BookingBean) session.getAttribute("currentBooking"); %>
                    <!DOCTYPE html>
                    <html lang="en">


                    <head>
                        <meta charset="UTF-8">
                        <title>Booking Details</title>
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                    </head>

                    <body>
                        <main>
                            <header>
                                <form name="BackToHome" action="login" method="GET">
                                    <button type="submit" class="button" name="home" value="backToHome">Home</button>
                                </form>
                                <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                                    alt="FlightPub Logo" class="centreLogo">
                                <h1>
                                    <%=booking.getDepartureFlightPath().getLastFlight().getDeparture().getDestinationName()
                                            + " To " +
                                            booking.getDepartureFlightPath().getInitialFlight().getDestination().getDestinationName()%>
                                </h1>
                            </header>

                            <fieldset class="background">
                                <h2>Flight Details:</h2>
                                <fieldset class="foreground">
                                    <h3>Departure Flight Details</h3>

                                    <p class="reviewDetails">
                                    <h3><%=booking.getDepartureFlightPath().getLastFlight().getDeparture().getDestinationName()%> <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                                        <%=booking.getDepartureFlightPath().getInitialFlight().getDestination().getDestinationName()%></h3>
                                    <strong>Airline: </strong>
                                    <%=booking.getDepartureFlightPath().getLastFlight().getAirlineName()%>

                                    <br />
                                    <strong>Departure Time:</strong>
                                    <%=booking.getDepartureFlightPath().getLastFlight().getFlightTime()%>

                                    <br />
                                    <strong>Flight Name:</strong>
                                    <%=booking.getDepartureFlightPath().getLastFlight().getFlightName()%>

                                    <br />
                                    <strong>Plane Model:</strong>
                                    <%=booking.getDepartureFlightPath().getLastFlight().getPlaneType()%>
                                    </p>
                                </fieldset>
                                <%if(!booking.getReturnFlightPath().getFlightPath().isEmpty()){%>
                                <fieldset class="foreground">
                                    <h3>Return Flight Details</h3>
                                    <h3><%=booking.getReturnFlightPath().getLastFlight().getDeparture().getDestinationName()%> <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                                        <%=booking.getReturnFlightPath().getInitialFlight().getDestination().getDestinationName()%></h3>
                                    <p class="reviewDetails">
                                        <strong>Airline: </strong>
                                        <%=booking.getReturnFlightPath().getLastFlight().getAirlineName()%>

                                        <br />
                                        <strong>Departure Time:</strong>
                                        <%=booking.getReturnFlightPath().getLastFlight().getFlightTime()%>

                                        <br />
                                        <strong>Flight Name:</strong>
                                        <%=booking.getReturnFlightPath().getLastFlight().getFlightName()%>

                                        <br />
                                        <strong>Plane Model:</strong>
                                        <%=booking.getReturnFlightPath().getLastFlight().getAirlineName()%>
                                    </p>
                                </fieldset>
                                <%}%>
                            </fieldset>

                            <br />

                            <fieldset class="background">
                                <h2>Passenger Details:</h2>

                                <% LinkedList<PassengerBean> passengerList = booking.getPassengers();%>
                                <% for (int k = 0; k < passengerList.size(); k++) { %>
                                <fieldset class="foreground">
                                    <p class="reviewDetails">
                                        <strong>Name: </strong>
                                        <%=passengerList.get(k).getGivenNames() + " " + passengerList.get(k).getLastName()%><br />
                                        <strong>Email: </strong>
                                        <%=passengerList.get(k).getEmail()%><br />
                                        <strong>Mobile Number: </strong>
                                        <%=passengerList.get(k).getPhoneNumber()%><br />
                                        <strong>Date Of Birth: </strong>
                                        <%=passengerList.get(k).getDateOfBirth()%>
                                    </p>
                                    <fieldset class="foreground">
                                        <h2>Departure Ticket</h2>
                                        <p>
                                            <strong>Class: </strong><%=booking.getTickets().get(k).getTicketClass()%><br/>
                                            <strong>Type: </strong><%=booking.getTickets().get(k).getTicketType()%>
                                        </p>
                                    </fieldset>
                                    <%if(passengerList.get(k).getReturnTickets() != null){%>
                                    <fieldset class="foreground">
                                        <h2>Return Ticket</h2>
                                        <p>
                                            <strong>Class: </strong><%=booking.getTickets().get(k).getTicketClass()%><br/>
                                            <strong>Type: </strong><%=booking.getTickets().get(k).getTicketType()%>
                                        </p>
                                    </fieldset>
                                    <%}%>
                                </fieldset>
                                <%}%>
                            </fieldset>
                            <br />
                     </main>
                    </body>

                    </html>