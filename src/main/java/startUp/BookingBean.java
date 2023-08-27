/**
 * FILE NAME: BookingBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model Object to hold data pertaining to bookings for customers
 */

package startUp;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.Random;
import java.util.Stack;

public class BookingBean implements Serializable {

    private String bookingId;
    private String bookingUserId;
    private FlightBean departureFlight;
    private FlightBean returnFlight;
    private int departureFlightPathID;
    private int returnFlightPathID;
    private FlightPathBean departureFlightPath;
    private FlightPathBean returnFlightPath;
    private LinkedList<TicketBean> tickets;
    private LinkedList<PassengerBean> passengers;
    private LinkedList<PassengerBean> returnPassengers;
    private float totalAmount;
    private boolean progress;

    // constructors

    public BookingBean(String bookingId, String bookingUserId, FlightBean departureFlight, FlightBean returnFlight,
                       LinkedList<TicketBean> tickets, LinkedList<PassengerBean> passengers, float totalAmount, boolean progress) {
        this.bookingId = bookingId;
        this.bookingUserId = bookingUserId;
        this.departureFlight = departureFlight;
        this.returnFlight = returnFlight;
        this.tickets = tickets;
        this.passengers = passengers;
        this.totalAmount = totalAmount;
        this.progress = progress;
    }

    public BookingBean(String bookingId, String bookingUserId, FlightPathBean flightD, FlightPathBean flightR,
                       LinkedList<TicketBean> tickets, LinkedList<PassengerBean> passengers, float totalAmount, boolean progress) {
        this.bookingId = bookingId;
        this.bookingUserId = bookingUserId;
        this.departureFlightPath = flightD;
        this.returnFlightPath = flightR;
        this.tickets = tickets;
        this.passengers = passengers;
        this.totalAmount = totalAmount;
        this.progress = progress;
    }

