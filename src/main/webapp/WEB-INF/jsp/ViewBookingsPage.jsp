<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <title>View Bookings</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <main>
        <header>
            <form name="BackToHome" action="login" method="GET">
                <button type="submit" class="button" name="home" value="backToHome">Home</button>
            </form>
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo"
                class="centreLogo">
            <h1>Bookings</h1>
        </header>
       <jsp:include page="c-BookingCardList.jsp"></jsp:include>
    </main>
</body>

</html>