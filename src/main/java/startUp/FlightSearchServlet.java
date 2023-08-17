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
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
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

            if (request.getParameter("selectedTags") != null) {
                //TODO: selected tags search here
                String[] selectedTags = request.getParameterValues("tags");
                LinkedList<DestinationBean> matchingDestinations = DestinationBean.getDestinationsWith(selectedTags, selectedTags.length);
                int requiredMatching = selectedTags.length - 1;
                while (requiredMatching > 0) {
                    LinkedList<DestinationBean> almostMatchingDestinations = DestinationBean.getDestinationsWith(selectedTags, requiredMatching);
                    if (almostMatchingDestinations.size() >= 3) {
                        session.setAttribute("almostMatchingDestinations", almostMatchingDestinations);
                        break;
                    } else {
                        requiredMatching--;
                    }
                }
                session.setAttribute("matchingDestinations", matchingDestinations);
                session.setAttribute("isDestinations", "true");
            } else if (request.getParameter("randomDestination") != null) {
                //TODO: random destination search here
                DestinationBean leaving = new DestinationBean(request.getParameter("departure"));
                Timestamp time = Timestamp.valueOf("2014-09-23 00:15:00.000");
                int passengers = 1;
                //if date is not included in the request or is empty, assign a date a random set of months from the beginning of all records
                if (request.getParameter("date") == null || request.getParameter("date").equalsIgnoreCase("")) {
                    Random rand = new Random();
                    time = Timestamp.from(time.toInstant().plus(rand.nextInt(365), ChronoUnit.DAYS));
                } else {
                    time = Timestamp.valueOf(request.getParameter("date"));
                }
                int adults = 1;
                int children = 0;
                if (request.getParameter("numberOfAdults") != null && !request.getParameter("numberOfAdults").equalsIgnoreCase("")) {
                    adults = Integer.parseInt(request.getParameter("numberOfAdults"));
                }
                if (request.getParameter("numberOfChildren") != null && !request.getParameter("numberOfChildren").equalsIgnoreCase("")) {
                    children = Integer.parseInt(request.getParameter("numberOfChildren"));
                }
                //search 1 random destination
                DestinationBean randDestination = DestinationBean.getRandomDestination();
                SearchBean search = new SearchBean(time, randDestination.getDestinationCode(), leaving.getDestinationCode(), null, true, 0, adults, children);
                search.searchFlights(3);
                session.setAttribute("flightResults1", search.getResults());

                //search again
                randDestination = DestinationBean.getRandomDestination();
                search = new SearchBean(time, randDestination.getDestinationCode(), leaving.getDestinationCode(), null, true, 0, adults, children);
                search.searchFlights(3);
                session.setAttribute("flightResults2", search.getResults());

                //search again
                randDestination = DestinationBean.getRandomDestination();
                search = new SearchBean(time, randDestination.getDestinationCode(), leaving.getDestinationCode(), null, true, 0, adults, children);
                search.searchFlights(3);
                session.setAttribute("flightResults3", search.getResults());
                session.setAttribute("isFlights", "true");
            } else {
                //TODO: User has no tags edge
                LinkedList<String> tags = user.getTagSet();
                Object[] temp = tags.toArray();
                String[] selectedTags = Arrays.copyOf(temp, temp.length, String[].class);
                LinkedList<DestinationBean> matchingDestinations = DestinationBean.getDestinationsWith(selectedTags, selectedTags.length);
                int requiredMatching = tags.size() - 1;
                while (requiredMatching > 0) {
                    LinkedList<DestinationBean> almostMatchingDestinations = DestinationBean.getDestinationsWith(selectedTags, requiredMatching);
                    if (almostMatchingDestinations.size() >= 3) {
                        session.setAttribute("almostMatchingDestinations", almostMatchingDestinations);
                        break;
                    } else {
                        requiredMatching--;
                    }
                }
                session.setAttribute("matchingDestinations", matchingDestinations);
                session.setAttribute("isDestinations", "true");
            }


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
            if (flexible) {
                flexibleDays = Integer.parseInt(request.getParameter("flexibleDays"));
            }
            int adults = 0;
            int children = 0;
            if (request.getParameter("numberOfAdults") != null && !request.getParameter("numberOfAdults").equalsIgnoreCase("")) {
                adults = Integer.parseInt(request.getParameter("numberOfAdults"));
            }
            if (request.getParameter("numberOfChildren") != null && !request.getParameter("numberOfChildren").equalsIgnoreCase("")) {
                children = Integer.parseInt(request.getParameter("numberOfChildren"));
            }

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

            SearchBean search = new SearchBean(departureTime, destination, departure, null, true, 0, adults, children);
            search.searchFlights(10);
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
            String userID = user.getUserID();
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

            SearchBean savedSearchParam = new SearchBean(departureTime, destination, departure, null, true, 0, adults, children);
            int searchID = ThreadLocalRandom.current().nextInt(00000000, 99999999);
            savedSearchParam.setSearchID(searchID);
            UserBean.addToSavedSearches(userID, savedSearchParam);
            user.addSavedSearch(savedSearchParam);
            session.setAttribute("userBean", user);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-Index.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
