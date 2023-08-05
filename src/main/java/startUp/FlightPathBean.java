package startUp;

import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;

public class FlightPathBean {
    private Stack<FlightBean> flightPath;
    private LinkedList<String> destinations;

    public FlightPathBean() {
        flightPath = new Stack<>();
        destinations = new LinkedList<>();
    }

    public FlightPathBean(Stack<FlightBean> flights) {
        flightPath = flights;
        destinations = new LinkedList<>();
        for (FlightBean flight : flights) {
            destinations.add(flight.getDeparture().getDestinationCode());
        }
    }


    public Stack<FlightBean> getFlightPath() {
        return flightPath;
    }

    public void setFlightPath(Stack<FlightBean> flightPath) {
        this.flightPath = flightPath;
    }


    public LinkedList<String> getDestinations() {
        return destinations;
    }

    public void setDestinations(LinkedList<String> destinations) {
        this.destinations = destinations;
    }

    public boolean isLoopingDestination(FlightBean flight) {
        if (this.destinations.contains(flight.getDestination().getDestinationCode())) {
            return true;
        } else {
            return false;
        }
    }

    public String getAllDestinations() {
        String allDestinations = "";
        String temp = "";
        for (int i = destinations.size() - 1; i >= 0; i--) {
            temp = destinations.get(i);
            if (i == 0)
                allDestinations += "\'" + temp + "\'";
            else
                allDestinations += "\'" + temp + "\'" + ", ";
        }
        return allDestinations;
    }

    public FlightBean getInitialFlight() {
        return flightPath.get(0);
    }

    public FlightBean getLastFlight() {
        return flightPath.get(flightPath.size() - 1);
    }
}
