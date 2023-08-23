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
import java.sql.Array;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;

@WebServlet(urlPatterns = { "/createBooking" })
public class CreateBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        //If request coming from details page
        if (req.getParameter("details") != null) {


            UserBean user = (UserBean) session.getAttribute("userBean");

            if (req.getParameter("oneWay") != null) {
                if (session.getAttribute("returnFlightList") != null) {
                    session.removeAttribute("returnFlightList");
                    session.removeAttribute("returnFlight");
                }
            }

            //get the flight from the session and update availabilities
            //FlightBean flight = (FlightBean) session.getAttribute("flight");
            LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList");

            LinkedList<BookingBean> bookings = new LinkedList<BookingBean>();
            FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight");

            BookingBean a = new BookingBean(user.getUserID(), flightPath, null);


            boolean hasReturn = false;

            if (req.getParameter("hasReturn") != null && req.getParameter("hasReturn").equals("hasReturn"))
            {
                FlightPathBean returnFlightPath = (FlightPathBean) session.getAttribute("returnFlight");
                a.setReturnFlightPath(returnFlightPath);
                returnFlightPath.addFlightPath();
                hasReturn = true;
            }
            bookings.add(a);
            a.addBooking();


            flightPath.addFlightPath();

            //checking for availibilities
            int passengers = (Integer) session.getAttribute("numAdults") + (Integer) session.getAttribute("numChildren");
            session.setAttribute("passengers", passengers);

            session.setAttribute("isAvail", true);
            session.setAttribute("bookings", bookings);

            if (!hasReturn)
            {
                session.setAttribute("numReturnPassengers", 0);
            }

            session.setAttribute("hasReturn", hasReturn);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/PassengerDetailsPage.jsp");
            requestDispatcher.forward(req, resp);

        }

        // if coming from the passenger options page
        else if (req.getParameter("options") != null) {

            float price = 0;
            FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight");

            // get bookings created between flight details and passenger details page
            LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("bookings");
            LinkedList<BookingBean> returnBookings = (LinkedList<BookingBean>) session.getAttribute("returnBookings");
            boolean hasReturn = (boolean) session.getAttribute("hasReturn");

            System.out.println("bookingnsize=" + bookings.size());
            System.out.println("flightpathsize = " + bookings.get(0).getDepartureFlightPath().getFlightPath().size());


            // get number of departing passengers and prepare to create PassengerBeans
            int numPassengers = (Integer)  session.getAttribute("passengers");
            int numReturnPassengers = (Integer)  session.getAttribute("numReturnPassengers");
            PassengerBean passengerBean = null;
            PassengerBean returnPassenger = null;
            LinkedList<PassengerBean> passengerBeans = new LinkedList<>();
            LinkedList<PassengerBean> returnPassengerBeans = new LinkedList<>();
            //LinkedList<TicketBean> tickets = new LinkedList<>();

            // CREATE TICKET PER FLIGHT PER PASSENGER
            LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList");
            String isReturn = "false";

            BookingBean booking = bookings.get(0);

            for (int flightIndex = 0 ; flightIndex < flightList.size() ; flightIndex++)
            {

                FlightBean flight = flightList.get(flightIndex);

                LinkedList<TicketBean> tickets = new LinkedList<>();


                // iterate though every "DEPARTING" passenger data and create passengerbeans and ticketbeans each
                for (int passengerIndex = 1; passengerIndex <= numPassengers; passengerIndex++ ) {
                    String lastName = req.getParameter("lNamefalse" + passengerIndex);
                    String givenNames = req.getParameter("titlefalse" + passengerIndex) + " " + req.getParameter("fNamefalse" + passengerIndex);
                    String email = req.getParameter("emailfalse" + passengerIndex);
                    String mobile = req.getParameter("mobilefalse" + passengerIndex);
                    Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dobfalse" + passengerIndex) + " 00:00:00");

                    // get relevant data about selected ticket from flight details page
                    float selectedPrice = flight.getSelectedPrice();
                    String ticketClassCode = flight.getClassCodeOfAvailability(selectedPrice);
                    String ticketClassName = flight.getClassNameOfAvailability(selectedPrice);
                    String ticketTypeCode = flight.getTicketTypeCodeOfAvailability(selectedPrice);
                    String ticketTypeName= flight.getTicketTypeNameOfAvailability(selectedPrice);

                    // create passengerbean for passenger
                    passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.getFirst().getBookingId());
                    passengerBean.addPassenger();

                    // just debugging here
                    System.out.println("Passenger: " + givenNames);
                    System.out.println(flightList.get(flightIndex).getDeparture().getDestinationName() + " to " + flightList.get(flightIndex).getDestination().getDestinationName());
                    System.out.println("ticketClass: " + ticketClassName);
                    System.out.println("ticketType: " + ticketTypeName);
                    System.out.println("price: " + selectedPrice);

                    // create ticketbean for passenger

                    TicketBean departureTicket = new TicketBean(booking.getBookingId(), passengerBean.getPassengerId(),
                            flightList.get(flightIndex).getFlightName(),
                            flightList.get(flightIndex).getAirline(),
                            flightList.get(flightIndex).getFlightTime(), ticketClassCode, ticketTypeCode); // class names or class code?
                    departureTicket.addTicket();    //add ticket to database
                    tickets.add(departureTicket);
                    passengerBean.setDepartureTickets(tickets);

                    price = price + selectedPrice;
                    passengerBeans.add(passengerBean);
                }
                booking.setPassengers(passengerBeans);
                bookings.get(0).updatePrice(bookings.get(0).getBookingId(), price);
                bookings.add(0, booking);
            }

            LinkedList<TicketBean> tickets = new LinkedList<>();

            // deal with return flight bookings
            if (bookings.get(0).getReturnFlightPath() != null) {
                // CREATE TICKET PER FLIGHT PER PASSENGER
                LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList");
                isReturn = "true";
                for (int returnFlightIndex = 0 ; returnFlightIndex < returnFlightList.size() ; returnFlightIndex++) {
                    FlightBean returnFlight = returnFlightList.get(returnFlightIndex);

                    // iterate though every "RETURNING" passenger data and create passengerbeans and ticketbeans each
                    for (int passengerIndex = 1; passengerIndex <= numReturnPassengers; passengerIndex++ ) {
                        String lastName = req.getParameter("lNametrue" + passengerIndex);
                        String givenNames = req.getParameter("titletrue" +passengerIndex) + " " + req.getParameter("fNamefalse" + passengerIndex);
                        String email = req.getParameter("emailtrue" + passengerIndex);
                        String mobile = req.getParameter("mobiletrue" + passengerIndex);
                        System.out.println(req.getParameter("lNametrue" + passengerIndex));
                        System.out.println(req.getParameter("dobtrue" + passengerIndex) + " 00:00:00");
                        Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dobtrue" + passengerIndex) + " 00:00:00");

                        // get relevant data about selected ticket from flight details page
                        float selectedPrice = returnFlight.getSelectedPrice();
                        String ticketClassCode = returnFlight.getClassCodeOfAvailability(selectedPrice);
                        String ticketClassName = returnFlight.getClassNameOfAvailability(selectedPrice);
                        String ticketTypeCode = returnFlight.getTicketTypeCodeOfAvailability(selectedPrice);
                        String ticketTypeName= returnFlight.getTicketTypeNameOfAvailability(selectedPrice);

                        // create passengerbean for passenger
                        returnPassenger = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.getFirst().getBookingId());
                        returnPassenger.addPassenger();

                        // just debugging here
                        System.out.println("Passenger: " + givenNames);
                        System.out.println(returnFlight.getDeparture().getDestinationName() + " to " + returnFlight.getDestination().getDestinationName());
                        System.out.println("ticketClass: " + ticketClassName);
                        System.out.println("ticketType: " + ticketTypeName);
                        System.out.println("price: " + selectedPrice);

                        // create ticketbean for passenger

                        TicketBean returnTicket = new TicketBean(booking.getBookingId(), returnPassenger.getPassengerId(),
                                returnFlight.getFlightName(),
                                returnFlight.getAirline(),
                                returnFlight.getFlightTime(), ticketClassCode, ticketTypeCode); // class name or class code?
                       returnTicket.addTicket();    //add ticket to database

                        tickets.add(returnTicket);
                        passengerBean.setDepartureTickets(tickets);

                        price = price + selectedPrice;
                        returnPassengerBeans.add(returnPassenger);
                    }
                    booking.setReturnPassengers(returnPassengerBeans);
                    bookings.get(0).updatePrice(bookings.get(0).getBookingId(), price);
                    bookings.add(0,booking);
                }
            }

            //set details to display on next page
            //booking.setPassengers(passengerBeans);

            // session.setAttribute("bookings", bookings); // already set between flight and passenger details page
            session.setAttribute("price", price);
            session.setAttribute("bookings", bookings);
            System.out.println(bookings.get(0).getDepartureFlightPath().getInitialFlight().getDeparture().getDestinationName());
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/ReviewDetailsPage.jsp");
            requestDispatcher.forward(req, resp);

        }



        //if coming from the review details page
        else if(req.getParameter("payment") != null){

            //since we dont handle pay, it just finalises each booking
            LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("bookings");

            for (int i = 0; i < bookings.size(); i++)
            {
                bookings.get(i).finalise();
            }

            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
            requestDispatcher.forward(req, resp);
        }
    }
}