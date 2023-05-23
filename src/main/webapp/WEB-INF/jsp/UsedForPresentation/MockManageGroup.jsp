<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">
</head>
<body>
    <main>
        <header>

           <form name="backToGroup" action="MockupGroup" method="POST" class="backButton">
                   <button type="submit" name="backToGroup" value="true">Return to Group Homepage</button>
           </form>

            <div class="titleContainer">
                <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="groupLogo" >
                <div class="groupName">
                    <h1>Group One</h1>
                </div>
                <h2>Manage Group</h2><br>
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
                 <button type="submit" name="other" value="other" class="groupButton">Delete Group</button>
           </form>
        </div>
        <div>
           <form name="other" action="MockupGroup" method="POST">
                 <button type="submit" name="other" value="other" class="groupButton">Complete Questionnaire</button>
           </form>
        </div>
        <div>
           <form name="other" action="MockupGroup" method="POST">
                 <button type="submit" name="other" value="other" class="groupButton">Modify Tags</button>
           </form>
        </div>
        </div>


    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>