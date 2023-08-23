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
            System.out.println("initial fligthsize = " +  flightPath.getFlightPath().size());

            BookingBean a = new BookingBean(user.getUserID(), flightPath, null);
            System.out.println("a booking path size" + a.getDepartureFlightPath().getFlightPath().size());


            boolean hasReturn = false;

            if (req.getParameter("hasReturn") != null && req.getParameter("hasReturn").equals("hasReturn"))
            {
                FlightPathBean returnFlightPath = (FlightPathBean) session.getAttribute("returnFlight");
                a.setReturnFlightPath(returnFlightPath);
                hasReturn = true;
            }
            bookings.add(a);
            a.addBooking();
            System.out.println("Bookings size = " + bookings.size());
            System.out.println("post add booking size = " + bookings.getFirst().getDepartureFlightPath().getFlightPath().size());

            flightPath.addFlightPath();
            /*if (req.getParameter("hasReturn") != null && req.getParameter("hasReturn").equals("hasReturn")) {
                LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList");

                for (FlightBean returnFlight : returnFlightList) {
                    BookingBean a = new BookingBean(user.getUserID(), returnFlight, null);;
                    System.out.println("booking b");
                    a.addBooking();
                    returnBookings.add(a);
                }

                hasReturn = true;
                session.setAttribute("hasReturn", hasReturn);
                int returnPassengers = (Integer) session.getAttribute("numReturnPassengers");
            }*/

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
            PassengerBean passengerBean = null;
            LinkedList<PassengerBean> passengerBeans = new LinkedList<>();
            LinkedList<TicketBean> tickets = new LinkedList<>();

            // CREATE TICKET PER FLIGHT PER PASSENGER
            LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList");
            String isReturn = "false";

            if (hasReturn)
            {
                FlightPathBean returnflightPath = (FlightPathBean) session.getAttribute("returnFlight");

                for (int i = 0; i < numPassengers; i++)
                {
                    String lastName = req.getParameter("lNamefalse" + i);
                    String givenNames = req.getParameter("titlefalse" + i) + " " + req.getParameter("fNamefalse" + i);
                    String email = req.getParameter("emailfalse" + i);
                    String mobile = req.getParameter("mobilefalse" + i);
                    Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dobfalse" + i) + " 00:00:00");

                    passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.getFirst().getBookingId());
                    passengerBean.addPassenger();

                    System.out.println("bookingnsize=" + bookings.size());
                    System.out.println("flightpathsize = " + bookings.get(0).getDepartureFlightPath().getFlightPath().size());

                    TicketBean ticket = new TicketBean(bookings.getFirst().getBookingId(), passengerBean.getPassengerId(), bookings.getFirst().getDepartureFlightPath().getInitialFlight().getFlightName(),
                            bookings.getFirst().getDepartureFlightPath().getInitialFlight().getAirline(), bookings.getFirst().getDepartureFlightPath().getInitialFlight().getFlightTime(),
                        classCodes.getFirst(), classTypes.getFirst());
                    ticket.addTicket();

                    tickets.add(ticket);
                }

                for (int i = 0; i < numPassengers; i++)
                {
                    String lastName = req.getParameter("lNametrue" + i);
                    String givenNames = req.getParameter("titletrue" + i) + " " + req.getParameter("fNametrue" + i);
                    String email = req.getParameter("emailtrue" + i);
                    String mobile = req.getParameter("mobiletrue" + i);
                    Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dobtrue" + i) + " 00:00:00");

                    passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.getFirst().getBookingId());
                    passengerBean.addPassenger();

                    TicketBean ticket = new TicketBean(bookings.getLast().getBookingId(), passengerBean.getPassengerId(), bookings.getLast().getReturnFlightPath().getInitialFlight().getFlightName(),
                            bookings.getLast().getDepartureFlightPath().getInitialFlight().getAirline(), bookings.getLast().getReturnFlightPath().getInitialFlight().getFlightTime(),
                            classCodes.getLast(), classTypes.getLast());
                    ticket.addTicket();

                    tickets.add(ticket);
                }
            }
            else
            {

                for (int i = 1; i <= numPassengers; i++)
                {
                    String lastName = req.getParameter("lNamefalse" + i);
                    String givenNames = req.getParameter("titlefalse" + i) + " " + req.getParameter("fNamefalse" + i);
                    String email = req.getParameter("emailfalse" + i);
                    String mobile = req.getParameter("mobilefalse" + i);
                    System.out.println(req.getParameter("lNamefalse" + i));
                    System.out.println(req.getParameter("dobfalse" + i) + " 00:00:00");
                    Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dobfalse" + i) + " 00:00:00");


                    passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.getFirst().getBookingId());
                    passengerBean.addPassenger();

                    TicketBean ticket = new TicketBean(bookings.getFirst().getBookingId(), passengerBean.getPassengerId(), bookings.getFirst().getDepartureFlightPath().getLastFlight().getFlightName(),
                            bookings.getFirst().getDepartureFlightPath().getLastFlight().getAirline(), bookings.getFirst().getDepartureFlightPath().getLastFlight().getFlightTime(),
                            classCodes.getFirst(), classTypes.getFirst());
                    ticket.addTicket();

                    tickets.add(ticket);
                }
            }

            /*for (int flightIndex = 0 ; flightIndex < flightList.size() ; flightIndex++) {

                FlightBean flight = flightList.get(flightIndex);

                // find appropriate booking for this flight
                BookingBean booking = null;

               int bookingIndex = 0;

               for (int i = 0; i < bookings.size(); i++)
               {

                   Timestamp flightStamp = flightList.get(flightIndex).getFlightTime();
                   Timestamp bookingTime = bookings.get(i).getDepartureFlight().getFlightTime();

                   if (bookingTime.equals(flightStamp))
                   {
                       System.out.println("BOOKING Success");
                       booking = bookings.get(i);
                       bookingIndex = i;
                       break;
                   }
                   else{
                       System.out.println("BOOKING FAILURE ");
                   }
               }

                // iterate though every "DEPARTING" passenger data and create passengerbeans and ticketbeans each
                for (int passengerIndex = 1; passengerIndex <= numPassengers; passengerIndex++ ) {
                    String lastName = req.getParameter("lName" + passengerIndex + isReturn);
                    String givenNames = req.getParameter("title" + passengerIndex + isReturn) + " " + req.getParameter("fName" + passengerIndex + isReturn);
                    String email = req.getParameter("email" + passengerIndex + isReturn);
                    String mobile = req.getParameter("mobile" + passengerIndex + isReturn);
                    Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dob" + passengerIndex + isReturn) + " 00:00:00");

                    // get relevant data about selected ticket from flight details page
                    float selectedPrice = flight.getSelectedPrice();
                    String ticketClassCode = flight.getClassCodeOfAvailability(selectedPrice);
                    String ticketClassName = flight.getClassNameOfAvailability(selectedPrice);
                    String ticketTypeCode = flight.getTicketTypeCodeOfAvailability(selectedPrice);
                    String ticketTypeName= flight.getTicketTypeNameOfAvailability(selectedPrice);

                    // create passengerbean for passenger
                    passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, booking.getBookingId());


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
                    LinkedList<TicketBean> tickets = new LinkedList<>();
                    tickets.add(departureTicket);
                    passengerBean.setDepartureTickets(tickets);
                    passengerBean.addPassenger();

                    price = price + selectedPrice;
                    passengerBeans.add(passengerBean);
                }
                booking.setPassengers(passengerBeans);
                bookings.add(bookingIndex, booking);
            }

            System.out.println("returnnbookingsize = "  + returnBookings.size());
            // deal with return flight bookings
            if (returnBookings.size() > 0) {
                // CREATE TICKET PER FLIGHT PER PASSENGER
                LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList");
                isReturn = "true";
                for (int returnFlightIndex = 0 ; returnFlightIndex < returnFlightList.size() ; returnFlightIndex++) {
                    FlightBean returnFlight = returnFlightList.get(returnFlightIndex);

                    BookingBean returnBooking = null;
                    // find appropriate booking for this flight
                    for (BookingBean bookingBean : returnBookings) {
                        System.out.println(bookingBean.getReturnFlight().getFlightTime());
                        System.out.println(returnFlight.getFlightTime());
                        if (bookingBean.getDepartureFlight().getFlightTime() == returnFlight.getFlightTime()) {
                            returnBooking = bookingBean;
                        }
                    }

                    // iterate though every "RETURNING" passenger data and create passengerbeans and ticketbeans each
                    for (int passengerIndex = 1; passengerIndex <= numReturnPassengers; passengerIndex++ ) {
                        String lastName = req.getParameter("lName" + passengerIndex + isReturn);
                        String givenNames = req.getParameter("title" + passengerIndex + isReturn) + " " + req.getParameter("fName" + passengerIndex + isReturn);
                        String email = req.getParameter("email" + passengerIndex + isReturn);
                        String mobile = req.getParameter("mobile" + passengerIndex + isReturn);
                        Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dob" + passengerIndex + isReturn) + " 00:00:00");

                        // get relevant data about selected ticket from flight details page
                        float selectedPrice = returnFlight.getSelectedPrice();
                        String ticketClassCode = returnFlight.getClassCodeOfAvailability(selectedPrice);
                        String ticketClassName = returnFlight.getClassNameOfAvailability(selectedPrice);
                        String ticketTypeCode = returnFlight.getTicketTypeCodeOfAvailability(selectedPrice);
                        String ticketTypeName= returnFlight.getTicketTypeNameOfAvailability(selectedPrice);

                        // create passengerbean for passenger
                        returnPassenger = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, returnBooking.getBookingId());

                        // just debugging here
                        System.out.println("Passenger: " + givenNames);
                        System.out.println(returnFlight.getDeparture().getDestinationName() + " to " + returnFlight.getDestination().getDestinationName());
                        System.out.println("ticketClass: " + ticketClassName);
                        System.out.println("ticketType: " + ticketTypeName);
                        System.out.println("price: " + selectedPrice);

                        // create ticketbean for passenger
                        TicketBean returnTicket = new TicketBean(returnBooking.getBookingId(), passengerBean.getPassengerId(),
                                returnFlight.getFlightName(),
                                returnFlight.getAirline(),
                                returnFlight.getFlightTime(), ticketClassCode, ticketTypeCode); // class name or class code?
                       returnTicket.addTicket();    //add ticket to database

                        LinkedList<TicketBean> tickets = new LinkedList<>();
                        tickets.add(returnTicket);
                        passengerBean.setDepartureTickets(tickets);
                        passengerBean.addPassenger();

                        price = price + selectedPrice;
                        returnPassengerBeans.add(returnPassenger);
                    }
                    returnBooking.setPassengers(returnPassengerBeans);
                }
            }*/

            //set details to display on next page
            //booking.setPassengers(passengerBeans);

            // session.setAttribute("bookings", bookings); // already set between flight and passenger details page
            session.setAttribute("price", price);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/ReviewDetailsPage.jsp");
            requestDispatcher.forward(req, resp);

        }



        //if coming from the review details page
//        else if(req.getParameter("payment") != null){
//
//            //since we dont handle pay, it just finalises each booking
//            ArrayList<BookingBean> bookings = (ArrayList<BookingBean>) session.getAttribute("bookingsList");
//
//            for (int i = 0; i < bookings.size(); i++)
//            {
//                bookings.get(i).finalise();
//            }
//
//            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
//            requestDispatcher.forward(req, resp);
//        }
    }
}