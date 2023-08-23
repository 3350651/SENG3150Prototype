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
                }
            }

            //get the flight from the session and update availabilities
            //FlightBean flight = (FlightBean) session.getAttribute("flight");
            FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight");
            LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList");

            LinkedList<BookingBean> bookings = new LinkedList<BookingBean>();
            LinkedList<BookingBean> returnBookings = new LinkedList<BookingBean>();

            for(FlightBean flight : flightList) {
                BookingBean a = new BookingBean(user.getUserID(), flight, null);
                bookings.add(a);
            }

            if (req.getParameter("hasReturn") != null && req.getParameter("hasReturn").equals("hasReturn")) {
                LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList");

                for (FlightBean returnFlight : returnFlightList) {
                    BookingBean a = new BookingBean(user.getUserID(), null, returnFlight);
                    returnBookings.add(a);
                }
            }
//            booking.setTotalAmount(a.getDepartureFlight().getMinCost());

            //checking for availibilities
            int passengers = (Integer) session.getAttribute("numAdults") + (Integer) session.getAttribute("numChildren");
            int returnPassengers = (Integer) session.getAttribute("numReturnPassengers");
            session.setAttribute("passengers", passengers);

            session.setAttribute("isAvail", true);
            session.setAttribute("bookings", bookings);
            session.setAttribute("returnBookings", returnBookings);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/PassengerDetailsPage.jsp");
            requestDispatcher.forward(req, resp);

        }

        // if coming from the passenger options page
        else if (req.getParameter("options") != null) {

            // get bookings created between flight details and passenger details page
            LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("bookings");
            LinkedList<BookingBean> returnBookings = (LinkedList<BookingBean>) session.getAttribute("returnBookings");

            // get number of departing passengers and prepare to create PassengerBeans
            int numPassengers = (Integer)  session.getAttribute("passengers");
            PassengerBean passengerBean = null;
            LinkedList<PassengerBean> passengerBeans = new LinkedList<>();

            // get number of return passengers and prepare to create PassengerBeans
            int numReturnPassengers = (Integer)  session.getAttribute("numReturnPassengers");
            PassengerBean returnPassenger = null;
            LinkedList<PassengerBean> returnPassengerBeans = new LinkedList<>();

            // CREATE TICKET PER FLIGHT PER PASSENGER
            LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList");
            String isReturn = "false";
            for (int flightIndex = 0 ; flightIndex < flightList.size() ; flightIndex++) {
                FlightBean flight = flightList.get(flightIndex);

                // find appropriate booking for this flight
                BookingBean booking = null;
                for (BookingBean bookingBean : bookings) {
                    if (bookingBean.getDepartureFlight().getFlightTime() == flight.getFlightTime()) {
                        booking = bookingBean;
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
//                    passengerBean.addPassenger(); // add to database

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
                            flightList.get(flightIndex).getFlightTime(), ticketClassName, ticketTypeName); // class names or class code?
//                    departureTicket.addTicket();    //add ticket to database

                    passengerBeans.add(passengerBean);
                }
                booking.setPassengers(passengerBeans);
            }

            // deal with return flight bookings
            if (returnBookings != null) {
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
                        if (bookingBean.getReturnFlight().getFlightTime() == returnFlight.getFlightTime()) {
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
//                        passengerBean.addPassenger();

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
                                returnFlight.getFlightTime(), ticketClassName, ticketTypeName); // class name or class code?
//                        returnTicket.addTicket();    //add ticket to database

                        returnPassengerBeans.add(returnPassenger);
                    }
                    returnBooking.setPassengers(returnPassengerBeans);
                }
            }

//            System.out.println("req"+ req.getParameter("price" + flight1.get(0).getFlightTime().toString()));
//            System.out.println("reqTotal"+ req.getParameter("1total"));
//            System.out.println("reqPrice"+ req.getParameter("1-false-price-" + flight1.get(0).getFlightTime().toString()));
//            System.out.println("reqclass"+ req.getParameter("1-false-class-" + flight1.get(0).getFlightTime().toString()));
//            System.out.println("reqticket"+ req.getParameter("1-false-type-" + flight1.get(0).getFlightTime().toString()));


