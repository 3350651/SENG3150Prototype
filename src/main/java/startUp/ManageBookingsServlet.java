/**
 * FILE NAME: ManageBookingsServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for managing bookings being made
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

@WebServlet(urlPatterns = { "/manageBookings" })
public class ManageBookingsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // view bookings page
        HttpSession session = req.getSession();
        UserBean user = (UserBean) session.getAttribute("userBean");

        LinkedList<BookingBean> bookings = BookingBean.getUserBookings(user.getUserID());   //get all user bookings

        session.setAttribute("userBookings", bookings);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("WEB-INF/jsp/ViewBookingsPage.jsp");
        requestDispatcher.forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // view booking page
        HttpSession session = req.getSession();

        LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("userBookings");
        System.out.println(req.getParameter("bookingButton"));

        int index = Integer.valueOf(req.getParameter("bookingButton"));
        BookingBean booking = bookings.get(index);


        session.setAttribute("currentBooking", booking);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("WEB-INF/jsp/ViewBookingPage.jsp");
        requestDispatcher.forward(req, resp);
    }
}
