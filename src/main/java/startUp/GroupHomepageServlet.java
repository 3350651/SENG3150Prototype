package startUp;

import java.io.*;
import java.time.LocalDate;
import java.util.LinkedList;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import static startUp.GroupBean.getGroup;
import static startUp.GroupBean.getGroups;
import static startUp.PoolDepositBean.hasMadeDeposit;
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

        if(request.getParameter("cancel") != null && request.getParameter("toPool") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Pool.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("cancel") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepage.jsp");
            requestDispatcher.forward(request, response);
        }

        //add code that checks if a flight is locked in - get the score from the top of the list.
        //and figure out if it was chosen - aka. number of group members and the score. math.
        //just hard coded to allow for pool to be seen at the moment.
        boolean flightLockedIn = true;
        boolean poolFinished = group.isPoolComplete(group.getPoolID());
        if(flightLockedIn && !poolFinished){
            //add some functionality that changes the appearance of the group flight list,
            //aka, they are no longer allowed to vote on the flights.

            PoolBean pool = group.getPool();
            boolean hasDeposited = hasMadeDeposit(pool.getPoolID(), user.getUserID());
            session.setAttribute("hasDeposited", hasDeposited);
            //get the pool page.
            if(request.getParameter("getPool") != null){
                session.setAttribute("pool", pool);
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Pool.jsp");
            }
            //go to the page to add to the pool.
            else if(request.getParameter("addToPool") != null){
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddToPool.jsp");
            }
            //confirm withdraw from pool.
            else if(request.getParameter("withdrawFromPool") != null){
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/WithdrawFromPool.jsp");
            }
            else if(request.getParameter("confirmWithdraw") != null){
                double amount = group.withDrawFromPool(user.getUserID());
                session.setAttribute("message", "Success! You have successfully withdrawn $" + amount +
                        " from the group money pool.");
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/PoolMessage.jsp");
            }
            //request send to add money to pool. make a deposit to the pool.
            else if(request.getParameter("addMoney") != null){
                //try and make the deposit. call the group method to make deposit. (java script to later check value is
                //not less than 0.
                pool = (PoolBean) session.getAttribute("pool");
                double addMoney = Double.parseDouble(request.getParameter("addMoney"));
                boolean deposited = group.depositToPool(addMoney);

                if(deposited){
                    //set message to tell user that it was successful.
                    pool = group.getPool();
                    session.setAttribute("pool", pool);

                    PoolDepositBean newDeposit = new PoolDepositBean(pool.getPoolID(), user.getUserID(), addMoney);

                    session.setAttribute("message", "Success! You have successfully deposited $" + addMoney +
                    " into the group money pool.");
                    requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/PoolMessage.jsp");
                }
                //An internal error or something else occurred. The value is checked if it is negative in the javascript.
                else{
                    session.setAttribute("message", "An error occurred. Please check that the deposit does not exceed" +
                            " the remaining amount needed.");
                    requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/PoolMessage.jsp");
                }

                requestDispatcher.forward(request, response);
            }
            else if(request.getParameter("poolContinue") != null){
                pool = group.getPool();
                session.setAttribute("pool", pool);
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Pool.jsp");
            }

            //TO DETERMINE IF THE POOL IS SETTLED, PUT INT ON DB POOL TABLE AND CONVERT TO INTEGER.
            //WHEN THE POOL IS SETTLED, THE BIT CHANGES AND THE USERS ARE NO LONGER ABLE
            //TO MAKE A DEPOSIT INTO THE POOL - SIMPLY SHOW THAT THE POOL IS COMPLETE AND
            //PROMPT THEM THAT IT IS TIME TO MAKE A BOOKING.

            //also need a 'Pool Message Page.' After all of the above is implemented.
            requestDispatcher.forward(request, response);
        }
        else if(poolFinished){
            //The pool is finished so do not show the pool option button,
            //instead show the booking button option.
        }
        else if(!flightLockedIn){
            //the group flights (inherits from the normal flight) need to be ranked
            //based on their rating.
            //only allow members to give one vote to the flight (can only have one option)
            //once a flight is locked in by all members, the members can not change their
            //decision on voting for that flight. They can then only view that flight
            //in the favourites list.
            //The group admin can also not add any other members once a flight is locked in.
            //if a member has not voted on a specific flight, then the system will let them
            //know (a little message under, etc).
            //Need TABLES:
            // - Group Favourited Flight
            // - MemberFlightVote (userID, groupID, and vote value)
            //Flights need to be ordered based on overall rank, so current score given by
            //members, and averaged by the number of members that have voted.
            //No flight can be locked in until all members of the group have locked it in.
        }




    }


}