//            int passengers = Integer.parseInt(req.getParameter("passengers"));
//            PassengerBean passengerBean = null;
//            LinkedList<PassengerBean> passengerBeans = new LinkedList<>();
//
//
//            // creating all passengers related to the booking
//            //if there are multiple flights, make multiple tickets
//            if (bookings.size() > 1) {
//                for (int k = 0; k < bookings.size(); k++) {
//                    passengerBeans = new LinkedList<>();
//                    for (int i = 1; i <= passengers; i++) {
//                        String lastName = req.getParameter("lName" + i);
//                        String givenNames = req.getParameter("title" + i) + " " + req.getParameter("fName" + i);
//                        String email = req.getParameter("email" + i);
//                        String mobile = req.getParameter("mobile" + i);
//                        Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dob" + i) + " 00:00:00");
//
//                        passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.get(k).getBookingId());
//                        passengerBean.addPassenger(); // add to database
//
//                        // getting ticket information for departure and return flight
//                        String ticketClass = req.getParameter("ticketClass" + i);
//
//                        if  (req.getParameter("ticketClass" + i).equals("FIR"))
//                        {
//                            price = price + 1000;
//                        }
//                        else if (req.getParameter("ticketClass" + i).equals("BUS"))
//                        {
//                            price = price + 800;
//                        }
//                        else if (req.getParameter("ticketClass" + i).equals("PME"))
//                        {
//                            price = price + 600;
//                        }
//                        else if (req.getParameter("ticketClass" + i).equals("ECO"))
//                        {
//                            price = price + 500;
//                        }
//
//                        String ticketType = req.getParameter("ticketType" + i);
//
//                        if (req.getParameter("ticketType" + i).equals("D"))
//                        {
//                            price = price + 50;
//                        }
//                        else if (req.getParameter("ticketType" + i).equals("G"))
//                        {
//                            price = price + 100;
//                        }
//
//                        String returnTicketClass = req.getParameter("ticketClassReturn" + i);
//                        String returnTicketType = req.getParameter("ticketTypeReturn" + i);
//
//                        TicketBean departureTicket = new TicketBean(bookings.get(k).getBookingId(), passengerBean.getPassengerId(),
//                                bookings.get(k).getDepartureFlight().getFlightName(),
//                                bookings.get(k).getDepartureFlight().getAirline(),
//                                bookings.get(k).getDepartureFlight().getFlightTime(), ticketClass, ticketType);
//                        departureTicket.addTicket();    //add ticket to database
//
//                        TicketBean returnTicket = null;
//
//                        //if there is a return flight to add a ticket for
//                        if (returnTicketClass != null) {
//                            returnTicket = new TicketBean(bookings.get(k).getBookingId(), passengerBean.getPassengerId(),
//                                    bookings.get(k).getReturnFlight().getFlightName(),
//                                    bookings.get(k).getReturnFlight().getAirline(), bookings.get(k).getReturnFlight().getFlightTime(),
//                                    returnTicketClass, returnTicketType);
//                            returnTicket.addTicket();       //add ticket to database
//                        }
////                        passengerBean.setDepartureTicket(departureTicket);
////                        passengerBean.setReturnTicket(returnTicket);
//                        passengerBeans.add(passengerBean);
//                        bookings.get(k).setPassengers(passengerBeans);
//                        int test = 1;
//                        System.out.println("Ticket " + test + "made");
//                        test = test + 1;
//                    }
//                }
//            } else {
//                for (int i = 1; i <= passengers; i++) {
//                    String lastName = req.getParameter("lName" + i);
//                    String givenNames = req.getParameter("title" + i) + " " + req.getParameter("fName" + i);
//                    String email = req.getParameter("email" + i);
//                    String mobile = req.getParameter("mobile" + i);
//                    Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dob" + i) + " 00:00:00");
//
//                    passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.get(0).getBookingId());
//                    passengerBean.addPassenger();
//
//                    // getting ticket information for departure and return flight
//                    String ticketClass = req.getParameter("ticketClass" + i);
//
//                    if  (req.getParameter("ticketClass" + i).equals("FIR"))
//                    {
//                        price = price + 1000;
//                    }
//                    else if (req.getParameter("ticketClass" + i).equals("BUS"))
//                    {
//                        price = price + 800;
//                    }
//                    else if (req.getParameter("ticketClass" + i).equals("PME"))
//                    {
//                        price = price + 600;
//                    }
//                    else if (req.getParameter("ticketClass" + i).equals("ECO"))
//                    {
//                        price = price + 500;
//                    }
//                    String ticketType = req.getParameter("ticketType" + i);
//
//                    if (req.getParameter("ticketType" + i).equals("D"))
//                    {
//                        price = price + 50;
//                    }
//                    else if (req.getParameter("ticketType" + i).equals("G"))
//                    {
//                        price = price + 100;
//                    }
//
//                    String returnTicketClass = req.getParameter("ticketClassReturn" + i);
//                    String returnTicketType = req.getParameter("ticketTypeReturn" + i);
//
//                    TicketBean departureTicket = new TicketBean(bookings.get(0).getBookingId(), passengerBean.getPassengerId(),
//                            bookings.get(0).getDepartureFlight().getFlightName(),
//                            bookings.get(0).getDepartureFlight().getAirline(),
//                            bookings.get(0).getDepartureFlight().getFlightTime(), ticketClass, ticketType);
//                    departureTicket.addTicket();    //add ticket to database
//
//                    TicketBean returnTicket = null;
//                    //if there is a return flight to add a ticket for
//                    if (returnTicketClass != null) {
//                        returnTicket = new TicketBean(bookings.get(0).getBookingId(), passengerBean.getPassengerId(),
//                                bookings.get(0).getReturnFlight().getFlightName(),
//                                bookings.get(0).getReturnFlight().getAirline(), bookings.get(0).getReturnFlight().getFlightTime(),
//                                returnTicketClass, returnTicketType);
//                        returnTicket.addTicket();       //add ticket to database
//                    }
////                    passengerBean.setDepartureTicket(departureTicket);
////                    passengerBean.setReturnTicket(returnTicket);
//                    passengerBeans.add(passengerBean);
//                    bookings.get(0).setPassengers(passengerBeans);
//                }
//            }

            //set details to display on next page
            //booking.setPassengers(passengerBeans);

            // session.setAttribute("bookings", bookings); // already set between flight and passenger details page
            session.setAttribute("price", "5000");
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