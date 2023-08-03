<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%
  UserBean user = (UserBean) session.getAttribute("userBean");
  LinkedList<FlightBean> bookmarkedFlights = new LinkedList<>();
  if (user != null && user.getBookmarkedFlights() != null) {
    bookmarkedFlights = user.getBookmarkedFlights();
}
%>

<body class="AccountSettingsHomePage">
    <div class="sidebar">
        <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
        <%--        Home page button         --%>
        <form name="returnHome" action="Homepage" method="POST">
            <button type="submit" class="button" name="home" value="true">Return to Home</button>
        </form>
        <%--        Account Settings page button         --%>
        <form name="goToAccountSettings" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="viewAccountSettings" value="viewAccountSettings">Return to Account Details</button>
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
        <%--        Modify Favourited Destinations button         --%>
        <form name="goToModifyFavouritedDestinations" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToModifyFavouritedDestinations" value="goToModifyFavouritedDestinations">Modify Favourited Destinations</button>
        </form>
        <%--        Modify Saved Searches button         --%>
        <form name="goToModifySavedSearches" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToModifySavedSearches" value="goToModifySavedSearches">Modify Saved Searches</button>
        </form>
        <%--        Complete Questionnaire button         --%>
        <form name="goToQuestionnaire" action="AccountSettings" method="POST">
            <button type="submit" class="button" name="goToQuestionnaire" value="goToQuestionnaire">Complete Questionnaire</button>
        </form>
    </div>
</body>