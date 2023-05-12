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


 <header>
            <div class="titleContainer">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <div class="groupName">
                    <h1>Group One</h2>
                </div>
                <h2>Add Group Member</h1><br>
            </div>

        </header>

        <div id="addMemberFormContainer">
            <form method="POST" action="MockupGroup" onsubmit="return addMemberForm()">
                <input type="text" size="50" id="userEmail" name="userEmail" placeholder="Enter User Email"><br>

                <button type="submit" name="memberAdded" value="memberAdded" style="align: left;">Cancel</button>
                <button type="submit" name="memberAdded" value="memberAdded" style="align: right;">Add Member</button>

            </form>
        </div>
        </main>
    </body>
<script type="text/javascript" src="script.js"></script>
</html>