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
            <h3><%=bookings.get(i).getDepartureFlight().getDeparture().getDestinationName()%> <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
            <%=bookings.get(i).getDepartureFlight().getDestination().getDestinationName()%></h3>
                <strong>Airline: </strong>
                <%=bookings.get(i).getDepartureFlight().getAirlineName()%>

                <br />
                <strong>Departure Time:</strong>
                <%=bookings.get(i).getDepartureFlight().getFlightTime()%>

                <br />
                <strong>Flight Name:</strong>
                <%=bookings.get(i).getDepartureFlight().getFlightName()%>

                <br />
                <strong>Plane Model:</strong>
                <%=bookings.get(i).getDepartureFlight().getPlaneType()%>
            </p>
        </fieldset>
        <%if(bookings.get(i).getReturnFlight() !=null){%>
        <fieldset class="foreground">
            <h3>Return Flight Details</h3>

            <p class="reviewDetails">
                <strong>Airline: </strong>
                <%=bookings.get(i).getReturnFlight().getAirlineName()%>

                <br />
                <strong>Departure Time:</strong>
                <%=bookings.get(i).getReturnFlight().getFlightTime()%>

                <br />
                <strong>Flight Name:</strong>
                <%=bookings.get(i).getReturnFlight().getFlightName()%>

                <br />
                <strong>Plane Model:</strong>
                <%=bookings.get(i).getReturnFlight().getPlaneType()%>
            </p>

        </fieldset>
        <%}%>
    </fieldset>

    <br />

    <fieldset class="background">
        <h2>Passenger Details:</h2>

        <%//for(PassengerBean passenger : bookings.get(i).getPassengers()){%>
        <% LinkedList<PassengerBean> passengerList = bookings.get(i).getPassengers(); System.out.println("passenger size = " + passengerList.size()); %>
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
                    <strong>Class: </strong><%=passengerList.get(k).getDepartureTickets().get(i).getTicketClassName()%><br/>
                    <strong>Type: </strong><%=passengerList.get(k).getDepartureTickets().get(i).getTicketTypeName()%>
                </p>
            </fieldset>
            <%if(passengerList.get(k).getReturnTickets() != null){%>
            <fieldset class="foreground">
                <h2>Return Ticket</h2>
                <p>
                    <strong>Class: </strong><%=passengerList.get(k).getReturnTickets().get(i).getTicketClassName()%><br/>
                    <strong>Type: </strong><%=passengerList.get(k).getReturnTickets().get(i).getTicketTypeName()%>
                </p>
            </fieldset>
            <%}%>
        </fieldset>
        <%}%>
    </fieldset>
    <br />
    <% } %>
