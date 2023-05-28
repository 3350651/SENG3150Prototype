package startUp;

import java.io.Serializable;
import java.sql.Timestamp;

public class CalendarBean implements Serializable {
    private String calendarID;
    private Timestamp startDate;
    private Timestamp endDate;
    private String userID;
    private String groupID;

    public CalendarBean(){}

    public String getCalendarID() {
        return calendarID;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void addCalendarToDB() {

    }
}
