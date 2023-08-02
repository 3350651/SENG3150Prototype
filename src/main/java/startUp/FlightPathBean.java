package startUp;

import java.util.LinkedList;
import java.util.Queue;

public class FlightPathBean {
    private Queue<FlightBean> flightPath;

    public FlightPathBean() {
        flightPath = new LinkedList<>();
    }


    public Queue<FlightBean> getFlightPath() {
        return flightPath;
    }

    public void setFlightPath(Queue<FlightBean> flightPath) {
        this.flightPath = flightPath;
    }

    public void addToFlightPath(FlightBean flight) {
        this.flightPath.add(flight);
    }
}
