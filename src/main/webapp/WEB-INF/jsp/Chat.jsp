<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="startUp.MessageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
UserBean user = (UserBean) session.getAttribute("userBean");
GroupBean group = (GroupBean) session.getAttribute("group");
LinkedList<MessageBean> chatMessages = (LinkedList<MessageBean>) session.getAttribute("chatMessages");
boolean exist = (boolean) session.getAttribute("messagesExist");
int size = 0;
if(exist){
    size = chatMessages.size();
}
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" href="Style.css">
</head>
<body>
    <main>
        <header>
           <form name="backtoGroupHomepage" action="GroupHomepage" method="GET">
                   <button type="submit" name="groupHomepage" value="true">Return to Group Homepage</button>
           </form>

            <div class="titleContainer">
                <h1>Group Chat</h1>
            </div>
            <div class="groupName">
                <h2><%= group.getGroupName() %></h2>
            </div>
        </header>

        <div>
            <%
            if(size > 0){
                for(int i = 0; i < size; i++){
                    MessageBean message = chatMessages.removeFirst();
                %>
                    <%= message.getUserName() %>:<br>
                    <%= message.getMessageTime() %><br>
                    <%= message.getMessage() %><br><br>
                <% chatMessages.addLast(message);
                }
            } else { %>
                <p>There are currently no messages in the group chat!</p>
            <%}
            %>
        </div>

        <div>
            <form method="POST" action="GroupHomepage" onsubmit="return sendMessageForm()">
                <label for="newMessage">Send Message to Chat: </label>
                <input type="text" id="newMessage" name="newMessage"><br>

                <button type="submit" name="newMessage" value="newMessage">Send Message</button>
            </form>
        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>