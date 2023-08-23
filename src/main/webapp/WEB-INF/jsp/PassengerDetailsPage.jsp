<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.UserBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.BookingBean" %>
<%@ page import="java.util.ArrayList" %>

<% FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight"); %>
<% LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList"); %>
<% FlightPathBean returnFlightPath = (FlightPathBean) session.getAttribute("returnFlight"); %>
<% LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList"); %>
<% //LinkedList<FlightBean> returnFlightList = (session.getAttribute("returnFlightList") != null ? (LinkedList<FlightBean>) session.getAttribute("returnFlightList") : null); %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<% boolean avail = true;%>
<% int passengers = (int) session.getAttribute("passengers"); %>
<% boolean hasReturn = (boolean) session.getAttribute("hasReturn"); %>
<% int returnPassengers = (int) session.getAttribute("numReturnPassengers");  %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Passenger Details</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/passengerDetails.css">
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
        <h1>Passenger Details</h1>
        <br />
        <label for="progress">
            <h2>Progress</h2>
        </label>
        <div class="outerProgress">
            <div class="innerProgress" id="progress" style="width:66%">66%</div>
        </div>
    </header>
    <% if (!avail) { %>
    Sorry, no seats available
    <% } else if (avail){%>

    <form name="passengerDetails" action="createBooking" method="POST">
        <input type="hidden" name="options" value="true">
        <input type="hidden" name="passengers" value=<%=passengers%>>
        <br />

        <div class="flightDetailsColumnCenter">
            <h1><%= flightList.get(0).getDeparture().getDestinationName() %> - <%= flightList.get(flightList.size() - 1).getDestination().getDestinationName() %></h1>
        </div>
        <%for(int i=1; i<=passengers; i++){ %>
            <fieldset class="filled">

                <h3>Passenger <%=i%></h3>
                <h3>Personal Details</h3>
                <label for='<%="titlefalse" +i%>'>Title: </label>
                <select name='<%="titlefalse" +i%>' id='<%="titlefalse" +i%>' required="true">
                    <option value="">Please Select---</option>
                    <option value="Mr">Mr</option>
                    <option value="Mrs">Mrs</option>
                    <option value="Ms">Ms</option>
                    <option value="">Prefer not to say</option>
                </select>

                <label for='<%="fNamefalse" +i%>'>Given Name(s): </label>
                <input type="text" name='<%="fNamefalse" +i%>' id='<%="fNamefalse" +i%>' required="true"/>


                <label for='<%="lNamefalse" +i%>'>Family Name: </label>
                <input type="text" name='<%="lNamefalse" +i%>' id='<%="lNamefalse" +i%>' required="true"/>
                <br />
                <br />

                <label for='<%="emailfalse" +i%>'>Email: </label>
                <input type="email" name='<%="emailfalse" +i%>' id='<%="emailfalse" +i%>' required="true"/>
                <br />
                <br />

                <label for='<%="mobilefalse" +i%>'>Mobile Number: </label>
                <input type="text" name='<%="mobilefalse" +i%>' id='<%="mobilefalse" +i%>' required="true"/>
                <br />
                <br />

                <label for='<%="dobfalse" + i%>'>Date of Birth: </label>
                <input type="date" name='<%="dobfalse" + i%>' id='<%="dobfalse" + i%>' required ='true'/>
                <br />
                <br />
            </fieldset>
            <br />
        <% } // end for loop on passengers%>

        <% if (hasReturn) {%>
            <div class="flightDetailsColumnCenter">
                <h1><%= returnFlightList.get(0).getDeparture().getDestinationName() %> - <%= returnFlightList.get(returnFlightList.size() - 1).getDestination().getDestinationName() %></h1>
            </div>

            <%for(int i=1; i<=returnPassengers; i++){ %>
            <fieldset class="filled">
                    <h3>Passenger <%=i%></h3>
                    <h3>Personal Details</h3>
                <label for='<%="titletrue" +i%>'>Title: </label>
                <select name='<%="titletrue" +i%>' id='<%="titletrue" +i%>' required="true">
                    <option value="">Please Select---</option>
                    <option value="Mr">Mr</option>
                    <option value="Mrs">Mrs</option>
                    <option value="Ms">Ms</option>
                    <option value="">Prefer not to say</option>
                </select>

                <label for='<%="fNametrue" +i%>'>Given Name(s): </label>
                <input type="text" name='<%="fNametrue" +i%>' id='<%="fNametrue" +i%>' />


                <label for='<%="lNametrue" +i%>'>Family Name: </label>
                <input type="text" name='<%="lNametrue" +i%>' id='<%="lNametrue" +i%>' required="true"/>
                <br />
                <br />

                <label for='<%="emailtrue" +i%>'>Email: </label>
                <input type="email" name='<%="emailtrue" +i%>' id='<%="emailtrue" +i%>' required="true"/>
                <br />
                <br />

                <label for='<%="mobiletrue" +i%>'>Mobile Number: </label>
                <input type="text" name='<%="mobiletrue" +i%>' id='<%="mobiletrue" +i%>' required="true"/>
                <br />
                <br />

                <label for='<%="dobtrue" +i%>'>Date of Birth: </label>
                <input type="date" name='<%="dobtrue" +i%>' id='<%="dobtrue" +i%>' />
                <br />
                <br />

            </fieldset>
            <br />
            <% } //end for loop return passengers %>
        <% } //end if return exists %>
        <br />
        <button class="button" name="options" id="options" type="submit">Submit</button>
    </form>
    <% } // end if available %>
</main>

</body>

</html>