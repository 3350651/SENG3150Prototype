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
        UserBean user = (UserBean) session.getAttribute("userBean");

        if(request.getParameter("getChat") != null || request.getParameter("newMessage") != null){
            String chatID = group.getChatID();

            if(request.getParameter("newMessage") != null){
                String newMessage = request.getParameter("newMessage");
                MessageBean message = new MessageBean(chatID, newMessage, user.getUserID());
            }

            LinkedList<MessageBean> chatMessages = group.getChat(chatID);

            if(!chatMessages.isEmpty()) {
                session.setAttribute("chatMessages", chatMessages);
                session.setAttribute("messagesExist", true);
            }
            else{
                session.setAttribute("messagesExist", false);
            }
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Chat.jsp");
        }

        //add code that checks if a flight is locked in - get the score from the top of the list.
        //and figure out if it was chosen - aka. number of group members and the score. math.
        //just hard coded to allow for pool to be seen at the moment.
        boolean flightLockedIn = true;
        if(flightLockedIn){
            //get the pool page.
            if(request.getParameter("getPool") != null){
                PoolBean pool = group.getPool();
                session.setAttribute("pool", pool);
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Pool.jsp");
            }
            //make a deposit into the pool.
            else if(request.getParameter("depositToPool") != null){
                //try and make the deposit. call the group method to make deposit. (java script to later check value is
                //not less than 0.

                    //make a PoolDeposit bean if it is successful
                    //redirect to the pool page - remaining will update.
            }
            //withdraw from the pool.
            else if(request.getParameter("withdrawFromPool") != null){
                //this value only appears if the user has made a deposit into the pool.
                //aka, the option only appears then.
                //determine the total amount of their deposits.
            }

            //TO DETERMINE IF THE POOL IS SETTLED, PUT INT ON DB AND CONVERT TO INTEGER.
            //WHEN THE POOL IS SETTLED, THE VALUE CHANGES AND THE USERS ARE NO LONGER ABLE
            //TO MAKE A DEPOSIT INTO THE POOL - SIMPLY SHOW THAT THE POOL IS COMPLETE AND
            //PROMPT THEM THAT IT IS TIME TO MAKE A BOOKING.

            //also need a 'Pool Message Page.' After all of the above is implemented.
        }


        requestDispatcher.forward(request, response);

    }


}
