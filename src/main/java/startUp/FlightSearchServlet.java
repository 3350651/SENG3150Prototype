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
import java.util.Stack;
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
            //session.setAttribute("searchResults", search);
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
            session.removeAttribute("userTags");
            session.removeAttribute("selectedTags");
            session.removeAttribute("isFlights");

            if (request.getParameter("selectedTags") != null) {
                String[] selectedTags = request.getParameterValues("tags");
                if (selectedTags == null) {
                    throw new IOException("Invalid Input: Need to supply at least 1 tag to search by");
                }
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
                session.setAttribute("selectedTags", Arrays.toString(selectedTags));
            } else if (request.getParameter("randomDestination") != null) {
                DestinationBean leaving = new DestinationBean(request.getParameter("departure"));
                Timestamp time = Timestamp.valueOf("2014-09-23 00:15:00.000");
                int passengers = 1;
                //if date is not included in the request or is empty, assign a date a random set of months from the beginning of all records
                if (request.getParameter("date") == null || request.getParameter("date").equalsIgnoreCase("")) {
                    Random rand = new Random();
                    time = Timestamp.from(time.toInstant().plus(rand.nextInt(182), ChronoUnit.DAYS));
                } else {
                    String timeString = request.getParameter("date");
                    timeString += " 00:00:00";
                    time = Timestamp.valueOf(timeString);
                }
                int adults = 1;
                int children = 0;
                if (request.getParameter("numberOfAdults") != null && !request.getParameter("numberOfAdults").equalsIgnoreCase("")) {
                    adults = Integer.parseInt(request.getParameter("numberOfAdults"));
                }
                if (request.getParameter("numberOfChildren") != null && !request.getParameter("numberOfChildren").equalsIgnoreCase("")) {
                    children = Integer.parseInt(request.getParameter("numberOfChildren"));
                }

                if ((adults == 0 && children == 0) || adults < 0 || children < 0) {
                    throw new IOException("Invalid passenger numbers");
                }

                SearchBean search = null;
                DestinationBean randDestination = null;
                String leavingCodes = "'" + leaving.getDestinationCode() + "'";
                randDestination = DestinationBean.getRandomDestination(leavingCodes);
                while ((search == null || search.getResults().size() == 0) && randDestination != null) {
                    //search 1 random destination
                    search = new SearchBean(time, randDestination.getDestinationCode(), leaving.getDestinationCode(), null, true, 0, adults, children);
                    search.searchFlights(2, 4);
                    session.setAttribute("flightResults1", search);
                    leavingCodes += ", '" + randDestination.getDestinationCode() + "'";
                    randDestination = DestinationBean.getRandomDestination(leavingCodes);
                }
                search = null;
                while ((search == null || search.getResults().size() == 0) && randDestination != null) {
                    //search again
                    search = new SearchBean(time, "MEL", leaving.getDestinationCode(), null, true, 0, adults, children);
                    search.searchFlights(2, 4);
                    session.setAttribute("flightResults2", search);
                    leavingCodes += ", '" + randDestination.getDestinationCode() + "'";
                    randDestination = DestinationBean.getRandomDestination(leavingCodes);
                }
                search = null;
                while ((search == null || search.getResults().size() == 0) && randDestination != null) {
                    //search again
                    search = new SearchBean(time, randDestination.getDestinationCode(), leaving.getDestinationCode(), null, true, 0, adults, children);
                    search.searchFlights(2, 4);
                    session.setAttribute("flightResults3", search);
                    leavingCodes += ", '" + randDestination.getDestinationCode() + "'";
                    randDestination = DestinationBean.getRandomDestination(leavingCodes);
                }
                session.setAttribute("isFlights", "true");
            } else {
                LinkedList<String> tags = user.getRandomTags();
                LinkedList<UserTagSearchBean> results = new LinkedList<>();
                for (String tag : tags) {
                    LinkedList<DestinationBean> matchingDestinations = DestinationBean.getNDestinationsWith(new String[]{tag}, 1, 3);

                    results.add(new UserTagSearchBean(tag, matchingDestinations));
                }
                session.setAttribute("userTags", results);
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

            int flexibleDays = Integer.parseInt(request.getParameter("flexibleDays"));

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
            if (flexibleDays < 0) {
                throw new IOException("Invalid input: Provide a number of days that the search should be flexible by");
            }

            SearchBean search = new SearchBean(departureTime, destination, departure, null, true, 0, adults, children);
            search.searchFlights();
            session.setAttribute("flightResults", search);
            session.setAttribute("numAdultsForReturn", adults); //save values on session for return search
            session.setAttribute("numChildrenForReturn", children); //save values on session for return search
            session.setAttribute("flightResults", search);
            SearchBean search = new SearchBean(departureTime, destination, departure, null, true, flexibleDays, adults, children);
            search.searchFlights(10, 5);
            session.setAttribute("searchResults", search);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/simpleSearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("viewFlight") != null) {
            LinkedList<FlightPathBean> flights = null;
            if (request.getParameter("dataStructure") != null) {
                switch (Integer.parseInt(request.getParameter("dataStructure"))) {
                    case 1:
                        SearchBean searchBean1 = (SearchBean) session.getAttribute("flightResults1");
                        flights = searchBean1.getResults();
                        break;

                    case 2:
                        SearchBean searchBean2 = (SearchBean) session.getAttribute("flightResults2");
                        flights = searchBean2.getResults();
                        break;

                    case 3:
                        SearchBean searchBean3 = (SearchBean) session.getAttribute("flightResults3");
                        flights = searchBean3.getResults();
                        break;
                }
            } else {
                flights = (LinkedList<FlightPathBean>) session.getAttribute("flightResults");
            }
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
