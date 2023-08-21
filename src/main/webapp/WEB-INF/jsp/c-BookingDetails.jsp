<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.BookingBean" %>
<%@ page import="startUp.PassengerBean" %>
<%@ page import="startUp.TicketBean" %>
<%@ page import="java.util.ArrayList" %>
<% //BookingBean booking= (BookingBean) session.getAttribute("booking"); %>
<% ArrayList<BookingBean> bookingsList = (ArrayList<BookingBean>) session.getAttribute("bookingsList"); %>

<% for (int i = 0; i < bookingsList.size(); i++){ %>

<fieldset class="background">
    <h2>Flight Details:</h2>
    <fieldset class="foreground">
        <h3>Departure Flight Details</h3>

        <p class="reviewDetails">
        <h3><%=bookingsList.get(i).getDepartureFlight().getDeparture().getDestinationName()%> <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
        <%=bookingsList.get(i).getDepartureFlight().getDestination().getDestinationName()%></h3>
            <strong>Airline: </strong>
            <%=bookingsList.get(i).getDepartureFlight().getAirlineName()%>

                <br />
                <strong>Departure Time:</strong>
                <%=bookingsList.get(i).getDepartureFlight().getFlightTime()%>

                    <br />
                    <strong>Flight Name:</strong>
                    <%=bookingsList.get(i).getDepartureFlight().getFlightName()%>

                        <br />
                        <strong>Plane Model:</strong>
                        <%=bookingsList.get(i).getDepartureFlight().getPlaneType()%>
        </p>
    </fieldset>
    <%if(bookingsList.get(i).getReturnFlight() !=null){%>
        <fieldset class="foreground">
            <h3>Return Flight Details</h3>

            <p class="reviewDetails">
                <strong>Airline: </strong>
                <%=bookingsList.get(i).getReturnFlight().getAirlineName()%>

                    <br />
                    <strong>Departure Time:</strong>
                    <%=bookingsList.get(i).getReturnFlight().getFlightTime()%>

                        <br />
                        <strong>Flight Name:</strong>
                        <%=bookingsList.get(i).getReturnFlight().getFlightName()%>

                            <br />
                            <strong>Plane Model:</strong>
                            <%=bookingsList.get(i).getReturnFlight().getPlaneType()%>
            </p>

        </fieldset>
        <%}%>
</fieldset>

<br />

<fieldset class="background">
    <h2>Passenger Details:</h2>

    <%//for(PassengerBean passenger : bookingsList.get(i).getPassengers()){%>
    <% for (int k = 0; k < bookingsList.get(i).getPassengers().size(); k++) { %>
    <% PassengerBean passenger = bookingsList.get(i).getPassengers().get(k); %>
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
<% } %>
