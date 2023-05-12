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
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <main>
        <header>
           <form name="backtoGroupHomepage" action="GroupHomepage" method="GET">
                   <button type="submit" name="groupHomepage" value="true">Return to Group Homepage</button>
           </form>

            <div class="titleContainer">
                <h1>Money Pool</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div>
            Total Amount of Pool: <%= pool.getTotalAmount()  %><br>
            Required Pool Amount Remaining: <%= pool.getAmountRemaining() %>
        </div>

        <div>
            <form name="addToPool" action="GroupHomepage" method="POST">
                   <button type="submit" name="addToPool" value="addToPool">Add To Pool</button>
            </form>
        </div>
        <%if(hasDeposited) {%>
             <div>
                <form name="withdrawFromPool" action="GroupHomepage" method="POST">
                       <button type="submit" name="withdrawFromPool" value="withdrawFromPool">Withdraw From Pool</button>
                </form>
             </div>
         <%}%>
    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>