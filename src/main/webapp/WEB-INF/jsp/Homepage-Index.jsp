<%@ page import="startUp.UserBean" %>
  <%@ page import="java.time.format.DateTimeFormatter" %>
    <%@ page import="java.util.LinkedList" %>
      <%@ page import="java.util.Iterator" %>
        <%@ page import="startUp.FlightBean" %>
          <%@ page import="startUp.DestinationBean" %>
            <% UserBean user=(UserBean) session.getAttribute("userBean"); LinkedList<FlightBean> bookmarkedFlights = new
              LinkedList<>();
                if (user != null && user.getBookmarkedFlights() != null) {
                bookmarkedFlights = user.getBookmarkedFlights();
                }
                %>

                <!DOCTYPE html>

                <html lang="en">

                <%if(user !=null && user.getDefaultSearch()=="Recommend" ){%>
                  <jsp:include page="Homepage-RecommendedSearch.jsp"></jsp:include>
                  <%}else{%>
                    <jsp:include page="Homepage-SimpleSearch.jsp"></jsp:include>
                    <%}%>


                      <script type="text/javascript"
                        src="${pageContext.request.contextPath}/javascript/script.js"></script>

                </html>