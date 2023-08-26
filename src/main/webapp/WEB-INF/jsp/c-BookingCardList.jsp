<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.BookingBean" %>
<%@ page import="java.util.LinkedList" %>
        <%@ page import="startUp.PassengerBean" %>
            <%@ page import="startUp.TicketBean" %>
                <% LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("userBookings"); %>
<% if (bookings.isEmpty()) { %>
<div style="text-align: center;"><h3>No bookings avaliable to view. Please make a booking to view it here.</h3></div>
<% } else { %>
                        <ul>
                            <form action="manageBookings" method="POST">
                                <%for(int i = 0; i < bookings.size(); i++){%>
                                    <li>
                                        <fieldset>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <%=bookings.get(i).getDepartureFlightPath().getLastFlight().getDeparture().getDestinationName()
                                                            + " To " +
                                                                bookings.get(i).getDepartureFlightPath().getInitialFlight().getDestination().getDestinationName()%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%="Date: " + bookings.get(i).getDepartureFlightPath().getInitialFlight().getFlightTime()%></td><td style="
                                                            float: right"><button type="submit"
                                                                class="button" name="bookingButton" value="<%=bookings.indexOf(bookings.get(i))%>">Select</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=bookings.get(i).getPassengers().size() + " Passengers" %>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                        <br />
                                    </li>
                                    <%}%>
                            </form>
                        </ul>
<%  } %>