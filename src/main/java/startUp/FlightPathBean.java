package startUp;

import java.util.Queue;

public class FlightPathBean {
    private Queue<FlightBean> flightPath;
    private FlightBean lastFlight;

    public FlightBean getLastFlight() {
        return lastFlight;
    }

    public void setLastFlight(FlightBean lastFlight) {
        this.lastFlight = lastFlight;
    }

    public Queue<FlightBean> getFlightPath() {
        return flightPath;
    }

    public void setFlightPath(Queue<FlightBean> flightPath) {
        this.flightPath = flightPath;
    }
}
