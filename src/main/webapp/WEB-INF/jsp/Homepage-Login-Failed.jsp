<%@ page import="startUp.UserBean" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="startUp.FlightBean" %>
<%@ page import="startUp.DestinationBean" %>
<%@ page import="startUp.FlightPathBean" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
            <% UserBean user=(UserBean) session.getAttribute("userBean");
            LinkedList<FlightPathBean> bookmarkedFlights = new
              LinkedList<>();
                if (user != null && user.getBookmarkedFlights() != null) {
                bookmarkedFlights = user.getBookmarkedFlights();
                }
                %>

                <!DOCTYPE html>

                <html lang="en">

                <%if((user !=null && user.getDefaultSearch()=="RecommendHomepage-Index.jsp" && request.getAttribute("goToSimple") != null) || request.getAttribute("goToRecommend") != null){%>
                  <div class="loginFailedMessage"> Login failed, please confirm details and try again </div>
                  <jsp:include page="Homepage-RecommendedSearch.jsp"></jsp:include>

                  <%}else{%>
                    <div class="loginFailedMessage"> Login failed, please confirm details and try again </div>
                    <jsp:include page="Homepage-SimpleSearch.jsp"></jsp:include>

                    <%}%>


                      <script type="text/javascript"
                        src="${pageContext.request.contextPath}/javascript/script.js"></script>

                </html>