<%@ page import="startUp.UserBean" %>
<%
  UserBean user = (UserBean) session.getAttribute("userBean");
%>

<div class="accountAccess">
    <div class="loggedInAccountAccess">
    <% if (user !=null) { %>
        <div class="viewAccountSettings">
        <form method="POST" action="AccountSettings">
            <button name="viewAccountSettings" class="accountButton"
                value="viewAccountSettings">View Profile</button>
        </form>
        </div>
        <div class="logOut">
        <form method="POST" action="login">
            <button name="logOutButton" class="accountButton"
                value="logOut">Log Out</button>
        </form>
        </div>
    <% } %>
    </div>
    <div class="loggedOutAccountAccess">
    <% if (user == null) { %>
      <div class="createAccount">
        <form method="GET" action="CreateAccount">
          <button name="createAccountButton" class="accountButton" value="createAccount">Create Account</button>
        </form>
      </div>
      <div class="logInToAccount">
        <form method="GET" action="login">
          <button name="createAccountButton" class="accountButton" value="logInToAccount">Log In</button>
        </form>
      </div>
    <% } %>
    </div>
    <div class="loginDisplay">
      <div id="login" style="display: none">
        <%-- Login form --%>
        <form method="POST" action="login">
          <label>Email </label>
          <input type="text" name="email" required>
          <br>
          <label>Password </label>
          <input type="password" name="password" required>
          <button type="submit" name="button" value="submit">Submit</button>
        </form>
      </div>
    </div>
</div>