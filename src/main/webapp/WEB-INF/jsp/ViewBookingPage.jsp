<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.BookingBean" %>
        <%@ page import="startUp.PassengerBean" %>
            <%@ page import="startUp.TicketBean" %>
                <% BookingBean booking=(BookingBean) session.getAttribute("booking"); %>
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
                                    <%=booking.getDepartureFlight().getDeparture().getDestinationName() + " To " +
                                        booking.getDepartureFlight().getDestination().getDestinationName()%>
                                </h1>
                            </header>
                            <jsp:include page="c-BookingDetails"></jsp:include>
                        </main>
                    </body>

                    </html>