package startUp;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.LinkedList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;



@WebServlet(urlPatterns = { "/recSearch" })
public class recSearch extends HttpServlet
{
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        DestinationBean des = new DestinationBean();
        //des.getAllDestinations();

        //LinkedList<DestinationBean> dest = des.getDestinations();
        //session.setAttribute("destinationList", dest);
        recSearchBean recs = new recSearchBean();

            // System.out.println("User not null");
            UserBean user = (UserBean) session.getAttribute("userBean");
            //recs.getRecommendedFlights(user);
            recs.getAllFlights();
            session.setAttribute("recFlights", recs);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/recHome.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (request.getParameter("searchResults") != null) {
            recSearchBean search = new recSearchBean();
            //search.getResults(request.getParameter("destination"), request.getParameter("departure"));
            search.getAllFlights();
            session.setAttribute("flightResults", search);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/recSearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("gotoSimple") != null) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
            requestDispatcher.forward(request, response);
        }

        else if (request.getParameter("viewFlight") != null)
        {
            String d = request.getParameter("destination");
            DestinationBean destination = new DestinationBean(d, "");
            String dep = request.getParameter("departure");
            DestinationBean departure = new DestinationBean(dep, "");
            String ftime = request.getParameter("flightTime");

            Timestamp timestamp = Timestamp.valueOf(ftime);

            String airline = request.getParameter("AirlineName");
            String flightname = request.getParameter("FlightName");
            String planeType = request.getParameter("PlaneType");

            FlightBean flight = new FlightBean(flightname.substring(0, 2), airline, timestamp, flightname, planeType, departure, destination, destination); 
            
            session.setAttribute("flight", flight);
            String flightDetails = flight.getAirline() + "," + flight.getFlightName() + ","
                    + flight.getFlightTime();
            session.setAttribute("flightDetails", flightDetails);

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(request, response);
        }

    }
}
