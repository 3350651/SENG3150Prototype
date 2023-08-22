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
        <br />

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

            <label for='<%="email" +i%>false'>Email: </label>
            <input type="email" name='<%="email" +i%>false' id='<%="email" +i%>false' required="true"/>
            <br />

            <label for='<%="mobile" +i%>false'>Mobile Number: </label>
            <input type="text" name='<%="mobile" +i%>false' id='<%="mobile" +i%>false' required="true"/>
            <br />

            <label for='<%="dob" +i%>false'>Date of Birth: </label>
            <input type="date" name='<%="dob" +i%>false' id='<%="dob" +i%>false' />
            <br />

            <h3>Ticket Details</h3>
            <% int j = 0; for (FlightBean flight : flightList ) { %>

            <!--TICKET SELECTION-->
            <div class="flightDetailsRow">
                <div class="flightDetailsColumnLeft" style="width:auto;">
                    <button type="button" class="button" onclick="toggleVisibility('<%= i %>-false-<%= j %>', event)" style="width:auto;">
                        <%= flight.getDeparture().getDestinationName() %> - <%= flight.getDestination().getDestinationName()%>
                    </button>
                    <span id="priceFor-<%= i %>-false-<%= j %>">
                        &#x2190 Select a ticket here
                    </span>
                    <input type="hidden" name="<%= i %>-false-price-<%= j %>" class="falsetotal" value="">
                    <input type="hidden" name="<%= i %>-false-class-<%= j %>" value="">
                    <input type="hidden" name="<%= i %>-false-type-<%= j %>" value="">
                </div>
            </div>

                <% String[] classCodes = {"ECO", "PME", "BUS", "FIR"}; %>
                <% String[] ticketTypes = {"A", "B", "C", "D", "E", "F", "G"}; %>
                <div class="ticketSelection" id="<%= i %>-false-<%= j %>" style="display:none;">
                    <div class="flightDetailsRow" id="<%= i %>-false-<%= j %>classDiv">

                        <% for (String classCode : classCodes) {%>
                            <div class="flightDetailsColumn4">
                                <% if (classCode.equals("ECO")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-false-<%= j %>', '<%= classCode %>', this, event)">Economy</button>
                                <% } %>
                                <% if (classCode.equals("PME")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-false-<%= j %>', '<%= classCode %>', this, event)">Premium Economy</button>
                                <% } %>
                                <% if (classCode.equals("BUS")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-false-<%= j %>', '<%= classCode %>', this, event)">Business</button>
                                <% } %>
                                <% if (classCode.equals("FIR")) {%>
                                <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-false-<%= j %>', '<%= classCode %>', this, event)">First Class</button>
                                <% } %>
                            </div>
                        <% } // end for loop class codes%>
                        <!--TICKET TYPE SELECTION -->
                        <% for (String classCode : classCodes) {%>
                        <div id="<%= i %>-false-<%= j %><%= classCode %>" style="display:none">
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
                                                onclick='selectPrice("<%= i %>", "false", "<%= j %>", "<%= flight.getPriceOfAvailability(classCode, "A") %>", "<%= classCode %>", "A", event)'
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
                                                onclick='selectPrice("<%= i %>", "false", "<%= j %>", "<%= flight.getPriceOfAvailability(classCode, "B") %>", "<%= classCode %>", "B", event)'
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
                                                onclick='selectPrice("<%= i %>", "false", "<%= j %>", "<%= flight.getPriceOfAvailability(classCode, "C") %>", "<%= classCode %>", "C", event)'
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
                                                onclick='selectPrice("<%= i %>", "false", "<%= j %>", "<%= flight.getPriceOfAvailability(classCode, "D") %>", "<%= classCode %>", "D", event)'
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
                                                onclick='selectPrice("<%= i %>", "false", "<%= j %>", "<%= flight.getPriceOfAvailability(classCode, "E") %>", "<%= classCode %>", "E", event)'
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
                                                onclick='selectPrice("<%= i %>", "false", "<%= j %>", "<%= flight.getPriceOfAvailability(classCode, "F") %>", "<%= classCode %>", "F", event)'
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
                                                onclick='selectPrice("<%= i %>", "false", "<%= j %>", "<%= flight.getPriceOfAvailability(classCode, "G") %>", "<%= classCode %>", "G", event)'
                                                <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? "" : "disabled") %> >
                                        <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? flight.getPriceOfAvailability(classCode, "G") : "SOLD OUT")%>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <% } // end for loop class codes%>
                    </div>
                    <!--END TICKET TYPE SELECTION -->
                </div>
            <!--END TICKET SELECTION-->
                <% j++; %>
            <% } // end for loop flightList%>
        </fieldset>
            <% } // end for loop on passengers%>

            <input type="hidden" name="falsetotal" value="d">
            <p>total = <span id="falsetotal"></span></p>
        <% if (session.getAttribute("returnFlightList") != null) {%>

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

            <label for='<%="email" +i%>true'>Email: </label>
            <input type="email" name='<%="email" +i%>true' id='<%="email" +i%>true' required="true"/>
            <br />

            <label for='<%="mobile" +i%>true'>Mobile Number: </label>
            <input type="text" name='<%="mobile" +i%>true' id='<%="mobile" +i%>true' required="true"/>
            <br />

            <label for='<%="dob" +i%>true'>Date of Birth: </label>
            <input type="date" name='<%="dob" +i%>true' id='<%="dob" +i%>true' />
            <br />
                <h3>Return Ticket Details</h3>
                    <% int k = 0; for (FlightBean flight : returnFlightList ) { %>
                <!--TICKET SELECTION-->
                    <div class="flightDetailsRow">
                        <div class="flightDetailsColumnLeft" style="width:auto;">
                            <button type="button" class="button" onclick="toggleVisibility('<%= i %>-true-<%= k %>', event)" style="width:auto;">
                                <%= flight.getDeparture().getDestinationName() %> - <%= flight.getDestination().getDestinationName()%>
                            </button>
                            <span id="priceFor-<%= i %>-true-<%= k %>" name="<%= k %>">
                                &#x2190 Select a ticket here
                            </span>
                            <input type="hidden" name="<%= i %>-true-price-<%= k %>" class="truetotal" value="">
                            <input type="hidden" name="<%= i %>-true-class-<%= k %>" value="">
                            <input type="hidden" name="<%= i %>-true-type-<%= k %>" value="">
                        </div>
                    </div>
                    <% String[] classCodes = {"ECO", "PME", "BUS", "FIR"}; %>
                    <% String[] ticketTypes = {"A", "B", "C", "D", "E", "F", "G"}; %>
                    <div class="ticketSelection" id="<%= i %>-true-<%= k %>" style="display:none;">
                            <div class="flightDetailsRow" id="<%= i %>-true-<%= k %>classDiv">

                            <% for (String classCode : classCodes) {%>
                                <div class="flightDetailsColumn4">
                                    <% if (classCode.equals("ECO")) {%>
                                    <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-true-<%= k %>', '<%= classCode %>', this, event)">Economy</button>
                                    <% } %>
                                    <% if (classCode.equals("PME")) {%>
                                    <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-true-<%= k %>', '<%= classCode %>', this, event)">Premium Economy</button>
                                    <% } %>
                                    <% if (classCode.equals("BUS")) {%>
                                    <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-true-<%= k %>', '<%= classCode %>', this, event)">Business</button>
                                    <% } %>
                                    <% if (classCode.equals("FIR")) {%>
                                    <button type="button" class="classButton" onclick="toggleVisibility2('<%= i %>-true-<%= k %>', '<%= classCode %>', this, event)">First Class</button>
                            <% } // end for loop class codes%>
                                </div>
                                <% } %>
                                <!--TICKET TYPE SELECTION -->
                                <% for (String classCode : classCodes) {%>
                                <div id="<%= i %>-true-<%= k %><%= classCode %>" style="display:none">
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
                                                            onclick='selectPrice("<%= i %>", "true", "<%= k %>", "<%= flight.getPriceOfAvailability(classCode, "A") %>", "<%= classCode %>", "A", event)'
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
                                                            onclick='selectPrice("<%= i %>", "true", "<%= k %>", "<%= flight.getPriceOfAvailability(classCode, "B") %>", "<%= classCode %>", "B", event)'
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
                                                            onclick='selectPrice("<%= i %>", "true", "<%= k %>", "<%= flight.getPriceOfAvailability(classCode, "C") %>", "<%= classCode %>", "C", event)'
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
                                                            onclick='selectPrice("<%= i %>", "true", "<%= k %>", "<%= flight.getPriceOfAvailability(classCode, "D") %>", "<%= classCode %>", "D", event)'
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
                                                            onclick='selectPrice("<%= i %>", "true", "<%= k %>", "<%= flight.getPriceOfAvailability(classCode, "E") %>", "<%= classCode %>", "E", event)'
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
                                                            onclick='selectPrice("<%= i %>", "true", "<%= k %>", "<%= flight.getPriceOfAvailability(classCode, "F") %>", "<%= classCode %>", "F", event)'
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
                                                            onclick='selectPrice("<%= i %>", "true", "<%= k %>", "<%= flight.getPriceOfAvailability(classCode, "G") %>", "<%= classCode %>", "G", event)'
                                                            <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? "" : "disabled") %> >
                                                    <%= (flight.getPriceOfAvailability(classCode, "G") != -1.0 ? flight.getPriceOfAvailability(classCode, "G") : "SOLD OUT")%>
                                                    </button>
                                                </span>
                                        </div>
                                    </div>
                                </div>
                                <% } //end for loop class code%>
                            </div>
                            <!--END TICKET TYPE SELECTION -->
                        </div>
                <!--END TICKET SELECTION-->
                        <%k++; %>
                    <% } //end for loop on return flights %>


        </fieldset>
            <% } //end for loop return passengers %>
        <% } //end if return exists %>


            <input type="hidden" name="truetotal" value="d">
            <p>total = <span id="truetotal"></span></p>


        <br />

        </fieldset>




        <button class="button" name="options" id="options" type="submit">Submit</button>

    </form>
    <% } // end if available %>
</main>

</body>

</html>