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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        FlightBean flight = FlightBean.getFlight("AA", "AA1735", Timestamp
                .valueOf("2014-09-23 09:50:00.000"));
        HttpSession session = req.getSession();
        session.setAttribute("Flight", flight);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
        requestDispatcher.forward(req, resp);

    }
}
