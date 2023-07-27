<%--
  Created by IntelliJ IDEA.
  User: colli
  Date: 26/05/2023
  Time: 9:59 pm
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.SearchBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.UserBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% UserBean user=(UserBean) session.getAttribute("userBean");%>

<html>
<head>
    <meta charset="UTF-8">
    <title>FlightPub</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <%request.setAttribute("simple", true);%>
<jsp:include page='c-Sidebar-Homepage.jsp'></jsp:include>
<jsp:include page='c-AccountAccess.jsp'></jsp:include>
<% SearchBean search = (SearchBean) session.getAttribute("flightResults");
    LinkedList<FlightBean> searchResults = search.getResults();%>
<br>
<br>
<div class="centeringtext"> <h1>Search Results</h1> </div>
<jsp:include page="c-searchResultsRow.jsp"></jsp:include>
</body>
</html>
