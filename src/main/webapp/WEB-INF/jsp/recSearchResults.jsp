<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.FlightPathBean" %>

<%
LinkedList<DestinationBean> matchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("matchingDestinations");
LinkedList<DestinationBean> almostMatchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("almostMatchingDestinations");
LinkedList<FlightPathBean> flightResults1 = (LinkedList<FlightPathBean>) session.getAttribute("flightResults1");
LinkedList<FlightPathBean> flightResults2 = (LinkedList<FlightPathBean>) session.getAttribute("flightResults2");
LinkedList<FlightPathBean> flightResults3 = (LinkedList<FlightPathBean>) session.getAttribute("flightResults3");

String isDestinations = (String) session.getAttribute("isDestinations");
String isFlights = (String) session.getAttribute("isFlights");
boolean destinations = false;
boolean flights = false;

if(isDestinations != null){
    destinations = true;
}
else if(isFlights != null){
    flights = true;
}
%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<jsp:include page='c-Sidebar-Homepage.jsp'></jsp:include>
<jsp:include page='c-AccountAccess.jsp'></jsp:include>
<br><br>
<body>
<div class="centeringtext">
    <h1>Recommendation Search Results</h1>
    <% if(destination) { %>
    <div class="centeringtext">
        <h2>Destinations For You</h2>
            <jsp:include page="c-destinationSearchResults.jsp"></jsp:include>
    </div>
    <% } else if(flights) { %>
    <div class="centeringtext">
            <h2>Flights For You</h2>
                <jsp:include page="c-searchResultsRow.jsp"></jsp:include>
        </div>
    <% } else { %>
        <div class="centeringtext">Sorry! Something went wrong.</div>
    <%}%>
</div>
</body>
</html>
