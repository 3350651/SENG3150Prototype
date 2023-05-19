<%@ page import="startUp.UserBean" %>
<%@ page import="startUp.TagBean" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<!DOCTYPE html>
<% UserBean user = (UserBean) session.getAttribute("userBean");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit user account</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page='c-Sidebar-Account.jsp'></jsp:include>

<div class="main-content">
<%--            Edit user tagset form                 --%>
    <h1>Modify Tag Set</h1>
    <h2> Add New Tags </h2>
    <form method="POST" action="AccountSettings" onsubmit="return modifyTags()">
        <% LinkedList<String> allTags = TagBean.getAllTags();
           LinkedList<String> tagSet = user.getTagSet();
           for (String tag : allTags) {
               if (!tagSet.contains(tag)) { %>
                   <input type="checkbox" name="tags[]" value="<%= tag %>"> <%= tag %><br>
               <% }
           } %>

        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="addTags" value="addTags">Add Tags</button>
    </form>
<br>
    <h2> Remove Tags </h2>
        <form method="POST" action="AccountSettings" onsubmit="return modifyTags()">
    <%
        for (String tag : tagSet) {
        %>
            <input type="checkbox" name="tags[]" value="<%= tag %>"> <%= tag %><br>
        <%
        }
    %>
            <input type="hidden" name="userID" value="<%=user.getUserID()%>">
            <button type="submit" name="removeTags" value="removeTags">Remove Tags</button>
        </form>
</div>
</body>
<script type="text/javascript" src="script.js"></script>
</html>
