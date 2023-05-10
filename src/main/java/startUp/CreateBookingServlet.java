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

@WebServlet(urlPatterns = {"/createBooking"})
public class CreateBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        if(req.getParameter("details") != null){

        UserBean user = (UserBean) session.getAttribute("userBean");

        FlightBean flight = (FlightBean) session.getAttribute("Flight");
        flight.getAvailabilities();
        session.setAttribute("Flight", flight);
        //TODO: Get return flight information here
        //TODO: Get some booking information e.g. Number of guests
        BookingBean booking = new BookingBean(user.getUserID(), flight, null);
        session.setAttribute("booking", booking);
        booking.addBooking();
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/FlightOptionsPage.jsp");
        requestDispatcher.forward(req,resp);
        }
        else if(req.getParameter("options") != null){
            //TODO: needs to be a class selection for each passenger in each flight
            String departureClass = req.getParameter("departureClass");

        }
    }
}
