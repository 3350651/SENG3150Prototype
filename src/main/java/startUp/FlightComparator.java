package startUp;

public class FlightComparator implements java.util.Comparator<GroupFaveFlightBean> {

    //Need this class in order to implement the interface.
    @Override
    public int compare(GroupFaveFlightBean o1, GroupFaveFlightBean o2) {
        //Has to return the score of the group fave flight bean.
        double flight1 = o1.getScore();
        double flight2 = o2.getScore();

        return (int) Math.max(flight1, flight2);
    }
}
