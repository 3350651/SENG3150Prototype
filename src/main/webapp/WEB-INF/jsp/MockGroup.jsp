<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<body class="MockGroupHomepage">
<form class="backButton">
    <button>Back to Homepage</button>
</form>
<div class="groupHeading">
    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
    <br style="line-height: 5px;">
    <h1>Group One</h1>
</div>
<br>

<div class="manageGroup">
    <form name="manageGroup" method="POST" action="MockupGroup">
        <button type="submit" name="manageGroup" value="manageGroup" class="groupButton">Manage Group</button>
    </form>

</div>

<div class="search">
    Search Bar to go here.
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
          <p class="faveInfo">To <b>Bali</b> @ $200</p>
          <form style="text-align: right;">
            <button class="material-symbols-outlined">arrow_upward</button>
            <button class="material-symbols-outlined">arrow_downward</button>
            <button class="material-symbols-outlined">lock</button>
            <button class="material-symbols-outlined">block</button>
            <button>View flight</button>
          </form>

        </div>
         <div class="faveFlight">
              <p class="faveInfo">To <b>Thailand</b> @ $215</p>
              <form style="text-align: right;">
                <button class="material-symbols-outlined">arrow_upward</button>
                <button class="material-symbols-outlined">arrow_downward</button>
                <button class="material-symbols-outlined">lock</button>
                <button class="material-symbols-outlined">block</button>
                <button>View flight</button>
              </form>

         </div>
         <div class="faveFlight">
               <p class="faveInfo">To <b>Fiji</b> @ $150</p>
               <form style="text-align: right;">
                 <button class="material-symbols-outlined">arrow_upward</button>
                 <button class="material-symbols-outlined">arrow_downward</button>
                 <button class="material-symbols-outlined">lock</button>
                 <button class="material-symbols-outlined">block</button>
                 <button>View flight</button>
               </form>

          </div>
    </div>

    <div class="pool">
        <p style="font-size: 20px;">Remaining Pool Amount </p> <p style="font-size: 25px;"><b>$240</b></p>
        <form name="pool" method="POST" action="MockupGroup">
            <button type="submit" name="getPool" value="getPool" class="groupButton">Go to Money Pool</button>
        </form>
    </div>

</div>

</body>
<script type="text/javascript" src="script.js"></script>
</html>