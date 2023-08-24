<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.UserTagSearchBean" %>

<%
LinkedList<DestinationBean> matchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("matchingDestinations");
LinkedList<DestinationBean> almostMatchingDestinations = (LinkedList<DestinationBean>) session.getAttribute("almostMatchingDestinations");
UserBean user = (UserBean) session.getAttribute("userBean");

LinkedList<UserTagSearchBean> userTags = (LinkedList<UserTagSearchBean>) session.getAttribute("userTags");
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

<div class="recGridResults">

    <%
    if(isSelectedTags) {
        if(matchingDestinations != null && matchingDestinations.size() > 0) {
          %>
          <fieldset>
            <%if(selectedTags != null){%>
            <div><h2>Destinations Matching (<%= selectedTags %>)</h2></div>
            <%}
        for (DestinationBean destination : matchingDestinations ) {

        %>
            <div class="recResults">
                <div class="FlightSearchResult">
                    <div class="simpleFlightCardColumn1">
                    <div class="flightInfo">
                        <div class="searchResultRow1">
                            <%= destination.getDestinationName() %>,
                        </div>
                        <div class="searchResultRow2"> <%= destination.getDestinationCountry() %> &nbsp;</div>
                    </div>
                    <div class="searchResultButtons">
                            <form method="POST" action="destinationSearch">
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

        <% }%></fieldset><%}
        else{
        %><div>Sorry, there were no destinations that matched this exact tag combination.</div>
        </fieldset><%
        }
            if(almostMatchingDestinations!= null && almostMatchingDestinations.size() > 0) {
            %>
            <fieldset>
            <div><h2>You May Also Like:</h2></div>

            <%
            for (DestinationBean destination : almostMatchingDestinations ) {

            %>
                <div class="recResults">
                    <div class="FlightSearchResult">
                        <div class="simpleFlightCardColumn1">
                        <div class="flightInfo">
                            <div class="searchResultRow1">
                                <%= destination.getDestinationName() %>,
                            </div>
                            <div class="searchResultRow2"> <%= destination.getDestinationCountry() %> &nbsp;</div>
                        </div>
                        <div class="searchResultButtons">
                                <form method="POST" action="destinationSearch">
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
            <% } %></fieldset><% }
            if(matchingDestinations.size() == 0 && almostMatchingDestinations.size() == 0){ %>
                    <div>Sorry! There were no results found with those exact tags!</div>
                    </fieldset>
                <%}
    }
    else if(isUserTags){
    for(UserTagSearchBean result: userTags) {%>
    <fieldset>
    <h2>Destinations Matching (<%= result.getTagName() %>)</h2>

        <% for(DestinationBean destination: result.getDestinations()) {
        %><div class="recResults">
            <div class="FlightSearchResult">
                <div class="simpleFlightCardColumn1">
                <div class="flightInfo">
                    <div class="searchResultRow1">
                        <%= destination.getDestinationName() %>,
                    </div>
                    <div class="searchResultRow2"> <%= destination.getDestinationCountry() %> &nbsp;</div>
                </div>
                <div class="searchResultButtons">
                        <form method="POST" action="destinationSearch">
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

     <% }
      %></fieldset><%}
     if(userTags.size() ==0){
     %>
     <fieldset>
     <div>Sorry! You need to select tags on your user profile to use this feature! Add tags through your profile and then try again!</div>
     </fieldset>
     <%
     }
     }%>
</div>