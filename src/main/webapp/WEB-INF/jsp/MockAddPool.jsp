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


 <header>
            <div class="titleContainer">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <div class="groupName">
                    <h1>Group One</h2>
                </div>
                <h2>Add To Money Pool</h1><br>
            </div>

        </header>

        <div id="addMemberFormContainer">
            <form method="POST" action="MockupGroup">
                <input type="number" size="50" id="amount" name="amount" placeholder="Enter valid amount"><br>

                <button type="submit" name="moneyAdded" value="moneyAdded" style="align: left;">Cancel</button>
                <button type="submit" name="moneyAdded" value="moneyAdded" style="align: right;">Add Money</button>

            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>