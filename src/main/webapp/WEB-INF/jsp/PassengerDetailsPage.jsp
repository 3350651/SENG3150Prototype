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
            <form class="backButton">
                <button>Back</button>
            </form>
            <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png" alt="FlightPub Logo"
                class="centreLogo">
            <h1>Passenger Details</h1>
            <br />
            <label for="progress">
                <h2>Progress</h2>
            </label>
            <div class="outerProgress">
                <div class="innerProgress" id="progress" style="width:66%">66%</div>
            </div>
        </header>
        <form name="test" action="PassengersToReview" method="POST">
            <fieldset class="filled">
                <h3>Passenger 1</h3>
                <h3>Personal Details</h3>
                <label for="title">Title: </label>
                <select name="title" id="title">
                    <option value="">Please Select---</option>
                    <option value="Mr">Mr</option>
                    <option value="Mrs">Mrs</option>
                    <option value="Ms">Ms</option>
                    <option value="">Prefer not to say</option>
                </select>

                <label for="fName">Given Name(s): </label>
                <input type="text" name="fName" id="fName" />

                <label for="lName">Family Name: </label>
                <input type="text" name="lName" id="lName" />
                <br />
                <label for="email">Email: </label>
                <input type="email" name="email" id="email" />
                <br />
                <label for="mobile">Mobile Number: </label>
                <input type="text" name="mobile" id="mobile" />
                <br />

                <h3>Ticket Details</h3>
                <div>
                    <h4>Select Class:</h4>

                    <div class="radioButton">
                        <label for="first">
                            <input type="radio" name="ticketClass" id="first" value="first" />
                            First Class: <br />$1000</label>
                    </div>

                    <div class="radioButton">
                        <label for="business">
                            <input type="radio" name="ticketClass" id="business" value="business" />
                            Business Class: <br />$800</label>
                    </div>

                    <div class="radioButton">
                        <label for="premEco">
                            <input type="radio" name="ticketClass" id="premEco" value="premEco" />
                            Premium Economy Class: <br />$600</label>
                    </div>

                    <div class="radioButton">
                        <label for="eco">
                            <input type="radio" name="ticketClass" id="eco" value="eco" />
                            Economy Class:<br />$500</label>
                    </div>
                </div>
                <h4>Select Package:</h4>

                <div class="radioButton">
                    <label for="standard">
                        <input type="radio" name="ticketType" id="standard" value="standard" />
                        Standard: <br />+$0</label>
                </div>

                <div class="radioButton">
                    <label for="premium">
                        <input type="radio" name="ticketType" id="premium" value="premium" />
                        Premium: <br />+$50</label>
                </div>

                <div class="radioButton">
                    <label for="platinum">
                        <input type="radio" name="ticketType" id="platinum" value="platinum" />
                        Platinum: <br />+$100</label>
                </div>

            </fieldset>
            <br />
            <fieldset class="filled">
                <h3>Passenger 2</h3>
                <h3>Personal Details</h3>
                <label for="title2">Title: </label>
                <select name="title" id="title2">
                    <option value="">Please Select---</option>
                    <option value="Mr">Mr</option>
                    <option value="Mrs">Mrs</option>
                    <option value="Ms">Ms</option>
                    <option value="">Prefer not to say</option>
                </select>

                <label for="fName2">Given Name(s): </label>
                <input type="text" name="fName" id="fName2" />

                <label for="lName2">Family Name: </label>
                <input type="text" name="lName" id="lName2" />
                <br />
                <label for="email2">Email: </label>
                <input type="email" name="email" id="email2" />
                <br />
                <label for="mobile2">Mobile Number: </label>
                <input type="text" name="mobile" id="mobile2" />
                <br />

                <h3>Ticket Details</h3>
                <div>
                    <h4>Select Class:</h4>

                    <div class="radioButton">
                        <label for="first2">
                            <input type="radio" name="ticketClass" id="first2" value="first" />
                            First Class: <br />$1000</label>
                    </div>

                    <div class="radioButton">
                        <label for="business2">
                            <input type="radio" name="ticketClass" id="business2" value="business" />
                            Business Class: <br />$800</label>
                    </div>

                    <div class="radioButton">
                        <label for="premEco2">
                            <input type="radio" name="ticketClass" id="premEco2" value="premEco" />
                            Premium Economy Class: <br />$600</label>
                    </div>

                    <div class="radioButton">
                        <label for="eco2">
                            <input type="radio" name="ticketClass" id="eco2" value="eco" />
                            Economy Class:<br />$500</label>
                    </div>
                </div>
                <h4>Select Package:</h4>

                <div class="radioButton">
                    <label for="standard2">
                        <input type="radio" name="ticketType" id="standard2" value="standard" />
                        Standard: <br />+$0</label>
                </div>

                <div class="radioButton">
                    <label for="premium2">
                        <input type="radio" name="ticketType" id="premium2" value="premium" />
                        Premium: <br />+$50</label>
                </div>

                <div class="radioButton">
                    <label for="platinum2">
                        <input type="radio" name="ticketType" id="platinum2" value="platinum" />
                        Platinum: <br />+$100</label>
                </div>

            </fieldset>
            <button class="button" id="submit" type="submit">Submit</button>
        </form>
    </main>
</body>

</html>