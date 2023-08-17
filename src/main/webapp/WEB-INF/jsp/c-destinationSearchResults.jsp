<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.UserBean" %>

<%
LinkedList<DestinationBean> matchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("matchingDestinations");
LinkedList<DestinationBean> almostMatchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("almostMatchingDestinations");
UserBean user = (UserBean) session.getAttribute("userBean");

LinkedList<DestinationBean> destinations = new LinkedList<DestinationBean>();

if(matchingDestinations != null){
    destinations = matchingDestinations;
}
else if(almostMatchingDestinations != null){
    destinations = almostMatchingDestinations;
}

%>

<div class="gridParent" id="simple">

    <%
    if(destinations.size() > 0) {
    int i = 0; for (DestinationBean destination : destinations ) {

    %>
        <div class="recResults">
            <div class="FlightSearchResult">
                <div class="simpleFlightCardColumn1">
                <div class="flightInfo">
                    <div class="searchResultRow1">
                        <div class="DepartureLocationResult"><%= destination.getDestinationName() %></div>
                        <br>
                        <div class="DepartureLocationResult">In <%= destination.getDestinationCountry() %> &nbsp;</div>
                    </div>
                </div>
                <div class="searchResultButtons">
                        <form method="POST" action="flightSearch">
                            <input type="hidden" name="destinationCode" value="<%= destination.getDestinationCode() %>">
                            <div class="viewFlightDetailsButton">
                                <button type="submit" class="viewFlightDetailsButton" name="destinationToFlight" value="true">Find Flights</button>
                            </div>
                        </form>
                </div>
                </div>
                <div class="destinationImage">
                    <img src="${pageContext.request.contextPath}/images/brisbaneCity.jpg" alt="Brisbane Logo" class="smallBrisbaneLogo" >
                </div>
            </div>
        </div>
    <% i++; }
    } else {%>
        <div>Sorry! There were no results found with those exact tags!</div>
    <%}%>
</div>