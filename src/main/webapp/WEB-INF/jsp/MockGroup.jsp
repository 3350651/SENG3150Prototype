<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
 <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
    <br style="line-height: 5px;">
<body class="MockGroupHomepage">
<form name="backButton" action="login" method="GET">
    <button type="submit" class="button" name="home" value="backToHome">Back to Homepage</button>
</form>
<h1 style="text-align: center;">Group One</h1>
<div class="manageGroup">
    <form name="manageGroup" method="POST" action="MockupGroup">
        <button type="submit" name="manageGroup" value="manageGroup" class="groupButton">Manage Group</button>
    </form>
</div>

<div class="simpleSearch">
    <form method="POST" action="Search" class="simpleSearchForm">
        <div class="departureLocation"><label for="departureLocation">Leaving From</label><br>
        <input type="text" id="departureLocation" name="departureLocation"></div>
        <div class="arrivalLocation"><label for="arrivalLocation">Going To</label><br>
        <input type="text" id="arrivalLocation" name="arrivalLocation"></div>
        <div class="departureDate"><label for="departureDate">Date</label><br>
        <input type="date" id="departureDate" name="departureDate"></div>
        <div class="flexibleDate"><label for="flexibleDate">Flexible?</label> <br>
        <input type="checkbox" id="flexibleDate" name="flexibleDate">
        <div class="flexibleDaysGroup" id="flexibleDaysGroup" style="display:none;">
        <label for="flexibleDays">Days flexible?</label><br>
        <input type="number" min="0" max="30" step="1" id="flexibleDays" name="flexibleDays">
        </div></div>
        <div class="numberOfAdults"><label for="numberOfAdults">Passengers</label><br>
        <input type="number" id="numberOfAdults" size="2" name="numberOfAdults"></div>
        <div class="saveParam">
        <button name="saveParam" type="submit" value="saveParam" class="saveParam">Save Search Parameters</button>
        </div>
        <div class="search">
        <button name="searchLogged" type="submit" value="searchLogged" class="search">Search For Flights</button>
        </div>
    </form>
</div>

<div class="groupContents">
    <div class="chat">
        <p style="font-size: 25px; display:inline-block;">Chat  </p><p class="material-symbols-outlined">chat</p>
        <p class="message"><b>Jordan (12/5 @ 12:00pm):</b><br style="line-height: 0px;"> Hey! Lets pick a destination.</p>
        <p class="message"><b>Lachlan (12/5 @ 12:02pm):</b><br style="line-height: 0px;">Okay sounds good!</p>
        <p class="message"><b>Blake (12/5 @ 12:03pm):</b><br style="line-height: 0px;">Lets add them to the Group Favourite List.</p>
        <p class="message"><b>Lucy (12/5 @ 12:05pm):</b><br style="line-height: 0px;">Good idea!</p>

        <form>
            <input type="text" id="sendMessage" name="sendMessage" placeholder="Aa">
            <button class="material-symbols-outlined">send</button>
        </form>
    </div>

    <div class="faveList">
        <p style="font-size: 25px; display:inline-block;">Group Favourites</p><p class="material-symbols-outlined">favorite</p>
        <div class="faveFlight">
          <p class="faveInfo">To <b>Bali</b> @ $200
          <img src="${pageContext.request.contextPath}/images/bali.png" alt="Bali" class="baliSmallLogo" >
          </p>

          <form style="text-align: right;">
            <button class="material-symbols-outlined">arrow_upward</button>
            <button class="material-symbols-outlined">arrow_downward</button>
            <button class="material-symbols-outlined">lock</button>
            <button class="material-symbols-outlined">block</button>
            <button>View flight</button>
          </form>

        </div>
         <div class="faveFlight">
              <p class="faveInfo">To <b>Thailand</b> @ $215
              <img src="${pageContext.request.contextPath}/images/thailand.png" alt="Thailand" class="thailandSmallLogo" >
              </p>
              <form style="text-align: right;">
                <button class="material-symbols-outlined">arrow_upward</button>
                <button class="material-symbols-outlined">arrow_downward</button>
                <button class="material-symbols-outlined">lock</button>
                <button class="material-symbols-outlined">block</button>
                <button>View flight</button>
              </form>

         </div>
         <div class="faveFlight">
               <p class="faveInfo">To <b>Fiji</b> @ $150
               <img src="${pageContext.request.contextPath}/images/fiji.png" alt="Fiji" class="fijiSmallLogo" >
               </p>
               <form style="text-align: right;">
                 <button class="material-symbols-outlined">arrow_upward</button>
                 <button class="material-symbols-outlined">arrow_downward</button>
                 <button class="material-symbols-outlined">lock</button>
                 <button class="material-symbols-outlined">block</button>
                 <button>View flight</button>
               </form>

          </div>
    </div>

    <div class="groupContents2">
        <div class="pool" style="display:inline-block; float: left;">
            <p style="font-size: 20px;">Remaining Pool Amount </p> <p style="font-size: 25px;"><b>$240</b></p>
            <form name="pool" method="POST" action="MockupGroup">
                <button type="submit" name="getPool" value="getPool" class="groupButton">Go to Money Pool</button>
            </form>
        </div>

        <div class="date" style="display:inline-block; float: right;">
            <form>
                <label style="font-size: 20px;">Trip Availability</label><br>
                <input type="date">
            </form>
        </div>
    </div>
</div>

</body>
<script type="text/javascript" src="script.js"></script>
</html>