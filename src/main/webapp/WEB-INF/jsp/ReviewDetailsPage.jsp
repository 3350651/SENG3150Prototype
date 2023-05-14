<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <title>startUp.FlightDetailsPage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <main>
        <header>
            <form name="BackToHome" action="login" method="GET">
                <%-- <button type="submit" class="button" name="home" value="simpleSearch">Simple Search</button> --%>
                <button type="submit" class="button" name="home" value="backToHome">Home</button>
            </form>
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo" class="centreLogo" >
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

        <fieldset class="filled">
            <h3>Flight Details:</h3>

            <p class="reviewDetails">
                <strong>Airline: </strong>American Airlines

                <br />
                <strong>Departure Time:</strong> 11:50 am 11/05/2014

                <br />
                <strong>Flight Name:</strong> F1375

                <br />
                <strong>Plane Model:</strong> A380
            </p>
        </fieldset>

        <br />

        <fieldset class="background">
            <h3>Passenger Details:</h3>
            <fieldset class="foreground">
                <h3>Passenger 1</h3>
                <p class="reviewDetails">
                    <strong>Name: </strong>Mr John Barry Smith<br />
                    <strong>Email: </strong>johnSmith@gmail.com<br />
                    <strong>Mobile Number: </strong>0412 123 123
                </p>
            </fieldset>
            <fieldset class="foreground">
                <h3>Passenger 2</h3>
                <p class="reviewDetails">
                    <strong>Name: </strong>Mr John Barry Smith<br />
                    <strong>Email: </strong>johnSmith@gmail.com<br />
                    <strong>Mobile Number: </strong>0412 123 123
                </p>
            </fieldset>

        </fieldset>
        <br />
        <fieldset class="filled">
            <h3>Payment Details:</h3>
            <form>
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