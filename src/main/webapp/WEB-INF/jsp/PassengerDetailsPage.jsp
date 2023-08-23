<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.UserBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.BookingBean" %>
<%@ page import="java.util.ArrayList" %>

<% FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight"); %>
<% LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList"); %>
<% LinkedList<FlightBean> returnFlightList = (session.getAttribute("returnFlightList") != null ? (LinkedList<FlightBean>) session.getAttribute("returnFlightList") : null); %>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<% boolean avail = true;%>
<% int passengers = (int) session.getAttribute("passengers"); %>
<% int returnPassengers = (int) session.getAttribute("numReturnPassengers"); %>
<% LinkedList<BookingBean> bookings = (LinkedList<BookingBean>) session.getAttribute("bookings"); %>

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
            <label for='<%="title" +i%>false'>Title: </label>
            <select name='<%="title" +i%>false' id='<%="title" +i%>false' required="true">
                <option value="">Please Select---</option>
                <option value="Mr">Mr</option>
                <option value="Mrs">Mrs</option>
                <option value="Ms">Ms</option>
                <option value="">Prefer not to say</option>
            </select>

            <label for='<%="fName" +i%>false'>Given Name(s): </label>
            <input type="text" name='<%="fName" +i%>false' id='<%="fName" +i%>false' />


            <label for='<%="lName" +i%>false'>Family Name: </label>
            <input type="text" name='<%="lName" +i%>false' id='<%="lName" +i%>false' required="true"/>
            <br />
            <br />

            <label for='<%="email" +i%>false'>Email: </label>
            <input type="email" name='<%="email" +i%>false' id='<%="email" +i%>false' required="true"/>
            <br />
            <br />

            <label for='<%="mobile" +i%>false'>Mobile Number: </label>
            <input type="text" name='<%="mobile" +i%>false' id='<%="mobile" +i%>false' required="true"/>
            <br />
            <br />

            <label for='<%="dob" +i%>false'>Date of Birth: </label>
            <input type="date" name='<%="dob" +i%>false' id='<%="dob" +i%>false' />
            <br />
            <br />
        </fieldset>
        <br />
        <% } // end for loop on passengers%>

        <% if (session.getAttribute("returnFlightList") != null) {%>
            <div class="flightDetailsColumnCenter">
                <h1><%= returnFlightList.get(0).getDeparture().getDestinationName() %> - <%= returnFlightList.get(returnFlightList.size() - 1).getDestination().getDestinationName() %></h1>
            </div>

            <%for(int i=1; i<=returnPassengers; i++){ %>
            <fieldset class="filled">
                    <h3>Passenger <%=i%></h3>
                    <h3>Personal Details</h3>
                <label for='<%="title" +i%>true'>Title: </label>
                <select name='<%="title" +i%>true' id='<%="title" +i%>true' required="true">
                    <option value="">Please Select---</option>
                    <option value="Mr">Mr</option>
                    <option value="Mrs">Mrs</option>
                    <option value="Ms">Ms</option>
                    <option value="">Prefer not to say</option>
                </select>

                <label for='<%="fName" +i%>true'>Given Name(s): </label>
                <input type="text" name='<%="fName" +i%>true' id='<%="fName" +i%>true' />


                <label for='<%="lName" +i%>true'>Family Name: </label>
                <input type="text" name='<%="lName" +i%>true' id='<%="lName" +i%>true' required="true"/>
                <br />
                <br />

                <label for='<%="email" +i%>true'>Email: </label>
                <input type="email" name='<%="email" +i%>true' id='<%="email" +i%>true' required="true"/>
                <br />
                <br />

                <label for='<%="mobile" +i%>true'>Mobile Number: </label>
                <input type="text" name='<%="mobile" +i%>true' id='<%="mobile" +i%>true' required="true"/>
                <br />
                <br />

                <label for='<%="dob" +i%>true'>Date of Birth: </label>
                <input type="date" name='<%="dob" +i%>true' id='<%="dob" +i%>true' />
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