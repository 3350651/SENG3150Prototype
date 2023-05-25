<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <title>Booking Details</title>
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
            <h1>
                Review Booking Details
            </h1>
            <br />
            <label for="progress">
                <h2>Progress</h2>
            </label>
            <div class="outerProgress">
                <div class="innerProgress" id="progress" style="width:99%">99%</div>
            </div>
        </header>
        <jsp:include page="c-BookingDetails.jsp"></jsp:include>
        <br />
        <fieldset class="filled">
            <h3>Payment Details:</h3>
            <form method="POST" action="createBooking">
                <input type="hidden" name="payment" value="true">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" />
                <label for="expiry">Expiry Date:</label>
                <input type="text" id="expiry" />
                <br />
                <label for="security">Security Number:</label>
                <input type="text" id="security" />
                <br />
                <button type="submit" class="button">Submit</button>
            </form>
        </fieldset>

    </main>
</body>

</html>