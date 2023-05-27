<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="startUp.PoolBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
UserBean user = (UserBean) session.getAttribute("userBean");
GroupBean group = (GroupBean) session.getAttribute("group");
PoolBean pool = (PoolBean) session.getAttribute("pool");
boolean hasDeposited = (boolean) session.getAttribute("hasDeposited");
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>
        <header>
           <form name="backtoGroupHomepage" action="GroupHomepage" method="GET">
                   <button class="groupButton" type="submit" name="groupHomepage" value="true">Return to Group Homepage</button>
           </form>

            <div class="titleContainer">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <h1>Money Pool</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div class="moneyPool">
            <div>
                <p style="font-size: 20px;"><br style="line-height: 0px;">Total Amount of Pool:<br style="line-height: 0px;"><b> <%= pool.getTotalAmount()  %></b></p>
                <p style="font-size: 20px;">Required Pool Amount Remaining:<br style="line-height: 0px;"><b><%= pool.getAmountRemaining() %></b></p>
            </div>


        <div>
            <form name="addToPool" action="GroupHomepage" method="POST">
                   <button class="groupButton" type="submit" name="addToPool" value="addToPool">Add To Pool</button>
            </form>
        </div>
        <%if(hasDeposited) {%>
             <div>
                <form name="withdrawFromPool" action="GroupHomepage" method="POST">
                       <button class="groupButton" type="submit" name="withdrawFromPool" value="withdrawFromPool">Withdraw From Pool</button>
                </form>
             </div>
         <%}%>
         </div>
    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>