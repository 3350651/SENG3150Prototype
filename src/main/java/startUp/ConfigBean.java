package startUp;

import javax.sql.*;
import javax.naming.*;
import java.sql.*;

/**
 * The webapp.ConfigBean which establishes the connection to the database
 * @author Jordan Eade c3350651
 * @author Lucy Knight c3350691
 * @author Ahmed Al-khazraji c3277545
 * @author Jason Walls c3298757
 */
public class ConfigBean {
    private static final DataSource dataSource = makeDataSource();
    private static DataSource makeDataSource(){
        try{
             InitialContext ctx = new InitialContext();
             return (DataSource) ctx.lookup("java:comp/env/jdbc/flightPub");
        }
        catch (NamingException e){
           throw new RuntimeException(e);
        }
    }

    public static Connection getConnection() throws SQLException{
        return dataSource.getConnection();
    }
 }
