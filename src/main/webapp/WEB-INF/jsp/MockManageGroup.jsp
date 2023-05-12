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
                <h1>Manage Group</h1>
            </div>
            <div class="groupName">
                <h2>Group One</h2><br>
            </div>
        </header>

        <div class="manageGroupContent">
        <div>
           <form name="addMember" action="MockupGroup" method="POST">
                  <button type="submit" name="addMember" value="addMember" class="groupButton">Add Member</button>
           </form>
        </div>
        <div>
           <form name="removeMember" action="MockupGroup" method="POST">
                 <button type="submit" name="removeMember" value="removeMember" class="groupButton">Remove Member</button>
           </form>
        </div>
        <div>
           <form name="deleteGroup" action="MockupGroup" method="POST">
                 <button type="submit" name="deleteGroup" value="deleteGroup" class="groupButton">Delete Group</button>
           </form>
        </div>
        </div>


    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>