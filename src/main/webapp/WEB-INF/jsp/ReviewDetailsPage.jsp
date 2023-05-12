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
            <h1>
                Review Booking Details
            </h1>
        </header>

        <fieldset class="review">
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

        <fieldset class="review">
            <h3>Passenger Details:</h3>
            <fieldset>
                <legend>Passenger 1</legend>
                <p class="reviewDetails">
                    <strong>Name: </strong>Mr John Barry Smith<br />
                    <strong>Email: </strong>johnSmith@gmail.com<br />
                    <strong>Mobile Number: </strong>0412 123 123
                </p>
            </fieldset>
            <fieldset>
                <legend>Passenger 2</legend>
                <p class="reviewDetails">
                    <strong>Name: </strong>Mr John Barry Smith<br />
                    <strong>Email: </strong>johnSmith@gmail.com<br />
                    <strong>Mobile Number: </strong>0412 123 123
                </p>
            </fieldset>

        </fieldset>
        <br />
        <fieldset class="review">
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