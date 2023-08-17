<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.UserBean" %>

<%
LinkedList<DestinationBean> matchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("matchingDestinations");
LinkedList<DestinationBean> almostMatchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("almostMatchingDestinations");
UserBean user = (UserBean) session.getAttribute("userBean");

String userTags = (String) session.getAttribute("userTags");
String selectedTags = (String) session.getAttribute("selectedTags");
boolean isUserTags = false;
boolean isSelectedTags = false;

if(userTags != null){
    isUserTags = true;
}
else {
    isSelectedTags = true;
}
%>

<div class="gridParent" id="simple">

    <%
        if(matchingDestinations.size() > 0) {
        int i = 0; for (DestinationBean destination : matchingDestinations ) {

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
            if(almostMatchingDestinations.size() > 0) {
            int i = 0; for (DestinationBean destination : almostMatchingDestinations ) {

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
            <% i++; } }
        } else if(matchingDestinations.size() == 0 && almostMatchingDestinations.size() == 0 && isSelectedTags){ %>
            <div>Sorry! There were no results found with those exact tags!</div>
        <%}
        else if(matchingDestinations.size() == 0 && almostMatchingDestinations.size() == 0 && isUserTags)%{>
            <div>Sorry! You need to select tags on your user profile to use this feature! Add tags through your profile and then try again!</div>
        <%}%>
</div>