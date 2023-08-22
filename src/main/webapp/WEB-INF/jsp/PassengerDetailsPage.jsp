<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.FlightPathBean" %>
<%@ page import="startUp.UserBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="startUp.BookingBean" %>
<%@ page import="java.util.ArrayList" %>

<% FlightPathBean flightPath = (FlightPathBean) session.getAttribute("flight"); %>
<% LinkedList<FlightBean> flightList = (LinkedList<FlightBean>) session.getAttribute("flightList"); %>
<% LinkedList<FlightBean> returnFlightList = (LinkedList<FlightBean>) session.getAttribute("returnFlightList");%>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<% boolean avail = true;%>
<% int passengers = (int) session.getAttribute("passengers"); %>
<% ArrayList<BookingBean> bookings = (ArrayList<BookingBean>) session.getAttribute("bookings"); %>

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
        <%for(int i=1; i<=passengers; i++){ %>

        <fieldset class="filled">
            <h3>Passenger <%=i%></h3>
            <h3>Personal Details</h3>
            <label for=<%="title" +i%>>Title: </label>
            <select name=<%="title" +i%> id=<%="title"+i%> required="true">
                <option value="">Please Select---</option>
                <option value="Mr">Mr</option>
                <option value="Mrs">Mrs</option>
                <option value="Ms">Ms</option>
                <option value="">Prefer not to say</option>
            </select>

            <label for=<%="fName" +i%>>Given Name(s): </label>
            <input type="text" name=<%="fName" +i%> id=<%="fName"+i%> />


            <label for=<%="lName" +i%>>Family Name: </label>
            <input type="text" name=<%="lName" +i%> id=<%="lName"+i%> required="true"/>
            <br />

            <label for=<%="email" +i%>>Email: </label>
            <input type="email" name=<%="email"+i%> id=<%="email"+i%> required="true"/>
            <br />

            <label for=<%="mobile" +i%>>Mobile Number: </label>
            <input type="text" name=<%="mobile" +i%> id=<%="mobile"+i%> required="true"/>
            <br />

            <label for=<%="dob" +i%>>Date of Birth: </label>
            <input type="date" name=<%="dob" +i%> id=<%="dob"+i%> />
            <br />

            <h3>Ticket Details</h3>
            <% int j = 0; for (FlightBean flight : flightList ) { %>

            <!--TICKET SELECTION-->
            <div class="flightDetailsRow">
                <div class="flightDetailsColumnLeft" style="width:auto;">
                    <button type="button" class="button" onclick="toggleVisibility('<%= flight.getFlightTime() %>', event)" style="width:auto;">
                        <%= flight.getDeparture().getDestinationName() %> - <%= flight.getDestination().getDestinationName()%>
                    </button>
                    <span id="priceFor-false-<%= flight.getFlightTime() %>" name="<%= flight.getFlightTime() %>">
                        &#x2190 Select a ticket here
                    </span>
                    <input type="hidden" name="<%= i %>-false-price-<%= flight.getFlightTime().toString() %>" class="<%= i %>falsetotal" value="">
                    <input type="hidden" name="<%= i %>-false-class-<%= flight.getFlightTime().toString() %>" value="">
                    <input type="hidden" name="<%= i %>-false-type-<%= flight.getFlightTime().toString() %>" value="">
                </div>
            </div>

                <% String[] classCodes = {"ECO", "PME", "BUS", "FIR"}; %>
                <% String[] ticketTypes = {"A", "B", "C", "D", "E", "F", "G"}; %>
                <div class="ticketSelection" id="<%= flight.getFlightTime() %>" style="display:none;">
                    <div class="flightDetailsRow" id="<%= flight.getFlightTime() %>classDiv">

                        <% for (String classCode : classCodes) {%>
                        <div class="flightDetailsColumn4">
                            <% if (classCode.equals("ECO")) {%>
                            <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">Economy</button>
                            <% } %>
                            <% if (classCode.equals("PME")) {%>
                            <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">Premium Economy</button>
                            <% } %>
                            <% if (classCode.equals("BUS")) {%>
                            <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">Business</button>
                            <% } %>
                            <% if (classCode.equals("FIR")) {%>
                            <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">First Class</button>
                            <% } %>
                        </div>
                        <% } %>
                        <!--TICKET TYPE SELECTION -->
                        <% for (String classCode : classCodes) {%>
                        <div id="<%= flight.getFlightTime() %><%= classCode %>" style="display:none">
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6Header">
                                    <% if (classCode.equals("ECO")) {%>
                                    <p class="classView"><strong>ECONOMY</strong></p>
                                    <% } %>
                                    <% if (classCode.equals("PME")) {%>
                                    <p class="classView"><strong>PREMIUM ECONOMY</strong></p>
                                    <% } %>
                                    <% if (classCode.equals("BUS")) {%>
                                    <p class="classView"><strong>BUSINESS</strong></p>
                                    <% } %>
                                    <% if (classCode.equals("FIR")) {%>
                                    <p class="classView"><strong>FIRST CLASS</strong></p>
                                    <% } %>
                                </div>
                                <div class="flightDetailsColumn6Header">
                                    <p class="classOptions">Transferable</p>
                                </div>
                                <div class="flightDetailsColumn6Header">
                                    <p class="classOptions">Refundable</p>
                                </div>
                                <div class="flightDetailsColumn6Header">
                                    <p class="classOptions">Exchangeable</p>
                                </div>
                                <div class="flightDetailsColumn6Header">
                                    <p class="classOptions">FrequentFlyerPoints</p>
                                </div>
                                <div class="flightDetailsColumn6Header">
                                    <p class="classOptions">Price</p>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">Standby</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <span class="classOptions">
                                        <button type="button" name="updatePrice" class="priceButton"
                                                onclick='selectPrice("<%= i %>", "false", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "A") %>", "<%= classCode %>", "A", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? flight.getPriceOfAvailability(classCode, "A") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">Premium Discounted</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <span class="classOptions">
                                        <button type="button" name="updatePrice" class="priceButton"
                                                onclick='selectPrice("<%= i %>", "false", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "B") %>", "<%= classCode %>", "B", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? flight.getPriceOfAvailability(classCode, "B") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">Discounted</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <span class="classOptions">
                                        <button type="button" name="updatePrice" class="priceButton"
                                                onclick='selectPrice("<%= i %>", "false", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "C") %>", "<%= classCode %>", "C", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? flight.getPriceOfAvailability(classCode, "C") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">Standard</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <span class="classOptions">
                                        <button type="button" name="updatePrice" class="priceButton"
                                                onclick='selectPrice("<%= i %>", "false", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "D") %>", "<%= classCode %>", "D", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? flight.getPriceOfAvailability(classCode, "D") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">Premium</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">-</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <span class="classOptions">
                                        <button type="button" name="updatePrice" class="priceButton"
                                                onclick='selectPrice("<%= i %>", "false", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "E") %>", "<%= classCode %>", "E", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? flight.getPriceOfAvailability(classCode, "E") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">ld</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <span class="classOptions">
                                        <button type="button" name="updatePrice" class="priceButton"
                                                onclick='selectPrice("<%= i %>", "false", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "F") %>", "<%= classCode %>", "F", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? flight.getPriceOfAvailability(classCode, "F") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="flightDetailsRow">
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">Platinum</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <p class="classOptions">&#10003</p>
                                </div>
                                <div class="flightDetailsColumn6">
                                    <span class="classOptions">
                                        <button type="button" name="updatePrice" class="priceButton"
                                                onclick='selectPrice("<%= i %>", "false", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "G") %>", "<%= classCode %>", "G", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? flight.getPriceOfAvailability(classCode, "G") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <!--END TICKET TYPE SELECTION -->
                </div>
            <!--END TICKET SELECTION-->
                <% j++; %>
            <% } %>

            <% if (session.getAttribute("returnFlightList") != null) %>
            <h3>Return Ticket Details</h3>
                <% int k = 0; for (FlightBean flight : returnFlightList ) { %>
            <!--TICKET SELECTION-->
                <div class="flightDetailsRow">
                <div class="flightDetailsColumnLeft" style="width:auto;">
                    <button type="button" class="button" onclick="toggleVisibility('<%= flight.getFlightTime() %>', event)" style="width:auto;">
                        <%= flight.getDeparture().getDestinationName() %> - <%= flight.getDestination().getDestinationName()%>
                    </button>
                    <span id="priceFor-true-<%= flight.getFlightTime() %>" name="<%= flight.getFlightTime() %>">
                        &#x2190 Select a ticket here
                    </span>
                    <input type="hidden" name="<%= i %>-true-price-<%= flight.getFlightTime().toString() %>" class="<%= i %>falsetotal" value="">
                    <input type="hidden" name="<%= i %>-true-class-<%= flight.getFlightTime().toString() %>" value="">
                    <input type="hidden" name="<%= i %>-true-type-<%= flight.getFlightTime().toString() %>" value="">
                </div>
            </div>
                <% String[] classCodes = {"ECO", "PME", "BUS", "FIR"}; %>
                <% String[] ticketTypes = {"A", "B", "C", "D", "E", "F", "G"}; %>
                <div class="ticketSelection" id="<%= flight.getFlightTime() %>" style="display:none;">
                        <div class="flightDetailsRow" id="<%= flight.getFlightTime() %>classDiv">

                        <% for (String classCode : classCodes) {%>
                            <div class="flightDetailsColumn4">
                                <% if (classCode.equals("ECO")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">Economy</button>
                                <% } %>
                                <% if (classCode.equals("PME")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">Premium Economy</button>
                                <% } %>
                                <% if (classCode.equals("BUS")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">Business</button>
                                <% } %>
                                <% if (classCode.equals("FIR")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= flight.getFlightTime() %>', '<%= classCode %>', this, event)">First Class</button>
                        <% } %>
                            </div>
                            <% } %>
                            <!--TICKET TYPE SELECTION -->
                            <% for (String classCode : classCodes) {%>
                            <div id="<%= flight.getFlightTime() %><%= classCode %>" style="display:none">
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6Header">
                                        <% if (classCode.equals("ECO")) {%>
                                        <p class="classView"><strong>ECONOMY</strong></p>
                                        <% } %>
                                        <% if (classCode.equals("PME")) {%>
                                        <p class="classView"><strong>PREMIUM ECONOMY</strong></p>
                                        <% } %>
                                        <% if (classCode.equals("BUS")) {%>
                                        <p class="classView"><strong>BUSINESS</strong></p>
                                        <% } %>
                                        <% if (classCode.equals("FIR")) {%>
                                        <p class="classView"><strong>FIRST CLASS</strong></p>
                                        <% } %>
                                    </div>
                                    <div class="flightDetailsColumn6Header">
                                        <p class="classOptions">Transferable</p>
                                    </div>
                                    <div class="flightDetailsColumn6Header">
                                        <p class="classOptions">Refundable</p>
                                    </div>
                                    <div class="flightDetailsColumn6Header">
                                        <p class="classOptions">Exchangeable</p>
                                    </div>
                                    <div class="flightDetailsColumn6Header">
                                        <p class="classOptions">FrequentFlyerPoints</p>
                                    </div>
                                    <div class="flightDetailsColumn6Header">
                                        <p class="classOptions">Price</p>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">Standby</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                            <span class="classOptions">
                                                <button type="button" name="updatePrice" class="priceButton"
                                                        onclick='selectPrice("<%= i %>", "true", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "A") %>", "<%= classCode %>", "A", event)'
                                                        <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? "" : "disabled") %> >
                                                <%= (flight.getPriceOfAvailability(classCode, "A") != -1.0 ? flight.getPriceOfAvailability(classCode, "A") : "SOLD OUT")%>
                                                </button>
                                            </span>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">Premium Discounted</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                            <span class="classOptions">
                                                <button type="button" name="updatePrice" class="priceButton"
                                                        onclick='selectPrice("<%= i %>", "true", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "B") %>", "<%= classCode %>", "B", event)'
                                                        <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? "" : "disabled") %> >
                                                <%= (flight.getPriceOfAvailability(classCode, "B") != -1.0 ? flight.getPriceOfAvailability(classCode, "B") : "SOLD OUT")%>
                                                </button>
                                            </span>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">Discounted</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                            <span class="classOptions">
                                                <button type="button" name="updatePrice" class="priceButton"
                                                        onclick='selectPrice("<%= i %>", "true", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "C") %>", "<%= classCode %>", "C", event)'
                                                        <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? "" : "disabled") %> >
                                                <%= (flight.getPriceOfAvailability(classCode, "C") != -1.0 ? flight.getPriceOfAvailability(classCode, "C") : "SOLD OUT")%>
                                                </button>
                                            </span>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">Standard</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                            <span class="classOptions">
                                                <button type="button" name="updatePrice" class="priceButton"
                                                        onclick='selectPrice("<%= i %>", "true", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "D") %>", "<%= classCode %>", "D", event)'
                                                        <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? "" : "disabled") %> >
                                                <%= (flight.getPriceOfAvailability(classCode, "D") != -1.0 ? flight.getPriceOfAvailability(classCode, "D") : "SOLD OUT")%>
                                                </button>
                                            </span>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">Premium</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">-</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                            <span class="classOptions">
                                                <button type="button" name="updatePrice" class="priceButton"
                                                        onclick='selectPrice("<%= i %>", "true", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "E") %>", "<%= classCode %>", "E", event)'
                                                        <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? "" : "disabled") %> >
                                                <%= (flight.getPriceOfAvailability(classCode, "E") != -1.0 ? flight.getPriceOfAvailability(classCode, "E") : "SOLD OUT")%>
                                                </button>
                                            </span>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">ld</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                            <span class="classOptions">
                                                <button type="button" name="updatePrice" class="priceButton"
                                                        onclick='selectPrice("<%= i %>", "true", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "F") %>", "<%= classCode %>", "F", event)'
                                                        <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? "" : "disabled") %> >
                                                <%= (flight.getPriceOfAvailability(classCode, "F") != -1.0 ? flight.getPriceOfAvailability(classCode, "F") : "SOLD OUT")%>
                                                </button>
                                            </span>
                                    </div>
                                </div>
                                <div class="flightDetailsRow">
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">Platinum</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                        <p class="classOptions">&#10003</p>
                                    </div>
                                    <div class="flightDetailsColumn6">
                                            <span class="classOptions">
                                                <button type="button" name="updatePrice" class="priceButton"
                                                        onclick='selectPrice("<%= i %>", "true", "<%= flight.getFlightTime() %>", "<%= flight.getPriceOfAvailability(classCode, "G") %>", "<%= classCode %>", "G", event)'
                                                        <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? "" : "disabled") %> >
                                                <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? flight.getPriceOfAvailability(classCode, "G") : "SOLD OUT")%>
                                                </button>
                                            </span>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                        <!--END TICKET TYPE SELECTION -->
                    </div>
            <!--END TICKET SELECTION-->
                    <%k++; %>
                <% } %>
            <input type="hidden" name="<%= i %>total" value="d">
            <p>total = <span id="<%= i %>total">?</span></p>
            <% } // end for loop on passengers%>


        </fieldset>
        <br />

        <button class="button" name="options" id="options" type="submit">Submit</button>

    </form>
    <% } %>
</main>

</body>

</html>