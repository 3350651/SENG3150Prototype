<%@ page import="startUp.FlightBean" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Passeger Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/passengerDetails.css">
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
        <form name="test" action="createBooking" method="POST">
            <%int passengers=(int) request.getAttribute("passengers");%>
                <input type="hidden" name="options" value="true">
                <input type="hidden" name="passengers" value=<%=passengers%>>
                <%for(int i=1; i<=passengers; i++){ %>

                    <fieldset class="filled">
                        <h3>Passenger <%=i%>
                        </h3>
                        <h3>Personal Details</h3>
                        <label for=<%="title" +i%>>Title: </label>
                        <select name=<%="title" +i%> id=<%="title"+i%>>
                                <option value="">Please Select---</option>
                                <option value="Mr">Mr</option>
                                <option value="Mrs">Mrs</option>
                                <option value="Ms">Ms</option>
                                <option value="">Prefer not to say</option>
                        </select>

                        <label for=<%="fName" +i%>>Given Name(s): </label>
                        <input type="text" name=<%="fName" +i%> id=<%="fName"+i%> />

                            <label for=<%="lName" +i%>>Family Name: </label>
                            <input type="text" name=<%="lName" +i%> id=<%="lName"+i%> />
                                <br />
                                <label for=<%="email" +i%>>Email: </label>
                                <input type="email" name=<%="email"+i%> id=<%="email"+i%> />
                                    <br />
                                    <label for=<%="mobile" +i%>>Mobile Number: </label>
                                    <input type="text" name=<%="mobile" +i%> id=<%="mobile"+i%> />
                                        <br />
                                        <label for=<%="dob" +i%>>Date of Birth: </label>
                                        <input type="date" name=<%="dob" +i%> id=<%="dob"+i%> />
                                            <br />

                                            <h3>Ticket Details</h3>
                                            <div>
                                                <h4>Select Class:</h4>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClass" +i%> id=<%="first"+i%>
                                                        value="FIR" />
                                                        <label for=<%="first" +i%>>First Class: <br />$1000</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClass" +i%> id=<%="business"+i%>
                                                        value="BUS" />
                                                        <label for=<%="business" +i%>>Business Class: <br />$800</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClass" +i%> id=<%="premEco"+i%>
                                                        value="PME" />
                                                        <label for=<%="premEco" +i%>>Premium Economy Class:
                                                            <br />$600</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClass" +i%> id=<%="eco"+i%>
                                                        value="ECO"/>
                                                        <label for=<%="eco" +i%>>Economy Class:<br />$500</label>
                                                </div>
                                            </div>
                                            <br />
                                            <br />
                                            <h4>Select Package:</h4>

                                            <div class="radioButton">

                                                <input type="radio" name=<%="ticketType" +i%> id=<%="standard"+i%>
                                                    value="D" />
                                                    <label for=<%="standard" +i%>>Standard: <br />+$0</label>
                                            </div>

                                            <div class="radioButton">

                                                <input type="radio" name=<%="ticketType" +i%> id=<%="premium"+i%>
                                                    value="E" />
                                                    <label for=<%="premium" +i%>>Premium: <br />+$50</label>
                                            </div>

                                            <div class="radioButton">

                                                <input type="radio" name=<%="ticketType" +i%> id=<%="platinum"+i%>
                                                    value="G" />
                                                    <label for=<%="platinum" +i%>>Platinum: <br />+$100</label>
                                            </div>

                                            <%FlightBean returnFlight=(FlightBean) request.getAttribute("returnFlight");
                                                if(returnFlight !=null){%>
                                                <h4>Select Return Class:</h4>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClassReturn" +i%> id=
                                                    <%="firstReturn"+i%>
                                                        value="FIR" />
                                                        <label for=<%="first" +i%>>First Class: <br />$1000</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClassReturn" +i%> id=
                                                    <%="businessReturnReturn"+i%>
                                                        value="BUS" />
                                                        <label for=<%="businessReturn" +i%>>Business Class:
                                                            <br />$800</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClassReturn" +i%> id=
                                                    <%="premEcoReturn"+i%>
                                                        value="PME />
                                                        <label for=<%="premEcoReturn" +i%>>Premium Economy Class:
                                                            <br />$600</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketClassReturn" +i%> id=
                                                    <%="ecoReturn"+i%>
                                                        value="ECO"/>
                                                        <label for=<%="ecoReturn" +i%>>Economy Class:<br />$500</label>
                                                </div>
                                                </div>
                                                <br />
                                                <br />
                                                <h4>Select Return Package:</h4>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketTypeReturn" +i%> id=
                                                    <%="standardReturn"+i%>
                                                        value="D" />
                                                        <label for=<%="standardReturn" +i%>>Standard: <br />+$0</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketTypeReturn" +i%> id=
                                                    <%="premiumReturn"+i%>
                                                        value="E" />
                                                        <label for=<%="premiumReturn" +i%>>Premium: <br />+$50</label>
                                                </div>

                                                <div class="radioButton">

                                                    <input type="radio" name=<%="ticketTypeReturn" +i%> id=
                                                    <%="platinumReturn"+i%>
                                                        value="G" />
                                                        <label for=<%="platinumReturn" +i%>>Platinum:
                                                            <br />+$100</label>
                                                </div>
                                                <%}%>

                    </fieldset>
                    <br />
                    <%}%>

                        <button class="button" id="submit" type="submit">Submit</button>
        </form>
    </main>
</body>

</html>