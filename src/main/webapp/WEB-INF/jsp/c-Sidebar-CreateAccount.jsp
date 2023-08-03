<body class="AccountSettingsHomePage">
    <div class="sidebar">
        <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="logo" >
        <%--        Home page button         --%>
        <form name="returnHome" action="Homepage" method="POST">
            <button type="submit" class="button" name="home" value="true">Return to Home</button>
        </form>
    </div>
</body>