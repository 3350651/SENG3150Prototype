<%@ page import="startUp.GroupFaveFlightBean" %>
    <%@ page import="startUp.SearchBean" %>
        <%@ page import="startUp.UserBean" %>
            <%@ page import="startUp.DestinationBean" %>
                <%@ page import="java.util.LinkedList" %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <% GroupFaveFlightBean flight = (GroupFaveFlightBean) session.getAttribute("faveFlight");%>

                        <head>
                            <meta charset="UTF-8">
                            <title>View Group Favourite Flight</title>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                        </head>

                        <body>
                            <main>
                                <header>
                                    <form class="backButton">
                                        <button>Back</button>
                                    </form>
                                    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                                        alt="FlightPub Logo" class="centreLogo">
                                    <h1>
                                        <%= flight.getFlight(flight.getAirlineCode(), flight.getFlightName(), flight.getFlightTime()).getDeparture().getDestinationName()%> To <%=
                                                flight.getFlight(flight.getAirlineCode(), flight.getFlightName(), flight.getFlightTime()).getDestination().getDestinationName()%>
                                    </h1>
                                    <br />
                                    <label for="progress">
                                        <h2>Progress</h2>
                                    </label>
                                    <div class="outerProgress">
                                        <div class="innerProgress" id="progress" style="width:33%">33%</div>
                                    </div>
                                </header>

                                <table>
                                    <tr>
                                        <!-- TODO: figure out how to get images from the destination -->
                                        <td class="filledSection"><img
                                                src="${pageContext.request.contextPath}/images/brisbaneCity.jpg"
                                                alt="Destination Image" width="250px" height="auto"
                                                class="destinationImage">
                                        </td>
                                        <td class="filledSection">
                                            <div class="mainFlightDetailCell">
                                                <h3>Flight Details:</h3>
                                                <p class="flightDetails">

                                                    <strong>Airline: </strong>
                                                    <%=flight.getAirlineName()%>

                                                        <br />
                                                        <strong>Departure Time:</strong>
                                                        <%=flight.getFlightTime()%>

                                                            <br />
                                                            <strong>Flight Name:</strong>
                                                            <%=flight.getFlightName()%>

                                                                <br />
                                                                <strong>Plane Model:</strong>
                                                                <%=flight.getFlight(flight.getAirlineCode(), flight.getFlightName(), flight.getFlightTime()).getPlaneType()%>
                                                                    <br />
                                                                    <h3>Minimum price: <%=flight.getFlight(flight.getAirlineCode(), flight.getFlightName(), flight.getFlightTime()).getMinCost()%>
                                                                    </h3>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="filledSection">
                                            <p><strong>Tags:</strong>
                                                <%LinkedList<String> tags = flight.getFlight(flight.getAirlineCode(), flight.getFlightName(), flight.getFlightTime()).getDestination().getTags();
                                                    if(tags != null){
                                                    for(String tag: tags){
                                                    if(tag != tags.getLast()){
                                                    %>
                                                    <%=tag +", "%>

                                <%}
                            </main>
                        </body>

                    </html>