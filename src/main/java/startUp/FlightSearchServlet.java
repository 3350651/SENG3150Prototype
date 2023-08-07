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
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Instant;
import java.util.LinkedList;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

@WebServlet(urlPatterns = { "/flightSearch" })
public class FlightSearchServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (request.getParameter("home").equalsIgnoreCase("recommendSearch")) {

            SearchBean search = new SearchBean(null, null, null, null, false, 0, 0, 0);

            session.setAttribute("flightResults", search);
            request.setAttribute("goToRecommend", true);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-RecommendedSearch.jsp");
            requestDispatcher.forward(request, response);
        } else {
            request.setAttribute("goToSimple", true);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
            requestDispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserBean user = (UserBean) session.getAttribute("userBean");
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

            SearchBean search = new SearchBean(departureTime, destination, departure, null, true, 0, adults, children);
            search.searchFlights();
            session.setAttribute("flightResults", search);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/simpleSearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("viewFlight") != null) {
            LinkedList<FlightPathBean> flights = (LinkedList<FlightPathBean>) session.getAttribute("flightResults");

            FlightPathBean flight = flights.get(Integer.parseInt(request.getParameter("flightIndex")));

            session.setAttribute("flight", flight);
            /* TODO: No longer valid
            String flightDetails = flight.getAirline() + "," + flight.getFlightName() + ","
                    + flight.getFlightTime();
            session.setAttribute("flightDetails", flightDetails);*/

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(request, response);
        }
        else if(request.getParameter("saveParam") != null){
            String id = request.getParameter("userID"); // do this for all others as hidden form input
            String departureLocation = request.getParameter("departureLocation");
            String arrivalLocation = request.getParameter("arrivalLocation");
            String numberOfAdults = request.getParameter("numberOfAdults");
            int adultPassengers, childPassengers, flexibleAmountOfDays;
            if (numberOfAdults.equals("")){
                adultPassengers = 0;
            }
            else{
                adultPassengers = Integer.parseInt(numberOfAdults);
            }
            String numberOfChildren = request.getParameter("numberOfChildren");
            if (numberOfChildren.equals("")){
                childPassengers = 0;
            }
            else{
                childPassengers = Integer.parseInt(numberOfChildren);
            }
            String flexibleDays = request.getParameter("flexibleDays");
            if (flexibleDays.equals("")){
                flexibleAmountOfDays = 0;
            }
            else{
                flexibleAmountOfDays = Integer.parseInt(flexibleDays);
            }
            LocalDate departureDate = LocalDate.parse(request.getParameter("departureDate"));

            Timestamp departureTime = Timestamp.valueOf(departureDate.atTime(LocalTime.MIDNIGHT));
            SearchBean savedSearchParam = new SearchBean();
            savedSearchParam.setDeparture(departureLocation);
            savedSearchParam.setDestination(arrivalLocation);
            savedSearchParam.setAdultPassengers(adultPassengers);
            savedSearchParam.setChildPassengers(childPassengers);
            savedSearchParam.setDepartureDate(departureTime);
            savedSearchParam.setFlexible(flexibleAmountOfDays);
            int searchID = ThreadLocalRandom.current().nextInt(00000000, 99999999);
            savedSearchParam.setSearchID(searchID);
            UserBean.addToSavedSearches(id, searchID, arrivalLocation, departureLocation, flexibleAmountOfDays, adultPassengers, childPassengers, departureTime);

            user.addSavedSearch(savedSearchParam);
            session.setAttribute("userBean", user);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
