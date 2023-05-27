package startUp;

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
        des.getAllDestinations();

        LinkedList<DestinationBean> dest = des.getDestinations();
        session.setAttribute("destinationList", dest);
        recSearchBean recs = new recSearchBean();

        if (session.getAttribute("userBean") != null)
        {
            System.out.println("User not null");
            UserBean user = (UserBean) session.getAttribute("userBean");
            //recs.getRecommendedFlights(user);
            recs.getpresetFlights();

            session.setAttribute("recFlights", recs);
        }
        else if (session.getAttribute("userBean") == null)
        {
            System.out.println("User is null");
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/recHome.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (request.getParameter("searchResults") != null) {
            recSearchBean search = new recSearchBean();
            //search.getResults(request.getParameter("destination"), request.getParameter("departure"));
            search.getpresetFlights();
            session.setAttribute("flightResults", search);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/recSearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        if (request.getParameter("gotoSimple") != null)
        {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Homepage-SimpleSearch.jsp");
            requestDispatcher.forward(request, response);
        }

    }
}
