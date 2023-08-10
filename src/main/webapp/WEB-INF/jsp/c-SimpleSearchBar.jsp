<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.DestinationOptionsBean" %>
<% DestinationOptionsBean DestinationOps=(DestinationOptionsBean) session.getAttribute("destinationCodes");%>
<% UserBean user = (UserBean) session.getAttribute("userBean");
LinkedList<FlightBean> bookmarkedFlights = new
LinkedList<>();
if (user != null && user.getBookmarkedFlights() != null) {
bookmarkedFlights = user.getBookmarkedFlights();
}
%>

<div class="simpleSearch">
    <form method="POST" action="flightSearch" class="simpleSearchForm">
        <div class="departureLocation"><label for="departureLocation">Leaving
                From</label><br>
            <select id="departureLocation" name="departureLocation">
                <option value="">Select Option</option>
                <%for(DestinationBean destination: DestinationOps.getDestinations()){%>
                    <option value=<%=destination.getDestinationCode()%>><%=destination.getDestinationName()%>
                    </option>
                    <%}%>
            </select>
        </div>
        <div class="arrivalLocation"><label for="arrivalLocation">Going To</label><br>
            <select id="arrivalLocation" name="arrivalLocation">
                <option value="">Select Option</option>
                <%for(DestinationBean destination: DestinationOps.getDestinations()){%>
                    <option value=<%=destination.getDestinationCode()%>><%=destination.getDestinationName()%>
                    </option>
                    <%}%>
            </select>
        </div>
        <div style="clear:both;">&nbsp;</div>
        <div class="departureDate"><label for="departureDate">Date</label><br>
            <input type="date" id="departureDate" name="departureDate">
        </div>
        <div class="flexibleDateDiv" id="flexibleDateDiv"><label for="flexibleDate">Flexible?</label> <br>
            <input type="checkbox" id="flexibleDate" name="flexibleDate">
            <div class="flexibleDaysGroup" id="flexibleDaysGroup" style="display:none;">
                <label for="flexibleDays">Days flexible?</label><br>
                <input type="number" min="0" max="30" step="1" id="flexibleDays" name="flexibleDays">
            </div>
        </div>
        <div class="numberOfAdults"><label for="numberOfAdults"># Adults</label><br>
            <input type="number" id="numberOfAdults" size="2" name="numberOfAdults">
        </div>
        <div class="numberOfChildren"><label for="numberOfChildren"># Children</label><br>
            <input type="number" id="numberOfChildren" size="2" name="numberOfChildren">
        </div>
        <div style="clear:both;">&nbsp;</div>
        <div style="clear:both;">&nbsp;</div>
        <div class="saveParam">
            <button name="saveParam" type="submit" value="saveParam" class="saveParam">Save
                Search Parameters</button>
        </div>
        <div class="search">
            <button name="searchResults" type="submit" value="simpleSearchResults" class="search">Search For
                Flights</button>
        </div>
    </form>
    </div>
<%@ page import="startUp.DestinationOptionsBean" %>
    <%@ page import="startUp.DestinationBean" %>
        <div class="simpleSearch">
            <%DestinationOptionsBean DestinationOps=(DestinationOptionsBean) session.getAttribute("destinationCodes");%>
                <form method="POST" action="flightSearch" class="simpleSearchForm" name="simpleSearchForm" onSubmit="return validateSearchForm()">

                    <div class="departureLocation"><label for="departureLocation">Leaving
                            From</label><br>
                        <select id="departureLocation" name="departureLocation">
                            <option value="">Select Option</option>
                            <%for(DestinationBean destination: DestinationOps.getDestinations()){%>
                                <option value=<%=destination.getDestinationCode()%>><%=destination.getDestinationName()%>
                                </option>
                                <%}%>
                        </select>
                    </div>
                    <div class="arrivalLocation"><label for="arrivalLocation">Going To</label><br>
                        <select id="arrivalLocation" name="arrivalLocation">
                            <option value="">Select Option</option>
                            <%for(DestinationBean destination: DestinationOps.getDestinations()){%>
                                <option value=<%=destination.getDestinationCode()%>><%=destination.getDestinationName()%>
                                </option>
                                <%}%>
                        </select>
                    </div>
                    <div style="clear:both;">&nbsp;</div>
                    <div class="departureDate"><label for="departureDate">Date</label><br>
                        <input type="date" id="departureDate" name="departureDate">
                    </div>
                    <div class="flexibleDateDiv" id="flexibleDateDiv"><label for="flexibleDate">Flexible?</label> <br>
                        <input type="checkbox" id="flexibleDate" name="flexibleDate">
                        <div class="flexibleDaysGroup" id="flexibleDaysGroup" style="display:none;">
                            <label for="flexibleDays">Days flexible?</label><br>
                            <input type="number" min="0" max="30" step="1" id="flexibleDays" name="flexibleDays">
                        </div>
                    </div>
                    <div class="numberOfAdults"><label for="numberOfAdults"># Adults</label><br>
                        <input type="number" id="numberOfAdults" size="2" name="numberOfAdults" value="0">
                    </div>
                    <div class="numberOfChildren"><label for="numberOfChildren"># Children</label><br>
                        <input type="number" id="numberOfChildren" size="2" name="numberOfChildren" value="0">
                    </div>
                    <div style="clear:both;">&nbsp;</div>
                    <div style="clear:both;">&nbsp;</div>
                    <div class="saveParam">
                        <button name="saveParam" type="submit" value="saveParam" class="saveParam">Save
                            Search Parameters</button>
                    </div>
                    <div class="search">
                        <button name="searchResults" type="submit" value="simpleSearchResults" class="search">Search For
                            Flights</button>
                    </div>
                </form>
        </div>