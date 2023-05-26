package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.LinkedList;

@WebServlet(urlPatterns = { "/flightSearch" })
public class FlightSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        DestinationBean des = new DestinationBean();
        des.getAllDestinations();

        LinkedList<DestinationBean> dest = des.getDestinations();
        session.setAttribute("destinationList", dest);
        recSearchBean recs = new recSearchBean();

        recs.getpresetFlights();
        session.setAttribute("flightResults",recs);

        /*SearchBean search = new SearchBean(null, "Atlanta", "Rio De Janeiro", null, false, 0, 0, 0);
        //search.getInitialFlight();
        HttpSession session = req.getSession();
        session.setAttribute("results", search);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/FlightSearchResultsPage.jsp");
        requestDispatcher.forward(req, resp);*/
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/simpleSearchResults.jsp");
        requestDispatcher.forward(req, resp);
    }
}
