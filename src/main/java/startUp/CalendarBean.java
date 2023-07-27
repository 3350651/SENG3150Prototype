/**
 * FILE NAME: CalendarBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Model Object to hold data pertaining to calendar availabilities for group members.
 */

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
