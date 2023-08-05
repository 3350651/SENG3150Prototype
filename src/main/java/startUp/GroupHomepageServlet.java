/**
 * FILE NAME: GroupHomepageServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for the group homepage functions
 */

package startUp;

import java.io.*;
import java.sql.Timestamp;
import java.util.LinkedList;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import static startUp.GroupBean.getGroup;
import static startUp.GroupBean.getGroups;
import static startUp.GroupFaveFlightBean.*;
import static startUp.MemberFlightVoteBean.*;
import static startUp.PoolDepositBean.hasMadeDeposit;
import static startUp.UserGroupsBean.getNumberOfMembers;
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

            if(request.getParameter("addToGroupFaveList") != null){
                //Add to Group Fave List from Add Page.
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddToGroupFaveList.jsp");
                requestDispatcher.forward(request, response);
            }
        }

       if (request.getParameter("goGroup") != null) {
            String groupName = request.getParameter("groupName");
            GroupBean group = getGroup(groupName);
            session.setAttribute("group", group);
            Boolean isAdmin = isAdmin(user.getUserID(), group.getGroupID());
            session.setAttribute("isAdmin", isAdmin);

            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepage.jsp");
            requestDispatcher.forward(request, response);

        }
        else if(request.getParameter("groupHomepage") != null) {
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepage.jsp");
            requestDispatcher.forward(request, response);
        }
        else{
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/UserHomepage.jsp");
            requestDispatcher.forward(request, response);
        }

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

        if(request.getParameter("addToGroupFaveList") != null){

            String groupName = request.getParameter("groupName");
            group = getGroup(groupName);
            String flightDetails = (String) session.getAttribute("flightDetails");
            String[] details = flightDetails.split(",", 0);

            boolean alreadyAdded = isInGroupFaveList(details[0], details[1], Timestamp.valueOf(details[2]), group.getGroupID());

            //if already in the group list
            if(alreadyAdded){
                session.setAttribute("message", "Looks like that flight is already in your groups Favourite List!");
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddToGroupFaveListMessage.jsp");
                requestDispatcher.forward(request, response);
            }
            else {
                //Create the GroupFaveFlightBean
                GroupFaveFlightBean flight = new GroupFaveFlightBean(details[0], details[1], Timestamp.valueOf(details[2]), group.getGroupID());
                session.setAttribute("message", "Success! Flight was successfully added to your groups Favourite List!");
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddToGroupFaveListMessage.jsp");
                requestDispatcher.forward(request, response);
            }

        }
        else if(request.getParameter("doNotAddFaveFlight") != null){
            //go back to the flights details page.
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(request, response);
        }
        //user has been presented with a message after attempting to add a flight to a Group Favourite List
        else if(request.getParameter("addFlightContinue") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/FlightDetailsPage.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("cancel") != null && request.getParameter("toPool") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Pool.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("cancel") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepage.jsp");
            requestDispatcher.forward(request, response);
        }

        //Test whether a flight has been locked in.

        //The admin wants to remove a flight from the fave list.
        if(request.getParameter("getGroupFaveList") != null && request.getParameter("removeFlight") != null){
            String faveFlightID = request.getParameter("faveFlightID");
            deleteGroupFaveFlight(group.getGroupID(), faveFlightID);

            LinkedList<GroupFaveFlightBean> faveFlights = getGroupFaveFlights(group.getGroupID());
            int size = faveFlights.size();

            session.setAttribute("faveFlights", faveFlights);

            Boolean isAdmin = isAdmin(user.getUserID(), group.getGroupID());
            session.setAttribute("isAdmin", isAdmin);

            if(faveFlights.size() != 0) {

                //Check whether any of the flights have been blacklisted, remove it.
                for(int i = 0; i < size; i++){
                    GroupFaveFlightBean temp = faveFlights.removeFirst();
                    if(blacklisted(group.getGroupID(),temp.getScore())){
                        deleteGroupFaveFlight(group.getGroupID(), temp.getGroupFaveFlightID());
                    }
                    else {
                        faveFlights.addLast(temp);
                    }
                }

                LinkedList<GroupFaveFlightBean> sortedFaveFlights = getSortedList(faveFlights, faveFlights.peek().getGroupID());
                LinkedList<String> destinations = getDestinations(sortedFaveFlights);
                //Overwrites existing faveFlights.
                session.setAttribute("faveFlights", sortedFaveFlights);
                session.setAttribute("destinations", destinations);
            }
            session.setAttribute("group", group);

            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupFavouriteList.jsp");
            requestDispatcher.forward(request, response);
        }
        else if(request.getParameter("getGroupFaveList") != null){
            //get all the Flights that are added to the group Fave list.
            LinkedList<GroupFaveFlightBean> faveFlights = getGroupFaveFlights(group.getGroupID());
            int size = faveFlights.size();
            session.setAttribute("faveFlights", faveFlights);

            Boolean isAdmin = isAdmin(user.getUserID(), group.getGroupID());
            session.setAttribute("isAdmin", isAdmin);
            boolean lockedIn = false;

            if(faveFlights.size() != 0) {

                //Check whether any of the flights have been blacklisted, remove it.
                for(int i = 0; i < size; i++){
                    GroupFaveFlightBean temp = faveFlights.removeFirst();
                    if(blacklisted(group.getGroupID(),temp.getScore())){
                        deleteGroupFaveFlight(group.getGroupID(), temp.getGroupFaveFlightID());
                    }
                    //Check whether there is a flight that has been locked in.
                    else if(lockedIn(group.getGroupID(), temp.getScore())){
                        lockedIn = true;
                    }
                    else {
                        faveFlights.addLast(temp);
                    }
                }

                session.setAttribute("lockedIn", lockedIn);

                //If a flight has been locked in. Then get it.
                if(lockedIn){
                    GroupFaveFlightBean lockedInFlight = getLockedIn();
                }


                LinkedList<GroupFaveFlightBean> sortedFaveFlights = getSortedList(faveFlights, faveFlights.peek().getGroupID());
                LinkedList<String> destinations = getDestinations(sortedFaveFlights);
                //Overwrites existing faveFlights.
                session.setAttribute("faveFlights", sortedFaveFlights);
                session.setAttribute("destinations", destinations);
            }
            session.setAttribute("group", group);

            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupFavouriteList.jsp");
            requestDispatcher.forward(request, response);
        }
        //The user wishes to view a fave flight.
        else if(request.getParameter("viewFaveFlight") != null && request.getParameter("getFlight") != null) {
            String airlineCode = request.getParameter("airlineCode");
            String flightName = request.getParameter("flightName");
            Timestamp flightTime = Timestamp.valueOf(request.getParameter("flightTime"));
            GroupFaveFlightBean faveFlight = getFaveFlight(airlineCode, flightName, flightTime, group.getGroupID());
            FlightBean flightBean = getFlight(airlineCode, flightName, flightTime);
            session.setAttribute("flight", flightBean);
            session.setAttribute("userBean", user);

            //TODO:
            //If the flight has been locked in - then give the appropriate message --> need to complete pool, or
            //can book if they are admin.
            boolean lockedIn = (boolean) session.getAttribute("lockedIn");
            session.setAttribute("lockedIn", lockedIn);

            if(lockedIn){

            }
            //Otherwise, just show the page for that fave flight.
            else {

                //Score is 0 if the member has not voted.
                int memberVote = getMembersVote(group.getGroupID(), user.getUserID(), faveFlight.getGroupFaveFlightID());
                session.setAttribute("memberVote", memberVote);

                int groupSize = getNumberOfMembers(group.getGroupID());
                double membersScore = getFaveFlightScore(group.getGroupID(), faveFlight.getGroupFaveFlightID());
                faveFlight.setScore(membersScore / groupSize);
                session.setAttribute("faveFlight", faveFlight);

                //chat functionality
                String chatID = faveFlight.getChatID();
                LinkedList<MessageBean> chatMessages = faveFlight.getChat(chatID);
                session.setAttribute("chatMessages", chatMessages);

                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ViewFaveFlight.jsp");
                requestDispatcher.forward(request, response);
            }
        }
        //The user has posted a comment to a favourite flight.
        //TODO: change this section to work with a locked-in flight??
        else if(request.getParameter("viewFaveFlight") != null && request.getParameter("newMessage") != null){
            //Chat functionality
            GroupFaveFlightBean faveFlight = (GroupFaveFlightBean) session.getAttribute("faveFlight");
            String chatID = faveFlight.getChatID();

            if(request.getParameter("newMessage") != null){
                String newMessage = request.getParameter("newMessage");
                MessageBean message = new MessageBean(chatID, newMessage, user.getUserID());
            }

            LinkedList<MessageBean> chatMessages = faveFlight.getChat(chatID);
            session.setAttribute("chatMessages", chatMessages);
            session.setAttribute("faveFlight", faveFlight);

            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ViewFaveFlight.jsp");
            requestDispatcher.forward(request, response);
        }
        //the user has voted on the flight.
        else if(request.getParameter("viewFaveFlight") != null && request.getParameter("vote") != null){
            GroupFaveFlightBean faveFlight = (GroupFaveFlightBean) session.getAttribute("faveFlight");
            String chatID = faveFlight.getChatID();

            LinkedList<MessageBean> chatMessages = faveFlight.getChat(chatID);
            session.setAttribute("chatMessages", chatMessages);

            //Get the vote that the user has selected, and change the session attribute.
            int memberVote = Integer.parseInt(request.getParameter("vote"));
            session.setAttribute("memberVote", memberVote);

            //check if the member has already voted. If they have, then update the db accordingly.
            if(hasVoted(faveFlight.getGroupFaveFlightID(), group.getGroupID(), user.getUserID())){
                updateMemberScore(group.getGroupID(), faveFlight.getGroupFaveFlightID(), user.getUserID(), memberVote);
            }
            else {
                //If they haven't, then add the new vote to the db.
                MemberFlightVoteBean vote = new MemberFlightVoteBean(group.getGroupID(), user.getUserID(), faveFlight.getGroupFaveFlightID(), memberVote);
            }
            //Everytime a user votes on a favourite flight, the score for that flight needs to be updated.
            //Need the number of members in the group.
            int groupSize = getNumberOfMembers(group.getGroupID());
            double membersScore = getFaveFlightScore(group.getGroupID(), faveFlight.getGroupFaveFlightID());
            faveFlight.setScore(membersScore/groupSize);
            session.setAttribute("faveFlight", faveFlight);

            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ViewFaveFlight.jsp");
            requestDispatcher.forward(request, response);
        }

        else if(request.getParameter("backToFaveFlightList") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupFavouriteList.jsp");
            requestDispatcher.forward(request, response);
        }


        //If a flight has been locked in then the money pool becomes available - for the prototype, we hardcode this
        //to be true to allow for the pool to be displayed.
        boolean lockedIn = (boolean) session.getAttribute("lockedIn");
        boolean poolFinished = group.isPoolComplete(group.getPoolID());
        //If the flight has been locked in and the pool is not finished.
        if(lockedIn && !poolFinished){

            //add functionality that only displays the locked in flight within the Group Favourite List.
            PoolBean pool = group.getPool();
            boolean hasDeposited = hasMadeDeposit(pool.getPoolID(), user.getUserID());
            session.setAttribute("hasDeposited", hasDeposited);
            //get the pool page.
            if(request.getParameter("getPool") != null){
                session.setAttribute("pool", pool);
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Pool.jsp");
                requestDispatcher.forward(request, response);
            }
            //go to the page to add to the pool.
            else if(request.getParameter("addToPool") != null){
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddToPool.jsp");
                requestDispatcher.forward(request, response);
            }
            //confirm withdraw from pool.
            else if(request.getParameter("withdrawFromPool") != null){
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/WithdrawFromPool.jsp");
                requestDispatcher.forward(request, response);
            }
            else if(request.getParameter("confirmWithdraw") != null){
                double amount = group.withDrawFromPool(user.getUserID());
                session.setAttribute("message", "Success! You have successfully withdrawn $" + amount +
                        " from the group money pool.");
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/PoolMessage.jsp");
                requestDispatcher.forward(request, response);
            }
            //Get the group availability calendar.
            else if(request.getParameter("getCalendar") != null){
                //This feature is not implemented for the prototype. It serves as a placeholder.
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupCalendar.jsp");
                requestDispatcher.forward(request, response);
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
                    requestDispatcher.forward(request, response);
                }
                //An internal error or something else occurred. The value is checked if it is negative in the javascript.
                else{
                    session.setAttribute("message", "An error occurred. Please check that the deposit does not exceed" +
                            " the remaining amount needed.");
                    requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/PoolMessage.jsp");
                    requestDispatcher.forward(request, response);
                }
            }
            else if(request.getParameter("poolContinue") != null){
                pool = group.getPool();
                session.setAttribute("pool", pool);
                requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Pool.jsp");
                requestDispatcher.forward(request, response);
            }
        }
        //If a flight is locked in and the pool is finished, then the group admin can book the flight for the group.
        else if(lockedIn && poolFinished){
            //The pool is finished so do not show the pool option button,
            //instead show the booking button option from the view booking page on the locked-in flight.
        }

        /*
        Additional functionality to be implemented for the full implementation product:
                - Full implementation and associated implementations of the Group Favourite List.
                    - If all users lock-in a flight, then the pool functionality becomes available.
                    - If all users have blacklisted a flight, then remove it from the list.
                    - Admin should have the option to remove a flight.
                    - When a flight is locked-in, the Admin cannot add other members or remove members.
                - Recommended search functionality available for the group.
                - Member should have the ability to leave a group.
                - Members should have the ability to remove a comment they made on a favourited flight.
                - When a group flight booking is made, this flight will be visible from the group homepage.
                - Once the trip has been completed or the booking is cancelled by the group admin,
                the whole process resets, aka. the members can add flights to favourite list, etc.
         */



    }


}
