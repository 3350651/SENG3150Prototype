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
           <form name="backToManageGroup" action="MockupGroup" method="POST" class="backButton">
                   <button type="submit" name="memberRemoved" value="true">Return to Manage Group</button>
           </form>

            <div class="titleContainer">
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <div class="groupName">
                    <h1>Group One</h2>
                </div>
                <h2>Remove Group Member</h1><br>
            </div>

        </header>

        <div class="removeMember">
            <div class="member">
                Member: <b>Jordan Eade</b><br style="line-height: 0px;">
                id: <b>16738923</b>
                <form>
                    <button>Remove Member</button>
                </form>
            </div>
            <div class="member">
                Member: <b>Blake Baldin</b><br style="line-height: 0px;">
                id: <b>15297834</b>
                <form>
                    <button>Remove Member</button>
                </form>
            </div>
            <div class="member">
                Member: <b>Lachlan O&#39Neill</b><br style="line-height: 0px;">
                id: <b>14368795</b>
                <form>
                    <button>Remove Member</button>
                </form>
            </div>
            <div class="member">
                Member: <b>Lucy Knight</b><br style="line-height: 0px;">
                id: <b>11258975</b>
                <form>
                    <button>Remove Member</button>
                </form>
            </div>

        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>