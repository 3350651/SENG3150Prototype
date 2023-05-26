package startUp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.LinkedList;

public class tagSet
{
    public tagSet()
    {}

    public void setDestinationTag(DestinationBean a)
    {
        if (a.getDestinationCode().contains("MEL"))
        {
            LinkedList<String> tags = new LinkedList<>();

            tags.add("Hot");
            tags.add("Windy");
            a.setTags(tags);
        }
    }
}
