<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.recSearchBean" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%
    UserBean user = (UserBean) session.getAttribute("userBean");
    LinkedList<FlightBean> bookmarkedFlights = new LinkedList<>();
    if (user != null && user.getBookmarkedFlights() != null) {
        bookmarkedFlights = user.getBookmarkedFlights();
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>FlightPub</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="hompage-simplesearch-loggedin">
<jsp:include page='c-Sidebar-recPage.jsp'></jsp:include>
<div class="main-content">
    <jsp:include page='c-AccountAccess.jsp'></jsp:include>
    <br><br>
    <jsp:include page='c-recSearchBar.jsp'></jsp:include>
    <jsp:include page='c-SimpleSearchUtilities.jsp'></jsp:include>
    <% if (user != null) { %>
        rec for you
        <% recSearchBean rsearch = (recSearchBean) session.getAttribute("recFlights"); LinkedList<FlightBean> recSearchResults = rsearch.getRecFlights();%>
        <% int i = 0; for (FlightBean flight : recSearchResults ) { %>
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
    <%}%>
</div>
</body>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>