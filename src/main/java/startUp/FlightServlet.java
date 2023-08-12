/**
 * FILE NAME: FlightServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for obtaining a flight
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
import java.util.LinkedList;

@WebServlet(urlPatterns = { "/flight" })
public class FlightServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        if (req.getParameter("viewFlightDetails") != null) {

            // getting parameters
            SearchBean search = (SearchBean) session.getAttribute("results");
            LinkedList<FlightPathBean> flights = search.getResults();
            int index = Integer.valueOf(req.getParameter("viewFlightDetails").split(",")[1]);

            // retrieve flight
            FlightPathBean flight = flights.get(index);

            session.setAttribute("flight", flight);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(req, resp);
        } else if (req.getParameter("returnSearch") != null) {
            FlightBean flight = (FlightBean) session.getAttribute("flight");
            // TODO: search the database using the captured parameters
            // req.getParameter("returnDate");
            LinkedList<FlightBean> returnFlights = new LinkedList<>(); // TODO: return result here
            req.setAttribute("returnFlights", returnFlights);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(req, resp);
        }

    }
}
