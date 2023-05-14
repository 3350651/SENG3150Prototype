!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FlightPub</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="searchresults-loggedin">
<div class="sidebar">
<img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
<%--        Home page button         --%>
    <form name="SearchSelect" action="MockupGroup" method="POST">
    <h2>Toggle Search Mode</h2>
        <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> --%>
        <button type="submit" class="button" name="home" value="recommendSearch">Recommend Search</button>
    </form>
<%--        Favourited Flights         --%>
    <form name="goToBookmarkedFlight" action="ViewFlight" method="POST">
    <h2>Bookmarked Flights</h2>
        <button type="submit" class="button" name="goToBookmarkedFlight1" value="goToBookmarkedFlight1">Morrocco, $1,290, 15/12/2023</button>
        <button type="submit" class="button" name="goToBookmarkedFlight2" value="goToBookmarkedFlight2">Thailand, $679, 6/10/2023</button>
    </form>
<%--        Groups You're In         --%>
    <form name="goToGroup" action="MockupGroup" class="groups" method="POST">
        <h2>Group Membership</h2>
        <button type="submit" class="button" name="goToGroup1" value="goToGroup1">Group 1</button>
        <button type="submit" class="button" name="createGroup" value="createGroup">Create New Group</button>
    </form>
</div>
<div class="main-content">
    <div class="viewAccountSettings">
        <form method="POST" action="MockUpAccountSettings">
            <button name="viewAccountSettings" class="accountButton" value="viewAccountSettings">View Profile</button>
        </form>
    </div>
    <br><br>
    <div class="simpleSearch">
        <form method="POST" action="Search" class="simpleSearchForm">

            <div class="departureLocation"><label for="departureLocation">Leaving From</label><br>
            <input type="text" value="Newcastle" id="departureLocation" name="departureLocation"></div>
            <div class="arrivalLocation"><label for="arrivalLocation">Going To</label><br>
            <input type="text" id="arrivalLocation" name="arrivalLocation"></div>
            <div style="clear:both;">&nbsp;</div>
            <div class="departureDate"><label for="departureDate">Date</label><br>
            <input type="date" id="departureDate" name="departureDate"></div>
            <div class="flexibleDate"><label for="flexibleDate">Flexible?</label> <br>
            <input type="checkbox" id="flexibleDate" name="flexibleDate">
            <div class="flexibleDaysGroup" id="flexibleDaysGroup" style="display:none;">
            <label for="flexibleDays">Days flexible?</label><br>
            <input type="number" min="0" max="30" step="1" id="flexibleDays" name="flexibleDays">
            </div></div>
            <div class="numberOfAdults"><label for="numberOfAdults"># Adults</label><br>
            <input type="number" id="numberOfAdults" size="2" name="numberOfAdults"></div>
            <div class="numberOfChildren"><label for="numberOfChildren"># Children</label><br>
            <input type="number" id="numberOfChildren" size="2" name="numberOfChildren"></div>
            <div style="clear:both;">&nbsp;</div>
            <div style="clear:both;">&nbsp;</div>
            <div class="saveParam">
            <button name="saveParam" value="saveParam" class="saveParam">Save Search Parameters</button>
            </div>
            <div class="search">
            <button name="search" value="searchLogged" class="search">Search For Flights</button>
            </div>
        </form>
    </div>

    <div class="savedSearches">
    <h2 class="savedSearchesHeading">Saved Searches</h2>
        <form method="POST" action="Search">
        <input type="hidden" value="savedParameter1">
        <button name="savedParameter" type="submit" value="savedParameter1" class="savedParameter">NTL > BNE, 2 adults, 28/12/23 (+5d)</button><br>
        <button name="savedParameter" type="submit" value="savedParameter2" class="savedParameter">NTL > MLB, 1 adult, 28/05/23</button>
        </form>
    </div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/script.js"></script>

</html>