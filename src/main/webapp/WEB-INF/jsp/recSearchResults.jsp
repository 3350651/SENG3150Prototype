<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.UserTagSearchBean" %>
<%
LinkedList<UserTagSearchBean> userTags = (LinkedList<UserTagSearchBean>) session.getAttribute("userTags");
String selectedTags = (String) session.getAttribute("selectedTags");
String isFlights = (String) session.getAttribute("isFlights");
boolean destinations = false;
boolean flights = false;

if(userTags != null || selectedTags != null){
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
<form style="float: left; margin-left: 300px;" name="SearchSelect" action="flightSearch" method="GET">
    <button type="submit" class="button" name="home"
        value="recommendSearch">Back</button>
</form>
<br><br>
<div class="centeringtext">
    <h1>Recommendation Search Results</h1>
    <% if(destinations) { %>
    <div>
        <h1>Destinations For You</h1>
            <jsp:include page="c-destinationSearchResults.jsp"></jsp:include>
    </div>
    <% } else if(flights) { %>
    <div>
            <h1>Flights For You</h1>
                <jsp:include page="c-flightSearchResults.jsp"></jsp:include>
        </div>
    <% } else { %>
        <div>Sorry! Something went wrong.</div>
    <%}%>
</div>
</body>
</html>
