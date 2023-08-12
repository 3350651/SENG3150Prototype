/**
 * FILE NAME: FlightSearchServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for searching for a flight
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
import java.time.Instant;
import java.util.LinkedList;
import java.util.Stack;

@WebServlet(urlPatterns = { "/flightSearch" })
public class FlightSearchServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (request.getParameter("home").equalsIgnoreCase("recommendSearch")) {

            SearchBean search = new SearchBean(null, null, null, null, false, 0, 0, 0);

            session.setAttribute("flightResults", search);
            request.setAttribute("goToRecommend", true);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
            requestDispatcher.forward(request, response);
        } else {
            request.setAttribute("goToSimple", true);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
            requestDispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (request.getParameter("searchResults") != null
                && request.getParameter("searchResults").equalsIgnoreCase("recSearchResults")) {
            SearchBean search = new SearchBean(null, null, null, null, false, 0, 0, 0);
            session.setAttribute("flightResults", search);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/recSearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("searchResults") != null
                && request.getParameter("searchResults").equalsIgnoreCase("simpleSearchResults")) {

            String departure = request.getParameter("departureLocation");
            String destination = request.getParameter("arrivalLocation");
            String time = request.getParameter("departureDate");
            time += " 00:00:00";
            Timestamp departureTime = Timestamp.valueOf(time);
            boolean flexible = Boolean.getBoolean(request.getParameter("flexibleDate"));
            int flexibleDays = 0;
            if (!request.getParameter("flexibleDays").equals("")) {
                flexibleDays = Integer.parseInt(request.getParameter("flexibleDays"));
            }
            int adults = Integer.parseInt(request.getParameter("numberOfAdults"));
            int children = Integer.parseInt(request.getParameter("numberOfChildren"));
            if (adults < 0 || children < 0 || (adults == 0 && children == 0)) {
                throw new IOException("Invalid input: Invalid combination of adult and children passengers.");
            }
            if (destination == null) {
                throw new IOException("Invalid input: Select a destination.");
            }
            if (departure == null) {
                throw new IOException("Invalid input: Select a departure location.");
            }
            if (departure.equals(destination)) {
                throw new IOException("Invalid input: Cannot leave from and arrive at the same destination.");
            }
            if (flexible && flexibleDays == 0) {
                throw new IOException("Invalid input: Provide a number of days that the search should be flexible by");
            }

            System.out.println(departure);
            System.out.println(destination);
            System.out.println("FlightSearchServlet.simpleSearchResults.departureTime " + departureTime);
            System.out.println("adults: " + adults);
            System.out.println("children: " + children);


            SearchBean search = new SearchBean(departureTime, destination, departure, null, true, 0, adults, children);
            search.searchFlights();
            session.setAttribute("flightResults", search);
            session.setAttribute("numAdultsForReturn", adults); //save values on session for return search
            session.setAttribute("numChildrenForReturn", children); //save values on session for return search
            session.setAttribute("flightResults", search);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/simpleSearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("viewFlight") != null) {
            System.out.println("isReturnResults = " + request.getParameter("isReturnResults"));
            if (request.getParameter("isReturnResults").equalsIgnoreCase("true")) {
                System.out.println("FlightSearchServlet.viewFlight.Return");
                LinkedList<FlightPathBean> flights = (LinkedList<FlightPathBean>) session.getAttribute("flightResultList");
                LinkedList<FlightPathBean> returnFlights = (LinkedList<FlightPathBean>) session.getAttribute("returnFlightResultList");

                FlightPathBean returnFlight = returnFlights.get(Integer.parseInt(request.getParameter("returnFlightIndex")));

                // Invert the flightBean stack and store in linked list. Easier to call with a FOR loop on a jsp page
                LinkedList<FlightBean> returnFlightList = new LinkedList<FlightBean>();
                Stack<FlightBean> returnFlightStack = returnFlight.getFlightPath();
                for ( int i = 1 ; i <= returnFlightStack.size(); i++) {
                    returnFlightList.addLast(returnFlightStack.get(returnFlightStack.size() - i));
                }

                session.setAttribute("returnFlight", returnFlight);
                session.setAttribute("returnFlightList", returnFlightList);
                session.setAttribute("viewReturnFlightSearchResults", Boolean.FALSE);
                session.setAttribute("viewReturnFlightDetails", Boolean.TRUE);

                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
                requestDispatcher.forward(request, response);
            }

            LinkedList<FlightPathBean> flights = (LinkedList<FlightPathBean>) session.getAttribute("flightResultList");
            FlightPathBean flight = flights.get(Integer.parseInt(request.getParameter("flightIndex")));

            // Invert the flightBean stack and store in linked list. Easier to call with a FOR loop on a jsp page
            LinkedList<FlightBean> flightList = new LinkedList<FlightBean>();
            Stack<FlightBean> flightStack = flight.getFlightPath();
            for ( int i = 1 ; i <= flightStack.size(); i++) {
                flightList.addLast(flightStack.get(flightStack.size() - i));
            }

            System.out.println("FlightSearchServlet.viewFlight");
            session.setAttribute("flight", flight);
            session.setAttribute("flightList", flightList);
            session.setAttribute("viewReturnFlightSearchResults", Boolean.FALSE);
            session.setAttribute("viewReturnFlightDetails", Boolean.FALSE);
            /* TODO: No longer valid
            String flightDetails = flight.getAirline() + "," + flight.getFlightName() + ","
                    + flight.getFlightTime();
            session.setAttribute("flightDetails", flightDetails);*/

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("searchResults") != null
                && request.getParameter("searchResults").equalsIgnoreCase("simpleReturnSearchResults")) {

            System.out.println("FlightSearchServlet.simpleReturnSearchResults");
            String departure = request.getParameter("departureLocation");
            String destination = request.getParameter("arrivalLocation");
            String time = request.getParameter("returnDate");
            time += " 00:00:00";
            Timestamp departureTime = Timestamp.valueOf(time);

            int adults = (Integer) session.getAttribute("numAdultsForReturn");
            int children = (Integer)  session.getAttribute("numChildrenForReturn");
            if (adults < 0 || children < 0 || (adults == 0 && children == 0)) {
                throw new IOException("Invalid input: Invalid combination of adult and children passengers.");
            }
            if (destination == null) {
                throw new IOException("Invalid input: Select a destination.");
            }
            if (departure == null) {
                throw new IOException("Invalid input: Select a departure location.");
            }
            if (departure.equals(destination)) {
                throw new IOException("Invalid input: Cannot leave from and arrive at the same destination.");
            }

            System.out.println(departure);
            System.out.println(destination);
            System.out.println("FlightSearchServlet.simpleReturnSearchResults.departureTime " + departureTime);
            System.out.println("adults: " + adults);
            System.out.println("children: " + children);

            SearchBean search = new SearchBean(departureTime, destination, departure, null, true, 0, adults, children);
            search.searchFlights();

            LinkedList<FlightPathBean> searchResults = search.getResults();
            System.out.println(searchResults.size());

            session.setAttribute("returnFlightResults", search);
            session.setAttribute("viewReturnFlightSearchResults", Boolean.TRUE);
            session.setAttribute("viewReturnFlightDetails", Boolean.FALSE);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(request, response);
        }

    }
}
