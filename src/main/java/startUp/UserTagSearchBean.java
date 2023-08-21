package startUp;

import java.util.LinkedList;

public class UserTagSearchBean {

    private String tagName;
    private LinkedList<DestinationBean> destinations;

    public UserTagSearchBean(String tagName, LinkedList<DestinationBean> destinations) {
        this.tagName = tagName;
        this.destinations = destinations;
    }

    public LinkedList<DestinationBean> getDestinations() {
        return destinations;
    }

    public String getTagName() {
        return tagName;
    }

    public void setDestinations(LinkedList<DestinationBean> destinations) {
        this.destinations = destinations;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }
}
