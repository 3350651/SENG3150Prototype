<%@ page import="startUp.FlightBean" %>
    <%@ page import="startUp.BookingBean" %>
        <%@ page import="startUp.PassengerBean" %>
            <%@ page import="startUp.TicketBean" %>
                <% LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("userBookings"); %>
                        <ul>
                            <form action="manageBookings" method="POST">
                                <%for(BookingBean booking : bookings){%>
                                    <li>
                                        <fieldset>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <%=booking.getDepartureFlight().getDeparture().getDestinationName()
                                                            + " To " +
                                                            booking.getDepartureFlight().getDestination().getDestinationName()%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%="Date: " + booking.getDepartureFlight().getFlightTime()%></td><td style="
                                                            float: right"><button type="submit"
                                                                class="button">Select</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <%=booking.getPassengers().size() + " Passengers" %>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                        <br />
                                    </li>
                                    <%}%>
                            </form>
                        </ul>