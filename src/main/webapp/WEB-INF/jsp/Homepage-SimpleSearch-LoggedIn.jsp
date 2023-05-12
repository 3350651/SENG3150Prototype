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
    <form name="SearchSelect" action="Homepage" method="POST">
    <h2>Search Mode</h2>
        <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> --%>
        <button type="submit" class="button" name="home" value="recommendSearch">Recommend Search</button>
    </form>
    <br>
<%--        Favourited Flights         --%>
    <form name="goToBookmarkedFlight" action="ViewFlight" method="POST">
    <h2>Bookmarked Flights</h2>
        <button type="submit" class="button" name="goToBookmarkedFlight1" value="goToBookmarkedFlight1">Morrocco, $1,290, 15/12/2023</button>
        <button type="submit" class="button" name="goToBookmarkedFlight2" value="goToBookmarkedFlight2">Thailand, $679, 6/10/2023</button>
    </form>
<%--        Groups You're In         --%>
    <form name="goToGroup" action="GroupHomepage" class="groups" method="POST">
        <h2>Group Membership</h2>
        <button type="submit" class="button" name="goToGroup1" value="goToGroup1">Go To FriendGroup</button>
        <button type="submit" class="button" name="createGroup" value="createGroup">Create New Group</button>
    </form>
</div>
<div class="main-content">
    <h1>FlightPub - Taking You Where You Would Rather Be</h1>
    <div class="viewAccountSettings">
        <form method="POST" action="AccountSettings">
            <button name="viewAccountSettings" class="accountButton" value="viewAccountSettings">View Profile</button>
        </form>
    </div>
    <br>
    <div class="simpleSearch">
        <form method="POST" action="Search" class="simpleSearchForm">
            <div class="form-group"><label for="departureDate">Date</label><br>
            <input type="date" id="departureDate" name="departureDate"></div>
            <div class="form-group"><label for="departureLocation">Leaving From</label><br>
            <input type="text" id="departureLocation" name="departureLocation"></div>
            <div class="form-group"><label for="arrivalLocation">Going To</label><br>
            <input type="text" id="arrivalLocation" name="arrivalLocation"></div>
            <div class="form-group"><label for="flexibleDate">Flexible Date?</label> <br>
            <input type="checkbox" id="flexibleDate" name="flexibleDate">
            <div class="form-group" id="flexibleDaysGroup" style="display:none;">
                            <label for="flexibleDays">How many days flexible?</label><br>
                            <input type="number" min="0" max="30" step="1" id="flexibleDays" name="flexibleDays">
                        </div>
            </div>
            <div class="form-group"><label for="numberOfAdults"># Adults</label><br>
            <input type="number" id="numberOfAdults" name="numberOfAdults"></div>
            <div class="form-group"><label for="numberOfChildren"># Children</label><br>
            <input type="number" id="numberOfChildren" name="numberOfChildren"></div>

            <button name="saveParameters" value="saveParameters" class="saveParam">Save Search Parameters</button>
            <button name="searchForFlight" value="searchForFlight" class="search">Search For Flights</button>
        </form>
    </div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>