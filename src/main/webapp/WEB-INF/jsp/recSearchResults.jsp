<%--
  Created by IntelliJ IDEA.
  User: colli
  Date: 25/05/2023
  Time: 6:48 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.recSearchBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.UserBean" %>
<html>
<head>
    <title>Title</title>
</head>
<% recSearchBean search = (recSearchBean) session.getAttribute("flightResults"); LinkedList<FlightBean> searchResults = search.getFlightResults();%>
<% int i = 0; for (FlightBean flight : searchResults ) { %>
        <tr>
            <td>
                <%=flight.getAirline()%>
            </td>

            <td>
                <%=flight.getFlightName()%>
            </td>
            <td>
                        <%=flight.getDeparture().getDestinationName()%>
            </td>
            <td>
                        <%=flight.getDestination().getDestinationName()%>
            </td>
            <td>
                        <%=flight.getStopOver().getDestinationName()%>
            </td>
            <td>
                        <%=flight.getFlightTime()%>
            </td>
        </tr>
<% i++; }%>
<body>

</body>
</html>