    public BookingBean(String newBookingUserId, FlightPathBean departFlight, FlightPathBean rflight) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlightPath = departFlight;
        returnFlightPath = rflight;
        tickets = null;
        passengers = null;
    }

    public BookingBean(String newBookingUserId, FlightPathBean flightd, FlightPathBean flightR, float newTotalAmount) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlightPath = flightd;
        returnFlightPath = flightR;
        totalAmount = newTotalAmount;
        tickets = null;
        passengers = null;
    }

    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, float newTotalAmount) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = null;
        tickets = null;
        passengers = null;
    }

    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, FlightBean newReturnFlight,
            float newTotalAmount) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        totalAmount = newTotalAmount;
        returnFlight = newReturnFlight;
        tickets = null;
        passengers = null;
    }

    public BookingBean(String newBookingUserId, FlightBean newDepartureFlight, FlightBean newReturnFlight) {
        Random random = new Random();
        bookingId = String.format("%08d", random.nextInt(100000000));
        bookingUserId = newBookingUserId;
        departureFlight = newDepartureFlight;
        returnFlight = newReturnFlight;
        tickets = null;
        passengers = null;
    }

    // getters and setters

    public void setReturnPassengers(LinkedList<PassengerBean> a) {
        returnPassengers = a;
    }

    public LinkedList<PassengerBean> getReturnPassengers() {
        return returnPassengers;
    }

    public void setDepartureFlightPath(FlightPathBean departureFlightPath) {
        this.departureFlightPath = departureFlightPath;
    }

    public FlightPathBean getDepartureFlightPath() {
        return departureFlightPath;
    }

    public void setReturnFlightPath(FlightPathBean returnFlightPath) {
        this.returnFlightPath = returnFlightPath;
    }

    public FlightPathBean getReturnFlightPath() {
        return returnFlightPath;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getBookingUserId() {
        return bookingUserId;
    }

    public void setBookingUserId(String bookingUserId) {
        this.bookingUserId = bookingUserId;
    }

    public FlightBean getDepartureFlight() {
        return departureFlight;
    }

    public void setDepartureFlight(FlightBean departureFlight) {
        this.departureFlight = departureFlight;
    }

    public FlightBean getReturnFlight() {
        return returnFlight;
    }

    public void setReturnFlight(FlightBean returnFlight) {
        this.returnFlight = returnFlight;
    }

    public LinkedList<TicketBean> getTickets() {
        return tickets;
    }

    public void setTickets(LinkedList<TicketBean> tickets) {
        this.tickets = tickets;
    }

    public LinkedList<PassengerBean> getPassengers() {
        return passengers;
    }

    public void setPassengers(LinkedList<PassengerBean> passengers) {
        this.passengers = passengers;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    // add booking to database
    // TODO: Add ability to add with return flight if not null.
    public void addBooking() {
        if (returnFlightPath != null) {
            try {
                String query = "INSERT INTO dbo.BOOKINGS (BookingId, BookingUserId, ReturnTime, TotalAmount, Progress, DepartureFlightPathId, ReturnFlightPathId)\n"
                        +
                        "VALUES(?,?,?,?,?,?,?);";
                Connection connection = ConfigBean.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, this.bookingId);
                statement.setString(2, this.bookingUserId);
                statement.setString(3, String.valueOf(this.returnFlightPath.getLastFlight().getFlightTime()));
                statement.setString(4, String.valueOf(this.totalAmount));
                statement.setBoolean(5, true);
                statement.setString(6, String.valueOf(this.departureFlightPath.getId()));
                statement.setString(7, String.valueOf(this.returnFlightPath.getId()));
                statement.execute();
                statement.close();
                connection.close();

            } catch (SQLException e) {
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
        } else {
            try {
                String query = "INSERT INTO dbo.BOOKINGS (BookingId, BookingUserId, ReturnTime, TotalAmount, Progress, DepartureFlightPathId, ReturnFlightPathId)\n"
                        +
                        "VALUES(?,?,?,?,?,?,?);";
                Connection connection = ConfigBean.getConnection();
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, this.bookingId);
                statement.setString(2, this.bookingUserId);
                statement.setString(3, null);
                statement.setString(4, String.valueOf(this.totalAmount));
                statement.setBoolean(5, true);
                statement.setString(6, String.valueOf(this.departureFlightPath.getId()));
                statement.setString(7, null);
                statement.execute();
                statement.close();
                connection.close();

            } catch (SQLException e) {
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
        }


    }

    //change progress bit of booking to false
    public void finalise() {
        try {
            String query = "UPDATE BOOKINGS SET Progress = 0 WHERE BookingId = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, this.bookingId);
            statement.execute();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        // decrease availability value on database
        if (returnPassengers != null) {
            try {
                for (PassengerBean passenger : passengers) {
                    System.out.println(passenger.getDepartureTickets().size());
                    for (TicketBean ticket : passenger.getDepartureTickets()) {
                        String flightNumber = ticket.getFlightId();
                        Timestamp depTime = ticket.getFlightTime();
                        String depCode = ticket.getDepCode();
                        System.out.println("Depart at: " + ticket.getDepCode());

                        String query = "SELECT DepartureCode FROM Flights WHERE FlightNumber = ? AND DepartureTime = ?";
                        Connection connection = ConfigBean.getConnection();
                        PreparedStatement statement = connection.prepareStatement(query);
                        statement.setString(1, flightNumber);
                        statement.setTimestamp(2, depTime);

                        ResultSet result = statement.executeQuery();

                        String query1 = "";
                        String DB_DepCode = "";
                        while (result.next()) {
                            DB_DepCode = result.getString("DepartureCode");
                        }

                        statement.close();
                        connection.close();

                        if (depCode.equals(DB_DepCode)) {
                            System.out.println("NumberAvailableSeatsLeg1");
                            query1 = "UPDATE Availability \n" +
                                    "SET NumberAvailableSeatsLeg1 = NumberAvailableSeatsLeg1 - 1 \n" +
                                    "WHERE FlightNumber = ? AND DepartureTime = ? AND ClassCode = ? AND TicketCode = ?";
                        } else {
                            System.out.println("NumberAvailableSeatsLeg2");
                            query1 = "UPDATE Availability \n" +
                                    "SET NumberAvailableSeatsLeg2 = NumberAvailableSeatsLeg2 - 1 \n" +
                                    "WHERE FlightNumber = ? AND DepartureTime = ? AND ClassCode = ? AND TicketCode = ?";
                        }

                        Connection connection1 = ConfigBean.getConnection();
                        PreparedStatement statement1 = connection1.prepareStatement(query1);
                        statement1.setString(1, flightNumber);
                        statement1.setTimestamp(2, depTime);
                        statement1.setString(3, ticket.getTicketClass());
                        statement1.setString(4, ticket.getTicketType());
                        boolean check = statement1.execute();
                        System.out.println(check);

                        statement1.close();
                        connection1.close();
                    }

                }
                for (PassengerBean passenger : returnPassengers) {
                    System.out.println(passenger.getReturnTickets().size());
                    for (TicketBean ticket : passenger.getReturnTickets()) {
                        String flightNumber = ticket.getFlightId();
                        Timestamp depTime = ticket.getFlightTime();
                        String depCode = ticket.getDepCode();
                        System.out.println("Depart at: " + ticket.getDepCode());

                        String query = "SELECT DepartureCode FROM Flights WHERE FlightNumber = ? AND DepartureTime = ?";
                        Connection connection = ConfigBean.getConnection();
                        PreparedStatement statement = connection.prepareStatement(query);
                        statement.setString(1, flightNumber);
                        statement.setTimestamp(2, depTime);

                        ResultSet result = statement.executeQuery();

                        String query1 = "";
                        String DB_DepCode = "";
                        while (result.next()) {
                            DB_DepCode = result.getString("DepartureCode");
                        }

                        statement.close();
                        connection.close();

                        if (depCode.equals(DB_DepCode)) {
                            System.out.println("NumberAvailableSeatsLeg1");
                            query1 = "UPDATE Availability \n" +
                                    "SET NumberAvailableSeatsLeg1 = NumberAvailableSeatsLeg1 - 1 \n" +
                                    "WHERE FlightNumber = ? AND DepartureTime = ? AND ClassCode = ? AND TicketCode = ?";
                        } else {
                            System.out.println("NumberAvailableSeatsLeg2");
                            query1 = "UPDATE Availability \n" +
                                    "SET NumberAvailableSeatsLeg2 = NumberAvailableSeatsLeg2 - 1 \n" +
                                    "WHERE FlightNumber = ? AND DepartureTime = ? AND ClassCode = ? AND TicketCode = ?";
                        }

                        Connection connection1 = ConfigBean.getConnection();
                        PreparedStatement statement1 = connection1.prepareStatement(query1);
                        statement1.setString(1, flightNumber);
                        statement1.setTimestamp(2, depTime);
                        statement1.setString(3, ticket.getTicketClass());
                        statement1.setString(4, ticket.getTicketType());
                        boolean check = statement1.execute();
                        System.out.println(check);

                        statement1.close();
                        connection1.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
        }else {
            try {
                for (PassengerBean passenger : passengers) {
                    System.out.println(passenger.getDepartureTickets().size());
                    for (TicketBean ticket : passenger.getDepartureTickets()) {
                        String flightNumber = ticket.getFlightId();
                        Timestamp depTime = ticket.getFlightTime();
                        String depCode = ticket.getDepCode();
                        System.out.println("Depart at: " + ticket.getDepCode());

                        String query = "SELECT DepartureCode FROM Flights WHERE FlightNumber = ? AND DepartureTime = ?";
                        Connection connection = ConfigBean.getConnection();
                        PreparedStatement statement = connection.prepareStatement(query);
                        statement.setString(1, flightNumber);
                        statement.setTimestamp(2, depTime);

                        ResultSet result = statement.executeQuery();

                        String query1 = "";
                        String DB_DepCode = "";
                        while (result.next()) {
                            DB_DepCode = result.getString("DepartureCode");
                        }

                        statement.close();
                        connection.close();

                        if (depCode.equals(DB_DepCode)) {
                            System.out.println("NumberAvailableSeatsLeg1");
                            query1 = "UPDATE Availability \n" +
                                    "SET NumberAvailableSeatsLeg1 = NumberAvailableSeatsLeg1 - 1 \n" +
                                    "WHERE FlightNumber = ? AND DepartureTime = ? AND ClassCode = ? AND TicketCode = ?";
                        } else {
                            System.out.println("NumberAvailableSeatsLeg2");
                            query1 = "UPDATE Availability \n" +
                                    "SET NumberAvailableSeatsLeg2 = NumberAvailableSeatsLeg2 - 1 \n" +
                                    "WHERE FlightNumber = ? AND DepartureTime = ? AND ClassCode = ? AND TicketCode = ?";
                        }

                        Connection connection1 = ConfigBean.getConnection();
                        PreparedStatement statement1 = connection1.prepareStatement(query1);
                        statement1.setString(1, flightNumber);
                        statement1.setTimestamp(2, depTime);
                        statement1.setString(3, ticket.getTicketClass());
                        statement1.setString(4, ticket.getTicketType());
                        boolean check = statement1.execute();
                        System.out.println(check);

                        statement1.close();
                        connection1.close();
                    }
                }
            } catch (SQLException e) {
                System.err.println(e.getMessage());
                System.err.println(e.getStackTrace());
            }
        }
    }

    //get all bookings related to user
    public static LinkedList<BookingBean> getUserBookings(String userId){
        LinkedList<BookingBean> bookings = new LinkedList<>();

        try {
            String query = "SELECT * from dbo.BOOKINGS WHERE BookingUserId = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, userId);
            ResultSet results =  statement.executeQuery();


            BookingBean booking = null;

            while(results.next()) {
                String bookingId = results.getString(1);
                String bookingUserId = results.getString(2);

                if (results.getString(3) != null) {
                    Timestamp returnTime = Timestamp.valueOf(results.getString(3));
                }

                float totalAmount = Float.valueOf(results.getString(4));
                boolean progress = results.getBoolean(5);
                String departureFlightPathID = results.getString(6);
                String returnFlightPathID = results.getString(7);

                //getDepartureFlight
                FlightPathBean forgetting = new FlightPathBean();
                FlightPathBean departure = forgetting.getFlightPath(departureFlightPathID);

                //getReturnFlight
                FlightPathBean forgetting2 = new FlightPathBean();
                FlightPathBean returnFl = forgetting2.getFlightPath(returnFlightPathID);

                //get passengers from this booking
                query = "SELECT * FROM PASSENGERS WHERE BookingId = ?";
                statement = connection.prepareStatement(query);
                statement.setString(1, bookingId);
                ResultSet passengerResults = statement.executeQuery();
                LinkedList<PassengerBean> passengers = new LinkedList<>();

                while(passengerResults.next()){
                    String passengerId = passengerResults.getString(1);
                    String lName = passengerResults.getString(2);
                    String fName = passengerResults.getString(3);
                    String email = passengerResults.getString(4);
                    String mobile = passengerResults.getString(5);
                    Timestamp DOB = passengerResults.getTimestamp(6);
                    String passengerBookingId = passengerResults.getString(7);
                    passengers.add(new PassengerBean(lName, fName, email, mobile, DOB, passengerBookingId));
                }

                //get tickets from this booking
                query = "SELECT * FROM TICKETS WHERE BookingId = ?";
                statement = connection.prepareStatement(query);
                statement.setString(1, bookingId);
                ResultSet ticketResults = statement.executeQuery();
                LinkedList<TicketBean> tickets = new LinkedList<>();
                while(ticketResults.next()){
                    String ticketId = ticketResults.getString(1);
                    String ticketBookingId = ticketResults.getString(2);
                    String ticketPassengerId = ticketResults.getString(3);
                    String ticketAirlineCode = ticketResults.getString(4);
                    String ticketFlightNumber = ticketResults.getString(5);
                    Timestamp ticketDepartureTime = ticketResults.getTimestamp(6);
                    String ticketClass = ticketResults.getString(7);
                    String ticketType = ticketResults.getString(8);
                    tickets.add(new TicketBean(ticketBookingId, ticketPassengerId, ticketFlightNumber, ticketAirlineCode, ticketDepartureTime, ticketClass, ticketType));
                }

                bookings.add(new BookingBean(bookingId, bookingUserId, departure, returnFl, tickets, passengers, totalAmount, progress));

            }
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }

        return bookings;
    }

    public void updatePrice(String bookingId, float price) {
        this.totalAmount = price;
        try {
            String query = "UPDATE BOOKINGS SET TotalAmount = ? WHERE BookingId = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, String.valueOf(price));
            statement.setString(2, bookingId);
            statement.execute();
            statement.close();
            connection.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    // save Booking Progress

    // get booking

    // update booking

    // remove booking

}
