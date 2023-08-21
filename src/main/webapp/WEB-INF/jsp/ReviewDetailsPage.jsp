<% float price = (float) session.getAttribute("price"); %>
<% String priceString = String.valueOf(price); %>

<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <title>Booking Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/scripts/script.js"></script>
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
            <form name="paymentForm" action="createBooking" onsubmit="return validateCardForm()" method="POST">
                <input type="hidden" name="payment" value="true">
                Card Number: <input type="text" name="cardNumber" required="true">
                Expiry Date (MM/YY): <input type="text" name="expiry" required="true">
                Security Number: <input type="text" name="security" required="true">
                <button type="submit" class="button">Submit</button>
            </form>
        </fieldset>

    </main>
</body>

</html>