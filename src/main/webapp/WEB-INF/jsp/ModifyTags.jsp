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
<%-- Edit user tagset form --%>
    <h1>Modify Tag Set</h1>
    <h2>Your Current Tags</h2>
    <form method="POST" action="AccountSettings" onsubmit="return modifyTags()">
        <div class="tag-grid">
            <% LinkedList<String> tagSet = user.getTagSet();
               for (String tag : tagSet) { %>
                <div class="tag-item remove-tags-form">
                    <input type="checkbox" name="tagsToRemove[]" value="<%= tag %>" id="remove_<%= tag %>">
                    <label for="remove_<%= tag %>"><%= tag %></label>
                </div>
            <% } %>
        </div>

        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="removeTags" value="removeTags" class="button">Remove Tag(s)</button>
    </form>
    <br>

    <h2> Add New Tags </h2>
    <form method="POST" action="AccountSettings" onsubmit="return modifyTags()">
        <div class="tag-grid">
            <% LinkedList<String> allTags = TagBean.getAllTags();
               for (String tag : allTags) {
                   if (!tagSet.contains(tag)) { %>
                       <div class="tag-item add-tags-form">
                           <input type="checkbox" name="tagsToAdd[]" value="<%= tag %>" id="<%= tag %>">
                           <label for="<%= tag %>"><%= tag %></label>
                       </div>
                   <% }
               } %>
        </div>

        <input type="hidden" name="userID" value="<%=user.getUserID()%>">
        <button type="submit" name="addTags" value="addTags" class="button">Add New Tag(s)</button>
    </form>
</div>
</body>
<script type="text/javascript" src="script.js"></script>
</html>
