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
import java.util.LinkedList;

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

        FlightBean flight = (FlightBean) session.getAttribute("flight");
        flight.getAvailabilities();
        session.setAttribute("flight", flight);     //overwrite the flight attribute
        LinkedList<FlightBean> returnFlights = (LinkedList<FlightBean>) req.getAttribute("returnFlights");
        FlightBean returnFlight = null;
        if(returnFlights != null){
            returnFlight = returnFlights.get(Integer.valueOf(req.getParameter("returnFlight")));
        }
        
        //TODO: Get some booking information e.g. Number of guests
        int passengers = Integer.valueOf(req.getParameter("numPassengers"));

        BookingBean booking = new BookingBean(user.getUserID(), flight, returnFlight);
        session.setAttribute("booking", booking);
        booking.addBooking();   //saving progress of booking
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/WEB-INF/jsp/PassengerDetailsPage.jsp");
        requestDispatcher.forward(req,resp);
        }
        else if(req.getParameter("options") != null){
            

        }
    }
}
