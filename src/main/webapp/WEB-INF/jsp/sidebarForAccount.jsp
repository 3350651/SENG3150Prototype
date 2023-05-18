<body class="AccountSettingsHomePage">
    <div class="sidebar">
        <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
        <%--        Home page button         --%>
        <form name="returnHome" action="Homepage" method="POST">
            <button type="submit" class="button" name="home" value="true">Return to Home</button>
        </form>
        <%--        UI Preferences button         --%>
        <form name="goToUIPreferences" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToUIPreferences" value="goToUIPreferences">Modify UI Preferences</button>
        </form>
        <%--        Personal Details button         --%>
        <form name="goToPersonalDetails" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToPersonalDetails" value="goToPersonalDetails">Modify Personal Details</button>
        </form>
        <%--        Change Password button         --%>
        <form name="goToChangePassword" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToChangePassword" value="goToChangePassword">Change Password</button>
        </form>
        <%--        Modify Tag Set button         --%>
        <form name="goToModifyTags" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToModifyTags" value="goToModifyTags">Modify Tags</button>
        </form>
        <%--        Modify Bookmarked Flights button         --%>
        <form name="goToModifyBookmarkedFlights" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToModifyBookmarkedFlights" value="goToModifyBookmarkedFlights">Modify Bookmarked Flights</button>
        </form>
    </div>
</body>