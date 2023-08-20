<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.DestinationOptionsBean" %>
<%@ page import="startUp.TagBean" %>
<% DestinationOptionsBean DestinationOps=(DestinationOptionsBean) session.getAttribute("destinationCodes");%>
<% UserBean user = (UserBean) session.getAttribute("userBean");
LinkedList<FlightPathBean> bookmarkedFlights = new LinkedList<>();
if (user != null && user.getBookmarkedFlights() != null) {
bookmarkedFlights = user.getBookmarkedFlights();
}
LinkedList<String> tagSet = TagBean.getAllTags();
%>

<div class="simpleSearch">
  <form method="POST" action="flightSearch" class="recSearchForm" name="tagSearch" >
    <h2>Find a Destination</h2>
        <div><label for="searchType">Tags</label><br>
            <select class="selectTags" name="tags" multiple="multiple">
                <%
                for(String tag : tagSet) { %>
                    <option value='<%= tag %>'><%= tag %></option>
               <% }
                %>
            </select>
        </div>
        <div style="clear:both;">&nbsp;</div>
        <div style="clear:both;">&nbsp;</div>
        <div>
             <div style="float: left">
                  <button name="selectedTags" type="submit" value="selectedTags"
                          class="tagSearch" onclick="return validateTagSearch()">GO</button>
             </div>
             <%if(user != null){%>
            <div style="float: right">
              <button name="userTags" class="search" type="submit" value="userTags">Use My Profile Tags</button>
            </div>
            <%}%>
        </div>
        <input type="hidden" name="searchResults" value="recSearchResults"/>
  </form>
</div>

<div class="simpleSearch">
  <form method="POST" action="flightSearch" class="recSearchForm" name="randomDestinationForm" onsubmit="return validateRandomDestForm()">
    <h2>Random Flight</h2>
      <div class="departureLocation"><label for="departureLocation">Leaving
                        From</label><br>
                    <select id="departureLocation" name="departure">
                        <option value="">Select Option</option>
                        <%for(DestinationBean destination: DestinationOps.getDestinations()){%>
                            <option value=<%=destination.getDestinationCode()%>><%=destination.getDestinationName()%>
                            </option>
                            <%}%>
                    </select>
                </div>
                <div style="clea
        <div style="clear:both;">&nbsp;</div>

        <div class="departureDate"><label for="departureDate">Date</label><br>
          <input type="date" id="departureDate" name="departureDate" min="2014-09-22" max="2016-01-07">
          
        </div>
        <div class="numberOfAdults"><label for="numberOfAdults"># Adults</label><br>
          <input type="number" id="numberOfAdults" size="2" name="numberOfAdults">
        </div>
        <div class="numberOfChildren"><label for="numberOfChildren"># Children</label><br>
          <input type="number" id="numberOfChildren" size="2" name="numberOfChildren">
        </div>

        <div style="clear:both;">&nbsp;</div>
          <div style="clear:both;">&nbsp;</div>
        <div class="containerSaveSearchAndSearch">
            <div class="search">
              <button name="randomDestination" type="submit" value="randomDestination"
                      class="search">Go Anywhere</button>
            </div>
        </div>
        <input type="hidden" name="searchResults" value="recSearchResults"/>
  </form>
</div>