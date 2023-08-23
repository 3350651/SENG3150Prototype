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
//FlightBean flight=(FlightBean) session.getAttribute("flight");
GroupFaveFlightBean faveFlight = (GroupFaveFlightBean) session.getAttribute("faveFlight");
LinkedList<MessageBean> chatMessages = (LinkedList<MessageBean>) session.getAttribute("chatMessages");
double memberVote = (double) session.getAttribute("memberVote");
boolean lockedIn = (boolean) session.getAttribute("lockedIn");
boolean poolFinished = (boolean) session.getAttribute("poolFinished");
boolean isAdmin = (boolean) session.getAttribute("isAdmin");
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
                    <button class="groupButton" type="submit" name="getGroupFaveList" value="getGroupFaveList">Back</button>
                </form>
                <img src="${pageContext.request.contextPath}/images/fpLogoForSettingsPage.png"
                    alt="FlightPub Logo" class="centreLogo">
                <h1>
                    <%for(int x=faveFlight.getFlightPath().getFlightPath().size()-1; x >=0; x--){%>
                    <div class="DepartureLocationResult"><%=faveFlight.getFlightPath().getFlightPath().get(x).getDeparture().getDestinationName()%></div>
                    <img src="${pageContext.request.contextPath}/images/planeLogo.png" alt="Plane Logo" class="smallPlaneLogo" >
                    <%}%>
                    <div class="DestinationLocationResult"><%=faveFlight.getFlightPath().getLastFlight().getDestination().getDestinationName()%></div>
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

                            </p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="filledSection">
                        <p><strong>Tags:</strong>
                            <%LinkedList<String> tags = faveFlight.getFlightPath().getLastFlight().getDestination().getTags();
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
                </tr>

                <%UserBean user=(UserBean) session.getAttribute("userBean"); if(user==null){%>
            </table>
                <%}%>

            <table>
                <td class="filledSection">
                    <% if(poolFinished) { %>
                        <% if(isAdmin) { %>
                            <form method="POST" action="GroupHomepage">
                                 <button class="groupButton"  type="submit" name="makeBooking" value="true">Make Booking</button>
                            </form>
                        <% } else { %>
                            Booking will be made by Admin.
                        <% } %>
                    <% } else if(lockedIn) { %>
                        <p>Please finish group Money Pool to book trip!</p>
                    <%
                    } else if(memberVote == 0) { %>
                    <form method="POST" action="GroupHomepage">
                        <button class="groupButton" type="submit" name="vote" value="2">Lock-in</button>
                        <button class="groupButton" type="submit" name="vote" value="1">Upvote</button>
                        <button class="groupButton" type="submit" name="vote" value="-1">Downvote</button>
                        <button class="groupButton" type="submit" name="vote" value="-2">Blacklist</button>
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

                    <% if(!lockedIn) { %>
                    <div>
                        <form method="POST" action="GroupHomepage" onsubmit="return sendMessageForm()">
                            <label for="newMessage">Post a message: </label>
                            <input type="text" id="newMessage" name="newMessage"><br>

                            <button class="groupButton" type="submit" name="newMessage" value="newMessage">Post Message</button>
                        </form>
                    </div>
                    <%}%>
                </td>
            </table>

        </main>
    </body>

</html>