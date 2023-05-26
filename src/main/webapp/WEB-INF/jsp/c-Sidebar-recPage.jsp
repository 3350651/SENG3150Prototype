<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
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

<div class="sidebar">
  <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
       alt="FlightPub Logo" class="logo">
  <%-- Home page button --%>
  <form name="SearchSelect" action="recSearch" method="POST">
    <h2>Toggle Search Mode</h2>
    <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple
        Search</button> --%>
    <button type="submit" class="button" name="gotoSimple"
            value="gotoSimple">Simple Search</button>
  </form>
  <%-- Bookmarked Flights --%>
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
  <%-- Groups You're In --%>
  <form name="goToGroup" action="MockupGroup" class="groups" method="POST">
    <h2>Group Membership</h2>
    <button type="submit" class="button" name="createGroup"
            value="createGroup">Create New Group</button>
  </form>
</div>