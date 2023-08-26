<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="startUp.DestinationBean" %>
<%
  LinkedList<GroupBean> groups = (LinkedList<GroupBean>) session.getAttribute("groups");
%>
<%
  UserBean user = (UserBean) session.getAttribute("userBean");
  LinkedList<FlightBean> bookmarkedFlights = new LinkedList<>();
  if (user != null && user.getBookmarkedFlights() != null) {
    bookmarkedFlights = user.getBookmarkedFlights();
  }
%>

<div class="sidebar">
  <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
       alt="FlightPub Logo" class="logo">
  <%-- Home page button --%>
  <form name="gotoSimple" action="flightSearch" method="POST">
    <h2>Toggle Search Mode</h2>
    <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple
        Search</button> --%>
    <button type="submit" class="button" name="gotoSimple"
            value="gotoSimple">Simple Search</button>
  </form>
  <% if (user != null) { %>
  <form name="bookingButton" action="manageBookings" method="GET">
    <button type="submit" class="button" name="home" value="manageBookings">Manage Bookings</button>
  </form>
  <% } %>
  <%-- Bookmarked Flights --%>
  <% if (bookmarkedFlights.size() != 0) { %>
  <form name="goToBookmarkedFlight" action="ViewFlight" method="POST">
    <h2>Bookmarked Flights</h2>
    <%
      int j=0;
      if (bookmarkedFlights.size() > 0){
        for(FlightBean flight : bookmarkedFlights) { ;
    %>
    <button type="submit" class="button" name="goToBookmarkedFlight<%= j+1 %>" value="goToBookmarkedFlight<%= j+1 %>">
      <%= flight.getDestination().getDestinationName() %>, <%= flight.getFlightTime() %>
    </button>
    <%
          j++;}}
    %>
  </form>
  <% } %>
  <%-- Groups You're In --%>
  <div class = "GroupMembership">
    <h2>Your Groups</h2>
    <%
      if(groups != null && (!groups.isEmpty())){
        int size = groups.size();
        String name = "";
        for(int i = 0; i < size; i++){
          GroupBean group = groups.pop();
          name = group.getGroupName(); %>
    <div>
      <form method="GET" action="GroupHomepage">
        <button class="button" name="goGroup" value="goGroup">
          <%= name %>
        </button>
        <input type="hidden" id="groupName" name="groupName" value="<%= name %>">
        <input type="hidden" id="faveList" name="getGroupFaveList" value="true">
      </form>
    </div>
    <%
          groups.addLast(group);
        }
      }
    %>
    <form name="goToGroup" action="CreateGroup" class="groups" method="GET">
      <button type="submit" class="button" name="createGroup"
              value="createGroup">Create New Group</button>
    </form>
  </div>
</div>