<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Search Results</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<jsp:include page='c-Sidebar-Homepage.jsp'></jsp:include>
<jsp:include page='c-AccountAccess.jsp'></jsp:include>
<br><br>
<body>
<div class="centeringtext"> <h1>Recommended Flights based on your Search Terms</h1> </div>
<jsp:include page="c-searchResultsRow.jsp"></jsp:include>
    <div class="centeringtext"> <h1>Most Popular Flights based on your Search Terms</h1> </div>
    <jsp:include page="c-searchResultsRow.jsp"></jsp:include>
<div class="centeringtext"> <h1>Budget Flights based on your Search Terms</h1> </div>
<jsp:include page="c-searchResultsRow.jsp"></jsp:include>
</body>
</html>
