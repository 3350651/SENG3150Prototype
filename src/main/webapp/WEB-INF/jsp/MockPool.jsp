<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <main>
        <header>
           <form name="backToGroup" action="MockupGroup" method="POST" class="backButton">
                   <button type="submit" name="backToGroup" value="true">Return to Group Homepage</button>
           </form>

            <div class="titleContainer">
             <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <br style="line-height: 5px;">
                <div class="groupName">
                    <h1>Group One</h1>
                </div>
                <h2>Money Pool</h2><br>
            </div>

        </header>

    <div class="moneyPool">
        <div>
            <p style="font-size: 20px;">Money Pool Total<br style="line-height: 0px;"><b>$3,500</b></p>
            <p style="font-size: 20px;">Required Amount Remaining<br style="line-height: 0px;"><b>$240</b></p>
        </div>

        <div>
            <form name="addPool" method="POST" action="MockupGroup">
                   <button class="groupButton">Withdraw From Pool</button>
                   <button type="submit" name="addPool" value="addPool" class="groupButton">Add To Pool</button>
            </form>
        </div>
    </div>
    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>