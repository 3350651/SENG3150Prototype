<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.GroupBean" %>
<%@ page import="startUp.MessageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%
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
                    MessageBean message = chatMessages.pop();
                %>
                    <p>Member Name: <%= message.getMessageTime() %></p>
                    <p>Member ID: <%= message.getMessage() %></p>
                <% chatMessages.addLast(message);
                }
            } else { %>
                <p>There are currently no messages in the group chat!</p>
            <%}
            %>
        </div>

    </main>
</body>
<script type="text/javascript" src="script.js"></script>
</html>