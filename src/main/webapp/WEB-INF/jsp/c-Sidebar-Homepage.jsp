<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="java.util.List" %>
<%@ page import="startUp.DestinationBean" %>
<%
LinkedList<GroupBean> groups = (LinkedList<GroupBean>) session.getAttribute("groups");
%>
<%
  UserBean user = (UserBean) session.getAttribute("userBean");
  LinkedList<FlightPathBean> bookmarkedFlights = new LinkedList<>();
  if (user != null && user.getBookmarkedFlights() != null) {
    bookmarkedFlights = user.getBookmarkedFlights();
}
%>

<div class="sidebar">
    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
        alt="FlightPub Logo" class="logo">
    <%-- Home page button --%>

    <!-- TODO: fix this servlet call? -->
    <form name="SearchSelect" action="flightSearch" method="GET">
        <h2>Toggle Search Mode</h2>
        <%if(request.getAttribute("simple") != null){%>
            <button type="submit" class="button" name="home"
                value="recommendSearch">Recommend Search</button>
            
            <%}else{%> 
                <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> 
                <%}%>     
    </form>

    <%-- Bookmarked Flights --%>
    <% if (bookmarkedFlights.size() != 0) { %>
    <h2>Bookmarked Flights</h2>
    <%
      int j=0;
      if (bookmarkedFlights.size() > 0){
      for(FlightPathBean flightPath : bookmarkedFlights) { ;
    %>
    <form name="goToBookmarkedFlight<%= j+1 %>" action="flightSearch" method="POST">

    <!-- TODO: fix linking here -->
        <button type="submit" class="button" name="viewFlight" value="viewFlight">
        <div class="searchResultRow1" id="sidebar">
        <div class="DepartureLocationResult" id="sidebar"><%=flightPath.getFlightPath().get(flightPath.getFlightPath().size()-1).getDeparture().getDestinationName()%> &nbsp;</div>
        <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" id="sidebar">
        <div class="DestinationLocationResult" id="sidebar">&nbsp;<%=flightPath.getLastFlight().getDestination().getDestinationName()%> &nbsp; </div>
        </div>
        </button>
    <%
      j++;}}
    %>
    </form>
    <% } %>
    <%-- Groups You're In --%>
    <% if (user != null) { %>
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
    <% } %>
    </div>
</div>