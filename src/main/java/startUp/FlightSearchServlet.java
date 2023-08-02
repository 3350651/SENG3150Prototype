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
            SearchBean search = new SearchBean(null, null, null, null, true, 0, 0, 0);
            session.setAttribute("flightResults", search);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/simpleSearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("viewFlight") != null) {
            String airline = request.getParameter("airline");
            String flightname = request.getParameter("flightName");
            Timestamp flightTime = Timestamp.valueOf(request.getParameter("flightTime"));

            FlightBean flight = FlightBean.getFlight(airline, flightname, flightTime);

            session.setAttribute("flight", flight);
            String flightDetails = flight.getAirline() + "," + flight.getFlightName() + ","
                    + flight.getFlightTime();
            session.setAttribute("flightDetails", flightDetails);

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(request, response);
        }

    }
}
