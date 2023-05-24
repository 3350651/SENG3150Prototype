<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.BookingBean" %>
        <%@ page import="startUp.PassengerBean" %>
            <%@ page import="startUp.TicketBean" %>

                <!DOCTYPE html>
                <html lang="en">


                <head>
                    <meta charset="UTF-8">
                    <title>Booking Details</title>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                </head>

                <% BookingBean booking= (BookingBean) session.getAttribute("booking"); %>

                    <body>
                        <main>
                            <header>
                                <form name="BackToHome" action="login" method="GET">
                                    <button type="submit" class="button" name="home" value="backToHome">Home</button>
                                </form>
                                <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                                    alt="FlightPub Logo" class="centreLogo">
                                <h1>
                                    Review Booking Details
                                </h1>
                                <br />
                                <label for="progress">
                                    <h2>Progress</h2>
                                </label>
                                <div class="outerProgress">
                                    <div class="innerProgress" id="progress" style="width:99%">99%</div>
                                </div>
                            </header>

                            <fieldset class="background">
                                <h2>Flight Details:</h2>
                                <fieldset class="foreground">
                                    <h3>Departure Flight Details</h3>

                                    <p class="reviewDetails">
                                        <strong>Airline: </strong>
                                        <%=booking.getDepartureFlight().getAirlineName()%>

                                            <br />
                                            <strong>Departure Time:</strong>
                                            <%=booking.getDepartureFlight().getFlightTime()%>

                                                <br />
                                                <strong>Flight Name:</strong>
                                                <%=booking.getDepartureFlight().getFlightName()%>

                                                    <br />
                                                    <strong>Plane Model:</strong>
                                                    <%=booking.getDepartureFlight().getPlaneType()%>
                                    </p>
                                </fieldset>
                                <%if(booking.getReturnFlight() !=null){%>
                                    <fieldset class="foreground">
                                        <h3>Return Flight Details</h3>

                                        <p class="reviewDetails">
                                            <strong>Airline: </strong>
                                            <%=booking.getReturnFlight().getAirlineName()%>

                                                <br />
                                                <strong>Departure Time:</strong>
                                                <%=booking.getReturnFlight().getFlightTime()%>

                                                    <br />
                                                    <strong>Flight Name:</strong>
                                                    <%=booking.getReturnFlight().getFlightName()%>

                                                        <br />
                                                        <strong>Plane Model:</strong>
                                                        <%=booking.getReturnFlight().getPlaneType()%>
                                        </p>

                                    </fieldset>
                                    <%}%>
                            </fieldset>

                            <br />

                            <fieldset class="background">
                                <h2>Passenger Details:</h2>

                                <%for(PassengerBean passenger : booking.getPassengers()){%>
                                    <fieldset class="foreground">
                                        <p class="reviewDetails">
                                            <strong>Name: </strong>
                                            <%=passenger.getGivenNames() + " " + passenger.getLastName()%><br />
                                                <strong>Email: </strong>
                                                <%=passenger.getEmail()%><br />
                                                    <strong>Mobile Number: </strong>
                                                    <%=passenger.getPhoneNumber()%><br />
                                                        <strong>Date Of Birth: </strong>
                                                        <%=passenger.getDateOfBirth()%>
                                        </p>
                                        <fieldset class="foreground">
                                            <h2>Departure Ticket</h2>
                                            <p>
                                                <strong>Class: </strong><%=passenger.getDepartureTicket().getTicketClassName()%><br/>
                                                <strong>Type: </strong><%=passenger.getDepartureTicket().getTicketTypeName()%>
                                            </p>
                                        </fieldset>
                                        <%if(passenger.getReturnTicket() != null){%>
                                            <fieldset class="foreground">
                                                <h2>Return Ticket</h2>
                                                <p>
                                                    <strong>Class: </strong><%=passenger.getReturnTicket().getTicketClassName()%><br/>
                                                    <strong>Type: </strong><%=passenger.getReturnTicket().getTicketTypeName()%>
                                                </p>
                                            </fieldset>
                                        <%}%>
                                    </fieldset>
                                    <%}%>
                            </fieldset>
                            <br />
                            <fieldset class="filled">
                                <h3>Payment Details:</h3>
                                <form method="POST" action="createBooking">
                                    <input type="hidden" name="payment" value="true">
                                    <label for="cardNumber">Card Number:</label>
                                    <input type="text" id="cardNumber" />
                                    <label for="expiry">Expiry Date:</label>
                                    <input type="text" id="expiry" />
                                    <br />
                                    <label for="security">Security Number:</label>
                                    <input type="text" id="security" />
                                    <br />
                                    <button type="submit" class="button">Submit</button>
                                </form>
                            </fieldset>

                        </main>
                    </body>

                </html>