package startUp;

import java.util.LinkedList;
import java.util.Queue;
import java.util.Stack;
import java.util.concurrent.ThreadLocalRandom;

public class FlightPathBean {
    private Stack<FlightBean> flightPath;
    private LinkedList<String> destinations;
    private int id;
    private float minPrice;

    public FlightPathBean() {
        flightPath = new Stack<>();
        destinations = new LinkedList<>();
        id = ThreadLocalRandom.current().nextInt(10000000, 99999999);
        minPrice = 0;
    }

    public FlightPathBean(Stack<FlightBean> flights) {
        flightPath = flights;
        destinations = new LinkedList<>();
        minPrice = 0;
        for (FlightBean flight : flights) {
            destinations.add(flight.getDeparture().getDestinationCode());
            minPrice += flight.getMinCost();
        }
        id = ThreadLocalRandom.current().nextInt(00000000, 99999999);
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(float minPrice) {
        this.minPrice = minPrice;
    }

    public int getFlightPathStopOvers() {
        return this.flightPath.size() - 1;
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
        return flightPath.get(flightPath.size() - 1);
    }

    public FlightBean getLastFlight() {
        return flightPath.get(0);
    }
}
