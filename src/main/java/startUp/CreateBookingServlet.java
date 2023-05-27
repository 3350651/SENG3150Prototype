/**
 * FILE NAME: CreateBookingServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for creation of bookings
 */

package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;

@WebServlet(urlPatterns = { "/createBooking" })
public class CreateBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        if (req.getParameter("details") != null) {

            UserBean user = (UserBean) session.getAttribute("userBean");

            FlightBean flight = (FlightBean) session.getAttribute("flight");
            flight.getAvailabilities();
            session.setAttribute("flight", flight); // overwrite the flight attribute
            LinkedList<FlightBean> returnFlights = (LinkedList<FlightBean>) req.getAttribute("returnFlights");
            FlightBean returnFlight = null;
            if (returnFlights != null) {
                returnFlight = returnFlights.get(Integer.valueOf(req.getParameter("returnFlight")));
                req.setAttribute("returnFlight", returnFlight);
            }

            int passengers = Integer.parseInt(req.getParameter("numPassengers"));
            req.setAttribute("passengers", passengers);

            // TODO: Check the availability of the flight

            BookingBean booking = new BookingBean(user.getUserID(), flight, returnFlight);
            session.setAttribute("booking", booking);
            booking.addBooking(); // saving progress of booking
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/PassengerDetailsPage.jsp");
            requestDispatcher.forward(req, resp);
        }

        else if (req.getParameter("options") != null) {

            BookingBean booking = (BookingBean) session.getAttribute("booking");
            int passengers = Integer.parseInt(req.getParameter("passengers"));
            PassengerBean passengerBean = null;
            LinkedList<PassengerBean> passengerBeans = new LinkedList<>();
            // creating all passengers related to the booking
            for (int i = 1; i <= passengers; i++) {
                String lastName = req.getParameter("lName" + i);
                String givenNames = req.getParameter("title" + i) + " " + req.getParameter("fName" + i);
                String email = req.getParameter("email" + i);
                String mobile = req.getParameter("mobile" + i);
                Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dob" + i) + " 00:00:00");

                passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth,
                        booking.getBookingId());
                passengerBean.addPassenger();

                // getting ticket information for departure and return flight
                String ticketClass = req.getParameter("ticketClass" + i);
                String ticketType = req.getParameter("ticketType" + i);
                String returnTicketClass = req.getParameter("ticketClassReturn" + i);
                String returnTicketType = req.getParameter("ticketTypeReturn" + i);

                TicketBean departureTicket = new TicketBean(booking.getBookingId(), passengerBean.getPassengerId(),
                        booking.getDepartureFlight().getFlightName(),
                        booking.getDepartureFlight().getAirline(), booking.getDepartureFlight().getFlightTime(),
                        ticketClass, ticketType);
                departureTicket.addTicket();

                TicketBean returnTicket = null;
                if (returnTicketClass != null) {
                    returnTicket = new TicketBean(booking.getBookingId(), passengerBean.getPassengerId(),
                            booking.getReturnFlight().getFlightName(),
                            booking.getReturnFlight().getAirline(), booking.getReturnFlight().getFlightTime(),
                            returnTicketClass, returnTicketType);
                    returnTicket.addTicket();
                }
                passengerBean.setDepartureTicket(departureTicket);
                passengerBean.setReturnTicket(returnTicket);
                passengerBeans.add(passengerBean);
            }

            booking.setPassengers(passengerBeans);
            session.setAttribute("booking", booking);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/ReviewDetailsPage.jsp");
            requestDispatcher.forward(req, resp);
        }
        else if(req.getParameter("payment") != null){

            BookingBean booking = (BookingBean) session.getAttribute("booking");
            booking.finalise();

            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
            requestDispatcher.forward(req, resp);
        }
    }
}
