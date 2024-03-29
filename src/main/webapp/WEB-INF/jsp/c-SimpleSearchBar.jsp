<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.DestinationOptionsBean" %>
<% DestinationOptionsBean destinationOps=(DestinationOptionsBean) session.getAttribute("destinationCodes");%>
<% UserBean user = (UserBean) session.getAttribute("userBean");
LinkedList<FlightPathBean> bookmarkedFlights = new LinkedList<>();
if (user != null && user.getBookmarkedFlights() != null) {
bookmarkedFlights = user.getBookmarkedFlights();
}
%>

<div class="simpleSearch">
    <form method="POST" action="flightSearch" class="simpleSearchForm" name="simpleSearchForm" onsubmit="return validateSearchForm()">
        <div class="departureLocation"><label for="departureLocation">Leaving
                From</label><br>
            <select id="departureLocation" name="departureLocation">
                <option value="">Select Option</option>
                <%for(DestinationBean destination: destinationOps.getDestinations()){%>
                    <option value=<%=destination.getDestinationCode()%>><%=destination.getDestinationName()%>
                    </option>
                <%}%>
            </select>
        </div>
        <div class="arrivalLocation"><label for="arrivalLocation">Going To</label><br>
            <select id="arrivalLocation" name="arrivalLocation">
                <option value="">Select Option</option>
                <%for(DestinationBean destination: destinationOps.getDestinations()){
                    if(destinationOps.getSelected() != null && destination.getDestinationCode().equalsIgnoreCase(destinationOps.getSelected())){%>
                        <option value=<%=destination.getDestinationCode()%> selected="selected"><%=destination.getDestinationName()%>
                        </option>
                        <%}
                        else{%>

                    <option value=<%=destination.getDestinationCode()%>><%=destination.getDestinationName()%>
                    </option>
                    <%}
                }%>
            </select>
        </div>
        <div style="clear:both;">&nbsp;</div>
        <div class="departureDate"><label for="departureDate">Date</label><br>
            <input type="date" id="departureDate" name="departureDate" min="2014-09-22" max="2016-01-07">
        </div>
        <div class="flexibleDateDiv" id="flexibleDateDiv">
                <label for="flexibleDays">Days flexible</label><br>
                <input type="number" min="0" max="30" step="1" id="flexibleDays" name="flexibleDays" value="0">
        </div>
        <div class="numberOfAdults"><label for="numberOfAdults"># Adults</label><br>
            <input type="number" id="numberOfAdults" size="2" name="numberOfAdults" value="0">
        </div>
        <div class="numberOfChildren"><label for="numberOfChildren"># Children</label><br>
            <input type="number" id="numberOfChildren" size="2" name="numberOfChildren" value="0">
        </div>
        <div style="clear:both;">&nbsp;</div>
        <div style="clear:both;">&nbsp;</div>
        <div class="containerSaveSearchAndSearch">
            <% if(user != null) {%>
            <div class="saveParam">
                <button name="saveParam" type="submit" value="saveParam" class="saveParam">Save
                    Search Parameters</button>
            </div>
            <%}%>
            <div class="search">
                <button name="searchResults" type="submit" value="simpleSearchResults" class="search">Search For
                    Flights</button>
            </div>
        </div>
    </form>
    </div>