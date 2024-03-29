<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%
    UserBean user = (UserBean) session.getAttribute("userBean");
    LinkedList<FlightPathBean> bookmarkedFlights = new LinkedList<>();
    if (user != null && user.getBookmarkedFlights() != null) {
        bookmarkedFlights = user.getBookmarkedFlights();
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>FlightPub - Recommended Search</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
     <script src="${pageContext.request.contextPath}/scripts/script.js"></script>
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
     <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
     <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
     <script>$(document).ready(function(){
        $('.selectTags').select2();
        });
     </script>
      <script>
           $(function(){
           if($("#departureLocation") !== null){
           $("#departureLocation").select2();
           }
           });
       </script>
       <script>
             $(function(){
            if($("#arrivalLocation") !== null){
                  $("#arrivalLocation").select2();
                  }
             });
         </script>
</head>

<body class="hompage-simplesearch-loggedin">
<jsp:include page='c-Sidebar-Homepage.jsp'></jsp:include>
<div class="main-content">
    <jsp:include page='c-AccountAccess.jsp'></jsp:include>
    <br><br>
    <jsp:include page='c-recSearchBar.jsp'></jsp:include>
    <br><br>
     <div class="initialRec">
        <h1>Destinations For You</h1>
        <jsp:include page="c-destinationSearchResults.jsp"></jsp:include>
     </div>
</div>
</body>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>