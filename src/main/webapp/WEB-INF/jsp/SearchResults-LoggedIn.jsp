!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FlightPub</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="hompage-simplesearch-loggedin">
<div class="sidebar">
<img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
<%--        Home page button         --%>
    <form name="BackToHome" action="Search" method="POST">
        <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> --%>
        <button type="submit" class="button" name="home" value="backToHome">Home</button>
    </form>
<%--        Favourited Flights         --%>
    <form name="goToBookmarkedFlight" action="ViewFlight" method="POST">
    <h2>Bookmarked Flights</h2>
        <button type="submit" class="button" name="goToBookmarkedFlight1" value="goToBookmarkedFlight1">Morrocco, $1,290, 15/12/2023</button>
        <button type="submit" class="button" name="goToBookmarkedFlight2" value="goToBookmarkedFlight2">Thailand, $679, 6/10/2023</button>
    </form>
<%--        Groups You're In         --%>
    <form name="goToGroup" action="GroupHomepage" class="groups" method="POST">
        <h2>Group Membership</h2>
        <button type="submit" class="button" name="goToGroup1" value="goToGroup1">FriendGroup</button>
        <button type="submit" class="button" name="createGroup" value="createGroup">Create New Group</button>
    </form>
</div>
<div class="main-content">
    <div class="viewAccountSettings">
        <form method="POST" action="AccountSettings">
            <button name="viewAccountSettings" class="accountButton" value="viewAccountSettings">View Profile</button>
        </form>
    </div>
    <div class="FlightSearchResult">
        <div class="DepartureLocation">Departure: Newcastle</div>
        <div class="DestinationLocation">Destination: Brisbane</div>
        <div class="Price">$462</div>
        <div class="numPassengers">2</div>
    </div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>