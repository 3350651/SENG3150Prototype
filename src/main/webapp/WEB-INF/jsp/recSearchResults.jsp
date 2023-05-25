<%--
  Created by IntelliJ IDEA.
  User: colli
  Date: 25/05/2023
  Time: 6:48 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<jsp:useBean id="search" class="startUp.recSearchBean"/>
<s:forEach items="${flightResults}" var="flightBean" varStatus="counter">
        <tr>
            <td>
                    ${flightBean.getAirline()}
            </td>

            <td>
                    ${flightBean.getFlightName()}
            </td>
            <td>
                    ${flightBean.getDeparture()}
            </td>
            <td>
                    ${flightBean.getDestination()}
            </td>
            <td>
                    ${flightBean.getStopOver}
            </td>
            <td>
                    ${flightBean.getFlightTime()}
            </td>
        </tr>
</s:forEach>
<body>

</body>
</html>
