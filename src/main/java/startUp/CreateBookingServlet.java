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

            //get the flight from the session and update availabilities
            //FlightBean flight = (FlightBean) session.getAttribute("flight");
            FlightPathBean flight = (FlightPathBean) session.getAttribute("flight");
            LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList");

            LinkedList<FlightBean> returnFlights = (LinkedList<FlightBean>) req.getAttribute("returnFlights");
            FlightBean returnFlight = null;

            if (returnFlights != null) {
                returnFlight = returnFlights.get(Integer.valueOf(req.getParameter("returnFlight")));
                req.setAttribute("returnFlight", returnFlight);
            }

            //checking for availibilities
            int passengers = Integer.parseInt(req.getParameter("numPassengers"));
            session.setAttribute("passengers", passengers);
            boolean avail = false;

            //goes through, gets the current availbilities for each flight then checks if there are any
            if (flight.getFlightPath().size() > 1)
            {
                flight.getInitialFlight().getAvailabilities(passengers);
                flight.getLastFlight().getAvailabilities(passengers);

                if (!flight.getInitialFlight().getSeatAvailability().isEmpty() && !flight.getLastFlight().getSeatAvailability().isEmpty())
                {
                    avail = true;
                }
                else
                {
                    avail = false;
                }
            }
            else
            {
                flight.getInitialFlight().getAvailabilities(passengers);

                if (!flight.getInitialFlight().getSeatAvailability().isEmpty())
                {
                    avail = true;
                }
                else
                {
                    avail = false;
                }
            }

            //if there are availabilities, save booking
            ArrayList<BookingBean> bookings = new ArrayList<>();
            float price = 0;

            if (avail)
            {
                if (flight.getFlightPath().size() > 1)
                {
                    System.out.println("size = " + flight.getFlightPath().size());
                    while (!flight.getFlightPath().isEmpty())
                    {
                        BookingBean a = new BookingBean(user.getUserID(), flight.getFlightPath().pop(), returnFlight);

                        if (returnFlight != null)
                        {
                            a.setTotalAmount(a.getDepartureFlight().getMinCost() + a.getReturnFlight().getMinCost());
                            price = price + a.getDepartureFlight().getMinCost() + a.getReturnFlight().getMinCost();
                        }
                        else
                        {
                            a.setTotalAmount(a.getDepartureFlight().getMinCost());
                            price = price + a.getDepartureFlight().getMinCost();
                        }

                        a.addBooking();

                        bookings.add(a);

                    }
                }
            }
            System.out.println(bookings.get(0).getDepartureFlight().getFlightName());
            System.out.println(bookings.get(0).getDepartureFlight().getDeparture());
            System.out.println(bookings.get(0).getDepartureFlight().getDeparture().getDestinationCode());
            session.setAttribute("isAvail", avail);
            session.setAttribute("bookingsList", bookings);
            session.setAttribute("price", price);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/PassengerDetailsPage.jsp");
            requestDispatcher.forward(req, resp);
        }

        //if coming from the passenger oiptions page
        else if (req.getParameter("options") != null) {

            ArrayList<BookingBean> bookings = (ArrayList<BookingBean>) session.getAttribute("bookingsList");

            float price = (float) session.getAttribute("price");

            int passengers = Integer.parseInt(req.getParameter("passengers"));
            PassengerBean passengerBean = null;
            LinkedList<PassengerBean> passengerBeans = new LinkedList<>();


            // creating all passengers related to the booking
            //if there are multiple flights, make multiple tickets
            if (bookings.size() > 1) {
                for (int k = 0; k < bookings.size(); k++) {
                    passengerBeans = new LinkedList<>();
                    for (int i = 1; i <= passengers; i++) {
                        String lastName = req.getParameter("lName" + i);
                        String givenNames = req.getParameter("title" + i) + " " + req.getParameter("fName" + i);
                        String email = req.getParameter("email" + i);
                        String mobile = req.getParameter("mobile" + i);
                        Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dob" + i) + " 00:00:00");

                        passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.get(k).getBookingId());
                        passengerBean.addPassenger();

                        // getting ticket information for departure and return flight
                        String ticketClass = req.getParameter("ticketClass" + i);

                        if  (req.getParameter("ticketClass" + i).equals("FIR"))
                        {
                            price = price + 1000;
                        }
                        else if (req.getParameter("ticketClass" + i).equals("BUS"))
                        {
                            price = price + 800;
                        }
                        else if (req.getParameter("ticketClass" + i).equals("PME"))
                        {
                            price = price + 600;
                        }
                        else if (req.getParameter("ticketClass" + i).equals("ECO"))
                        {
                            price = price + 500;
                        }

                        String ticketType = req.getParameter("ticketType" + i);

                        if (req.getParameter("ticketType" + i).equals("D"))
                        {
                            price = price + 50;
                        }
                        else if (req.getParameter("ticketType" + i).equals("G"))
                        {
                            price = price + 100;
                        }

                        System.out.println("PRICE = " + price);

                        String returnTicketClass = req.getParameter("ticketClassReturn" + i);
                        String returnTicketType = req.getParameter("ticketTypeReturn" + i);

                        System.out.println("Flight " + k + " = " + bookings.get(k).getDepartureFlight().getFlightName());
                        TicketBean departureTicket = new TicketBean(bookings.get(k).getBookingId(), passengerBean.getPassengerId(),
                                bookings.get(k).getDepartureFlight().getFlightName(),
                                bookings.get(k).getDepartureFlight().getAirline(),
                                bookings.get(k).getDepartureFlight().getFlightTime(), ticketClass, ticketType);
                        departureTicket.addTicket();    //add ticket to database

                        TicketBean returnTicket = null;

                        //if there is a return flight to add a ticket for
                        if (returnTicketClass != null) {
                            returnTicket = new TicketBean(bookings.get(k).getBookingId(), passengerBean.getPassengerId(),
                                    bookings.get(k).getReturnFlight().getFlightName(),
                                    bookings.get(k).getReturnFlight().getAirline(), bookings.get(k).getReturnFlight().getFlightTime(),
                                    returnTicketClass, returnTicketType);
                            returnTicket.addTicket();       //add ticket to database
                        }
                        passengerBean.setDepartureTicket(departureTicket);
                        passengerBean.setReturnTicket(returnTicket);
                        passengerBeans.add(passengerBean);
                        bookings.get(k).setPassengers(passengerBeans);
                        int test = 1;
                        System.out.println("Ticket " + test + "made");
                        test = test + 1;
                    }
                }
            } else {
                for (int i = 1; i <= passengers; i++) {
                    String lastName = req.getParameter("lName" + i);
                    String givenNames = req.getParameter("title" + i) + " " + req.getParameter("fName" + i);
                    String email = req.getParameter("email" + i);
                    String mobile = req.getParameter("mobile" + i);
                    Timestamp dateOfBirth = Timestamp.valueOf(req.getParameter("dob" + i) + " 00:00:00");

                    passengerBean = new PassengerBean(lastName, givenNames, email, mobile, dateOfBirth, bookings.get(0).getBookingId());
                    passengerBean.addPassenger();

                    // getting ticket information for departure and return flight
                    String ticketClass = req.getParameter("ticketClass" + i);
                    if  (req.getParameter("ticketClass" + i).equals("FIR"))
                    {
                        price = price + 1000;
                    }
                    else if (req.getParameter("ticketClass" + i).equals("BUS"))
                    {
                        price = price + 800;
                    }
                    else if (req.getParameter("ticketClass" + i).equals("PME"))
                    {
                        price = price + 600;
                    }
                    else if (req.getParameter("ticketClass" + i).equals("ECO"))
                    {
                        price = price + 500;
                    }

                    String ticketType = req.getParameter("ticketType" + i);

                    if (req.getParameter("ticketType" + i).equals("D"))
                    {
                        price = price + 50;
                    }
                    else if (req.getParameter("ticketType" + i).equals("G"))
                    {
                        price = price + 100;
                    }
                    
                    String returnTicketClass = req.getParameter("ticketClassReturn" + i);
                    String returnTicketType = req.getParameter("ticketTypeReturn" + i);

                    TicketBean departureTicket = new TicketBean(bookings.get(0).getBookingId(), passengerBean.getPassengerId(),
                            bookings.get(0).getDepartureFlight().getFlightName(),
                            bookings.get(0).getDepartureFlight().getAirline(),
                            bookings.get(0).getDepartureFlight().getFlightTime(), ticketClass, ticketType);
                    departureTicket.addTicket();    //add ticket to database

                    TicketBean returnTicket = null;
                    //if there is a return flight to add a ticket for
                    if (returnTicketClass != null) {
                        returnTicket = new TicketBean(bookings.get(0).getBookingId(), passengerBean.getPassengerId(),
                                bookings.get(0).getReturnFlight().getFlightName(),
                                bookings.get(0).getReturnFlight().getAirline(), bookings.get(0).getReturnFlight().getFlightTime(),
                                returnTicketClass, returnTicketType);
                        returnTicket.addTicket();       //add ticket to database
                    }
                    passengerBean.setDepartureTicket(departureTicket);
                    passengerBean.setReturnTicket(returnTicket);
                    passengerBeans.add(passengerBean);
                    bookings.get(0).setPassengers(passengerBeans);
                }
            }

                //set details to display on next page
                //booking.setPassengers(passengerBeans);
                session.setAttribute("bookings", bookings);
                session.setAttribute("price", price);
                RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/ReviewDetailsPage.jsp");
                requestDispatcher.forward(req, resp);

        }
        //if coming from the review details page
        else if(req.getParameter("payment") != null){

            BookingBean booking = (BookingBean) session.getAttribute("booking");
            booking.finalise();

            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
            requestDispatcher.forward(req, resp);
        }
    }
}
