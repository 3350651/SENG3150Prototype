<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="startUp.PoolBean" %>
<%@ page import="java.util.List" %>
<%
GroupBean group = (GroupBean) session.getAttribute("group");
PoolBean pool = (PoolBean) session.getAttribute("pool");
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


 <header>
            <div class="titleContainer">
                <h1>Add To Money Pool</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>
        <div>
            Required Pool Amount Remaining: <%= pool.getAmountRemaining() %>
        </div>
        <div id="addMoneyToPoolFormContainer">
            <form method="POST" action="GroupHomepage" onsubmit="return addMoneyToPool()">
                <label for="addMoney">Amount to Deposit: </label>
                <input type="text" id="addMoney" name="addMoney"><br>

                <button type="submit" name="addMoney" value="addMoney">Add to Pool</button>
            </form>
            <form method="POST" action="GroupHomepage">
               <button type="submit" name="cancel" value="true">Cancel</button>
               <input type="hidden" id="toPool" name="toPool" value="toPool">
            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>