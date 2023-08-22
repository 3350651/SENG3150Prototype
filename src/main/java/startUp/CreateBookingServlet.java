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
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        //If request coming from details page
        LinkedList<BookingBean> bookings = new LinkedList<BookingBean>();;
        if (req.getParameter("details") != null) {
            UserBean user = (UserBean) session.getAttribute("userBean");

            //get the flight from the session and update availabilities
            //FlightBean flight = (FlightBean) session.getAttribute("flight");
            FlightPathBean flight = (FlightPathBean) session.getAttribute("flight");
            LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList");

            BookingBean a = null;
            if (req.getParameter("hasReturn") != null && req.getParameter("hasReturn").equals("hasReturn")) {
                LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList");
                a = new BookingBean(user.getUserID(), flightList, returnFlightList);
            } else {
                a = new BookingBean(user.getUserID(), flightList, null);
            }
            //a.setTotalAmount(a.getDepartureFlight().getMinCost());
            bookings.add(a);


            //gets the number of return flights?
//            if (returnFlights != null) {
//                returnFlight = returnFlights.get(Integer.valueOf(req.getParameter("returnFlight")));
//                req.setAttribute("returnFlight", returnFlight);
//            }

            //checking for availibilities
            int passengers = (Integer) session.getAttribute("numAdults") + (Integer) session.getAttribute("numChildren");
            session.setAttribute("passengers", passengers);

            session.setAttribute("isAvail", true);
            session.setAttribute("bookingsList", bookings);
            //session.setAttribute("price", price);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/PassengerDetailsPage.jsp");
            requestDispatcher.forward(req, resp);

        }




        //if coming from the passenger options page
//        else if (req.getParameter("options") != null) {
//
//            ArrayList<BookingBean> bookings = (ArrayList<BookingBean>) session.getAttribute("bookingsList");
//
//            float price = (float) session.getAttribute("price");
//
//            LinkedList<FlightBean> flight1 = (LinkedList<FlightBean>) session.getAttribute("flightList");
//            System.out.println("req"+ req.getParameter("price" + flight1.get(0).getFlightTime().toString()));
//            System.out.println("reqTotal"+ req.getParameter("1total"));
//            System.out.println("reqPrice"+ req.getParameter("1-false-price-" + flight1.get(0).getFlightTime().toString()));
//            System.out.println("reqclass"+ req.getParameter("1-false-class-" + flight1.get(0).getFlightTime().toString()));
//            System.out.println("reqticket"+ req.getParameter("1-false-type-" + flight1.get(0).getFlightTime().toString()));
//
//
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
//                        passengerBean.addPassenger();
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
//
//            //set details to display on next page
//            //booking.setPassengers(passengerBeans);
//            session.setAttribute("bookings", bookings);
//            session.setAttribute("price", price);
//            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/ReviewDetailsPage.jsp");
//            requestDispatcher.forward(req, resp);
//
//        }
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