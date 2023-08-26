<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.BookingBean" %>
<%@ page import="startUp.PassengerBean" %>
<%@ page import="startUp.TicketBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.LinkedList" %>
<% //BookingBean booking= (BookingBean) session.getAttribute("booking"); %>
<% ArrayList<BookingBean> bookingsList = (ArrayList<BookingBean>) session.getAttribute("bookingsList"); %>
<% LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("bookings"); %>
<% LinkedList<BookingBean> returnBookings = (LinkedList<BookingBean>) session.getAttribute("returnBookings"); %>

<% for (int i = 0; i < bookings.size(); i++){ %>
    <fieldset class="background">
        <h2>Flight Details:</h2>
        <fieldset class="foreground">
            <h3>Departure Flight Details</h3>

            <p class="reviewDetails">
            <h3><%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getDeparture().getDestinationName()%> <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
            <%=bookings.get(i).getDepartureFlightPath().getLastFlight().getDestination().getDestinationName()%></h3>
                <strong>Airline: </strong>
                <%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getAirlineName()%>

                <br />
            <strong>Departure Date:</strong>
            <%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getFlightTime().toLocalDateTime().getDayOfMonth()%>
            <%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getMonthName(bookings.get(i).getDepartureFlightPath().getInitialFlight().getFlightTime())%>
            <%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getFlightTime().toLocalDateTime().getYear()%>
            <br />
            <strong>Departure Time:</strong>
            <%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getCivilianTime(bookings.get(i).getDepartureFlightPath().getInitialFlight().getFlightTime())%>

            <br />
                <strong>Flight Name:</strong>
                <%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getFlightName()%>

                <br />
                <strong>Plane Model:</strong>
                <%=bookings.get(i).getDepartureFlightPath().getInitialFlight().getPlaneType()%>
            </p>
        </fieldset>
        <%if(bookings.get(i).getReturnFlightPath() !=null){%>
        <fieldset class="foreground">
            <h3>Return Flight Details</h3>

            <p class="reviewDetails">
            <h3><%=bookings.get(i).getReturnFlightPath().getInitialFlight().getDeparture().getDestinationName()%> <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                <%=bookings.get(i).getReturnFlightPath().getLastFlight().getDestination().getDestinationName()%></h3>
                <strong>Airlidne: </strong>
                <%=bookings.get(i).getReturnFlightPath().getInitialFlight().getAirlineName()%>

                <br />
                <strong>Departure Date:</strong>
                <%=bookings.get(i).getReturnFlightPath().getInitialFlight().getFlightTime().toLocalDateTime().getDayOfMonth()%>
                <%=bookings.get(i).getReturnFlightPath().getInitialFlight().getMonthName(bookings.get(i).getReturnFlightPath().getInitialFlight().getFlightTime())%>
                <%=bookings.get(i).getReturnFlightPath().getInitialFlight().getFlightTime().toLocalDateTime().getYear()%>
                <br />
                <strong>Departure Time:</strong>
                <%=bookings.get(i).getReturnFlightPath().getInitialFlight().getCivilianTime(bookings.get(i).getReturnFlightPath().getInitialFlight().getFlightTime())%>

                <br />
                <strong>Flight Name:</strong>
                <%=bookings.get(i).getReturnFlightPath().getInitialFlight().getFlightName()%>

                <br />
                <strong>Plane Model:</strong>
                <%=bookings.get(i).getReturnFlightPath().getInitialFlight().getPlaneType()%>
            </p>

        </fieldset>
        <%}%>
    </fieldset>

    <br />

    <fieldset class="background">
        <h2>Passenger Details:</h2>

        <%//for(PassengerBean passenger : bookings.get(i).getPassengers()){%>

        <% LinkedList<PassengerBean> passengerList = bookings.get(i).getPassengers();%>
        <% LinkedList<PassengerBean> returnPassengerList = bookings.get(i).getReturnPassengers();%>
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

            <% for (TicketBean ticket : passengerList.get(k).getDepartureTickets()) { %>
            <fieldset class="foreground">
                <h2>Departure Ticket</h2>
                <p>
                    <strong>Flight: </strong><%=ticket.getDeparture()%> - <%= ticket.getArrival() %><br/>
                    <strong>Class: </strong><%=ticket.getTicketClassName()%><br/>
                    <strong>Type: </strong><%=ticket.getTicketTypeName()%>
                    <strong>Price: </strong><%=ticket.getPrice()%>
                </p>
            </fieldset>
            <% } // end for loop on departure tickets %>
            <%if(passengerList.get(k).getReturnTickets() != null){%>
                <% for (TicketBean returnTicket : passengerList.get(k).getReturnTickets()) { %>
                    <fieldset class="foreground">
                        <h2>Return Ticket</h2>
                        <p>
                            <strong>Flight: </strong><%=returnTicket.getDeparture()%> - <%= returnTicket.getArrival() %><br/>
                            <strong>Class: </strong><%=returnTicket.getTicketClassName()%><br/>
                            <strong>Type: </strong><%=returnTicket.getTicketTypeName()%>
                            <strong>Price: </strong><%=returnTicket.getPrice()%>
                        </p>
                    </fieldset>
                <% } // end for loop on departure tickets %>
            <%} // end if has return tickets %>
        </fieldset>
        <%}%>
    </fieldset>
    <br />
    <% } %>
