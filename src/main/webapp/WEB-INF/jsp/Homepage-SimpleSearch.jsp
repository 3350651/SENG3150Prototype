<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<% UserBean user = (UserBean) session.getAttribute("userBean");
LinkedList<FlightBean> bookmarkedFlights = new
LinkedList<>();
if (user != null && user.getBookmarkedFlights() != null) {
bookmarkedFlights = user.getBookmarkedFlights();
}
%>
<head>
  <meta charset="UTF-8">
  <title>FlightPub-Simple</title>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="hompage-simplesearch-loggedin">
  <%request.setAttribute("simple", true);%>
  <jsp:include page='c-Sidebar-Homepage.jsp'></jsp:include>
  <div class="main-content">
    <jsp:include page='c-AccountAccess.jsp'></jsp:include>
    <br><br>
    <jsp:include page='c-SimpleSearchBar.jsp'></jsp:include>
    <jsp:include page='c-SimpleSearchUtilities.jsp'></jsp:include>
  </div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>