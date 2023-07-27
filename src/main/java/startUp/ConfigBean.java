/**
 * FILE NAME: ConfigBean.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Configuration for database connection
 */

package startUp;

import javax.sql.*;
import javax.naming.*;
import java.sql.*;

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
        // TODO: some issue happening here when logging back in after logging out. Occuring when calling getFlight() on the destination code, but only when trying to log back in, logs fine on initial log in
    }
 }
