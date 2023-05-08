package startUp;

import java.sql.*;

public class AvailabilityBean {

    private String classCode;
    private String ticketCode;
    private String airlineCode;
    private String flightName;
    private Date flightDepartureTime;
    private int seatsAvailable;

    //constructors

    public AvailabilityBean(String newClassCode, String newTicketCode, String newAirlineCode, String newFlightName, Date newFlightDepartureTime, int newSeatsAvailable){
        classCode = newClassCode;
        ticketCode = newTicketCode;
        airlineCode = newAirlineCode;
        flightName = newFlightName;
        flightDepartureTime = newFlightDepartureTime;
        seatsAvailable = newSeatsAvailable;
    }



    //getters and setters
    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public String getAirlineCode() {
        return airlineCode;
    }

    public void setAirlineCode(String airlineCode) {
        this.airlineCode = airlineCode;
    }

    public String getFlightName() {
        return flightName;
    }

    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    public Date getFlightDepartureTime() {
        return flightDepartureTime;
    }

    public void setFlightDepartureTime(Date flightDepartureTime) {
        this.flightDepartureTime = flightDepartureTime;
    }

    public int getSeatsAvailable() {
        return seatsAvailable;
    }

    public void setSeatsAvailable(int seatsAvailable) {
        this.seatsAvailable = seatsAvailable;
    }

    //get availability
    public AvailabilityBean getAvailability(String classCode, String ticketCode, String airlineCode, String flightName, Date flightDepartureTime, boolean secondLeg){

        int available = 0;

        try {
            String query = "SELECT * FROM Availability WHERE AirlineCode = ? AND FlightNumber = ? AND Departure Time = '?' AND  ClassCode = ? AND TicketCode = ?";
            Connection connection = ConfigBean.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, airlineCode);
            statement.setString(1, flightName);
            statement.setString(1, flightDepartureTime.toString());
            statement.setString(1, classCode);
            statement.setString(1, ticketCode);

            ResultSet result = statement.executeQuery();

            //TODO:Possibly won't work?
            while(result.next()){

                if(secondLeg)
                    available = result.getInt(7);
                else
                    available = result.getInt(6);
            }

            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println(e.getStackTrace());
        }
        return new AvailabilityBean(classCode, ticketCode, airlineCode, flightName, flightDepartureTime, available);
    }

    //update availability



    //remove availability

    //add availability

}
