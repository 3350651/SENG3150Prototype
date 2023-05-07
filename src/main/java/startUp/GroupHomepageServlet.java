package startUp;

import java.io.*;
import java.time.LocalDate;
import java.util.LinkedList;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import static startUp.GroupBean.getGroup;
import static startUp.GroupBean.getGroups;
import static startUp.UserGroupsBean.isAdmin;

@WebServlet(urlPatterns = { "/GroupHomepage" })
public class GroupHomepageServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher = null;

        UserBean user = (UserBean) session.getAttribute("userBean");

        //stuff to set and display groups for user.
        LinkedList<String> groupIDs = user.getGroupIDs(user.getUserID());
        if(!groupIDs.isEmpty()) {
            LinkedList<GroupBean> groups = getGroups(groupIDs);
            session.setAttribute("groups", groups);


            if (request.getParameter("goGroup") != null) {
                String groupName = request.getParameter("groupName");
                GroupBean group = getGroup(groupName);
                session.setAttribute("group", group);
                Boolean isAdmin = isAdmin(user.getUserID(), group.getGroupID());
                session.setAttribute("isAdmin", isAdmin);

                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepage.jsp");
                requestDispatcher.forward(request, response);

            }
            else if(request.getParameter("groupHomepage") != null){
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepage.jsp");
            }
            else {
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/UserHomepageWithGroups.jsp");
            }
        }
        else{
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/UserHomepage.jsp");
        }


        requestDispatcher.forward(request, response);
    }

    /**
     * Handles POST requests for the logout button, home button and admin functionality
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher = null;
        GroupBean group = (GroupBean) session.getAttribute("group");

        if(request.getParameter("getChat") != null){
            LinkedList<MessageBean> chatMessages = group.getChat(group.getGroupID());
            if(!chatMessages.isEmpty()) {
                session.setAttribute("chatMessages", chatMessages);
                session.setAttribute("messagesExist", true);
            }
            else{
                session.setAttribute("messagesExist", false);
            }
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Chat.jsp");
        }

        requestDispatcher.forward(request, response);

    }


}
