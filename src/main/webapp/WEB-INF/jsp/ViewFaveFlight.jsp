<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.GroupFaveFlightBean" %>
<%@ page import="startUp.ChatBean" %>
<%@ page import="startUp.MessageBean" %>
    <%@ page import="startUp.SearchBean" %>
        <%@ page import="startUp.UserBean" %>
            <%@ page import="startUp.DestinationBean" %>
                <%@ page import="java.util.LinkedList" %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <%
                    FlightBean flight=(FlightBean) session.getAttribute("flight");
                    GroupFaveFlightBean faveFlight = (GroupFaveFlightBean) session.getAttribute("faveFlight");
                    LinkedList<MessageBean> chatMessages = (LinkedList<MessageBean>) session.getAttribute("chatMessages");
                    double memberVote = (double) session.getAttribute("memberVote");
                    %>

                        <head>
                            <meta charset="UTF-8">
                            <title>startUp.FlightDetailsPage</title>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mockGroupStyle.css">

                        </head>

                        <body>
                            <main>
                                <header>
                                    <form method="POST" action="GroupHomepage">
                                        <button class="groupButton" type="submit" name="backToFaveFlightList" value="backToFaveFlightList">Back</button>
                                    </form>
                                    <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                                        alt="FlightPub Logo" class="centreLogo">
                                    <h1>
                                        <%= flight.getDeparture().getDestinationName()%> To <%=
                                                flight.getDestination().getDestinationName()%>
                                    </h1>
                                    <br />
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
                                                                <%=flight.getPlaneType()%>
                                                                    <br />
                                                                    <h3>Minimum price: <%=flight.getMinCost()%>
                                                                    </h3>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="filledSection">
                                            <p><strong>Tags:</strong>
                                                <%LinkedList<String> tags = flight.getDestination().getTags();
                                                    if(tags != null){
                                                    for(String tag: tags){
                                                    if(tag != tags.getLast()){
                                                    %>
                                                    <%=tag +", "%>

                                <%}else{%>
                                    <%=tag + " ."%>
                                                        <%}%>
                                                            <%}%>
                                                                <%}%>
                                            </p>
                                        </td>
                                        <td class="filledSection">
                                            <p>
                                                <%=flight.getDestination().getDestinationDescription()%><br>
                                                    <strong>Reputation Score: </strong>
                                                    <%=flight.getDestination().getReputationScore()%>
                                            </p>
                                        </td>
                                    </tr>

                                    <%UserBean user=(UserBean) session.getAttribute("userBean"); if(user==null){%>
                                </table>
                                    <%}%>

                                <table>
                                    <td class="filledSection">
                                        <%
                                        if(memberVote == 0) { %>
                                        <form method="POST" action="GroupHomepage">
                                            <button class="groupButton"  type="submit" name="vote" value="2">Lock-in</button>
                                            <button class="groupButton"  type="submit" name="vote" value="1">Upvote</button>
                                            <button class="groupButton"  type="submit" name="vote" value="-1">Downvote</button>
                                            <button class="groupButton" type="submit" name="vote" value="-2">Blacklist</button>
                                            <input type="hidden" name="viewFaveFlight" value="viewFaveFlight">
                                        </form>
                                        <%
                                        } else if(memberVote == -2){ %>
                                            You have BlackList this flight!
                                        <%
                                        } else if(memberVote == 2){ %>
                                            You have Locked-in this flight!
                                        <%
                                        } else if(memberVote == 1){ %>
                                            <form method="POST" action="GroupHomepage">
                                                <button class="groupButton"  type="submit" name="vote" value="2">Lock-in</button>
                                                <button class="groupButton"  type="submit" name="vote" value="-1">Downvote</button>
                                                <button class="groupButton" type="submit" name="vote" value="-2">Blacklist</button>
                                                <input type="hidden" name="viewFaveFlight" value="viewFaveFlight">
                                            </form>
                                        <%
                                        } else { %>
                                            <form method="POST" action="GroupHomepage">
                                                <button class="groupButton" type="submit" name="vote" value="2">Lock-in</button>
                                                <button class="groupButton" type="submit" name="vote" value="1">Upvote</button>
                                                <button class="groupButton" type="submit" name="vote" value="-2">Blacklist</button>
                                                <input type="hidden" name="viewFaveFlight" value="viewFaveFlight">
                                            </form>
                                        <% }
                                        %>
                                    </td>
                                </table>

                                <table>
                                    <td class="filledSection">
                                        <%
                                        if(chatMessages != null && !chatMessages.isEmpty()){
                                            int size = chatMessages.size();
                                            for(int i = 0; i < size; i++){
                                                MessageBean message = chatMessages.removeFirst();
                                            %>
                                                <%= message.getUserName() %>
                                                (<%= message.getMessageTime() %>):<br>
                                                <%= message.getMessage() %><br><br>
                                            <% chatMessages.addLast(message);
                                            }
                                        } else { %>
                                            <p>There are currently no messages posted on this Favourite Flight!</p>
                                        <%}
                                        %>

                                        <div>
                                            <form method="POST" action="GroupHomepage" onsubmit="return sendMessageForm()">
                                                <label for="newMessage">Post a message: </label>
                                                <input type="text" id="newMessage" name="newMessage"><br>

                                                <button class="groupButton" type="submit" name="newMessage" value="newMessage">Post Message</button>
                                                <input type="hidden" name="viewFaveFlight" value="viewFaveFlight">
                                            </form>
                                        </div>
                                    </td>
                                </table>

                            </main>
                        </body>

                    </html>