package startUp;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.LinkedList;

public class SearchBean implements Serializable{
    
    Timestamp departureDate;
    String destination;
    String departure;
    LinkedList<TagBean> tags;
    boolean simple;
    int flexible;
    int adultPassengers;
    int childPassengers;
    LinkedList<FlightBean> results;
    //TODO: may need more for recommendation search



    


}
