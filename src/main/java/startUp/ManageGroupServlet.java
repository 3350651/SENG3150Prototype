/**
 * FILE NAME: ManageGroupServlet.java
 * AUTHORS: Lucy Knight, Jordan Eade, Lachlan O'Neill, Blake Baldin
 * PURPOSE: SENG3150 Project - Controller for managing group membership and group profile.
 */

package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedList;

import static startUp.ChatBean.deleteChat;
import static startUp.GroupBean.*;
import static startUp.GroupFaveFlightBean.*;
import static startUp.MemberFlightVoteBean.deleteMemberFlightVotes;
import static startUp.MessageBean.deleteMessages;
import static startUp.PoolBean.deletePool;
import static startUp.PoolDepositBean.hasMadeDeposit;
import static startUp.PoolDepositBean.poolDeposits;
import static startUp.UserBean.userExists;
import static startUp.UserGroupsBean.*;

@WebServlet(urlPatterns = { "/ManageGroup" })
public class ManageGroupServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher = null;
        GroupBean group = (GroupBean) session.getAttribute("group");
        boolean depositMade = poolDeposits(group.getPoolID());
        session.setAttribute("depositMade", depositMade);

        LinkedList<GroupFaveFlightBean> faveFlights = getGroupFaveFlights(group.getGroupID());
        int size = faveFlights.size();
        boolean lockedIn = false;
        if(faveFlights.size() != 0) {
            for (int i = 0; i < size; i++) {
                GroupFaveFlightBean temp = faveFlights.removeFirst();
                if (lockedIn(group.getGroupID(), temp.getScore())) {
                    lockedIn = true;
                }
            }
        }
        //Determine whether a flight has been locked in by all members.
        session.setAttribute("lockedIn", lockedIn);

        // send the user to an unauthorised page if they try to access the homepage without being logged in.

        requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
        requestDispatcher.forward(request, response);
    }



    /**
     * Handles POST requests for the logout button, home button and admin functionality
     */
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        UserBean user = (UserBean) session.getAttribute("userBean");
        String userID = user.getUserID();
        GroupBean group = (GroupBean) session.getAttribute("group");
        String groupID = group.getGroupID();
        boolean depositMade = poolDeposits(group.getPoolID());
        session.setAttribute("depositMade", depositMade);
        session.setAttribute("homepage", false);

        //Admin has inputted email to add member.
        if((request.getParameter("addMember") != null) && (request.getParameter("userEmail") != null)){
            String email = request.getParameter("userEmail");
            String addUserID = userExists(email);
            session.setAttribute("group", group);
            session.setAttribute("goHome", false);

            //check that user does not already exist in the group.
            boolean inGroup = userAlreadyInGroup(addUserID, groupID);
            if(inGroup){
                //redirect with this message.
                session.setAttribute("message", "An error occurred. Looks like that user is already a member of the group!");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepageMessage.jsp");
                requestDispatcher.forward(request, response);
            }
            if(addUserID != null && !inGroup){
                //add to the group in the db.
                UserGroupsBean userGroupsBean = new UserGroupsBean(addUserID, groupID, false);
                GroupBean newGroup = getGroup(group.getGroupName());
                session.setAttribute("group", newGroup);
                //success message -> redirect to message page and then to managegroup from there.
                session.setAttribute("message", "Success! User was successfully added to the group!");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepageMessage.jsp");
                requestDispatcher.forward(request, response);

            }
            else{
                //the user was not found
                session.setAttribute("message", "An error occurred. User was not found in the system.");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepageMessage.jsp");
                requestDispatcher.forward(request, response);
            }
        }

        //Add member
        if(request.getParameter("addMember") != null){
            session.setAttribute("group", group);
            session.setAttribute("goHome", false);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/AddMember.jsp");
            requestDispatcher.forward(request, response);
        }

        //Remove member
        if(request.getParameter("removeMember") != null && request.getParameter("memberID") != null){
            String id = request.getParameter("memberID");
            removeGroupMember(id);
            session.setAttribute("group", group);
            session.setAttribute("goHome", false);
            session.setAttribute("message", "Success! Member was removed from the group.");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepageMessage.jsp");
            requestDispatcher.forward(request, response);
        }

        //Get remove member page.
        if(request.getParameter("removeMember") != null){
            LinkedList<String> groupMemberIDs = getGroupMembersIDs(groupID);
            LinkedList<String> groupMemberNames = getGroupMemberNames(groupMemberIDs);
            int size = groupMemberIDs.size();
            LinkedList<Boolean> hasDeposited = new LinkedList<>();

            for(int i = 0; i < size; i++){
                String id = groupMemberIDs.pop();
                hasDeposited.addLast(hasMadeDeposit(group.getPool().getPoolID(), id));
                groupMemberIDs.addLast(id);
            }

            session.setAttribute("memberIDs", groupMemberIDs);
            session.setAttribute("memberNames", groupMemberNames);
            session.setAttribute("size", size);
            session.setAttribute("hasDeposited", hasDeposited);
            session.setAttribute("goHome", false);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/RemoveMember.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("deleteGroup") != null){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/DeleteGroup.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("confirmDeleteGroup") != null){
            boolean delete = Boolean.parseBoolean(request.getParameter("confirmDeleteGroup"));

            //Delete the group and related db objects.
            if(delete){
                //Kill userGroupBeans
                deleteUserGroups(group.getGroupID());

                //Kill faveFlights
                LinkedList<GroupFaveFlightBean> faveFlights = getGroupFaveFlights(group.getGroupID());
                int size = faveFlights.size();

                for(int i = 0; i < size; i++){
                    GroupFaveFlightBean temp = faveFlights.removeFirst();
                    deleteMessages(temp.getChatID());
                    deleteMemberFlightVotes(group.getGroupID(), temp.getGroupFaveFlightID());
                    deleteGroupFaveFlight(group.getGroupID(), temp.getGroupFaveFlightID());
                    deleteChat(temp.getChatID());
                }

                deleteGroup(group.getGroupID());
                deletePool(group.getPoolID());

                /*
                TagBean
                Calander Bean
                 */

                session.setAttribute("message", "Success! The group was deleted.");
                session.setAttribute("goHome", true);
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupHomepageMessage.jsp");
                requestDispatcher.forward(request, response);
            }
            else{
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
                requestDispatcher.forward(request, response);
            }
        }

        //Go to the homepage after they have deleted a group.
        if(request.getParameter("continue") != null && request.getParameter("goHome") != null){
            response.sendRedirect("Homepage");
        }

        //goes to homepage in cases where user is not added to group
        else if(request.getParameter("continue") != null){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("modifyGroupTags") != null){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ModifyGroupTags.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("addTags") != null){
            String[] tagValues = request.getParameterValues("tagsToAdd[]");
            for (String tagValue : tagValues) {
                try {
                    GroupBean.addToTagSet(groupID, tagValue);
                    group.addTag(tagValue);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
            session.setAttribute("group", group);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }
        if(request.getParameter("removeTags") != null){
            String[] tagValues = request.getParameterValues("tagsToRemove[]");
            for (String tagValue : tagValues) {
                GroupBean.removeFromTagSet(groupID, tagValue);
                group.removeTag(tagValue);
            }
            session.setAttribute("group", group);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }
        if (request.getParameter("submitQuestionnaire") != null) {
            String[] travelGoals = request.getParameterValues("travelGoals[]");
            String[] locations = request.getParameterValues("locations[]");
            String[] valueAdds = request.getParameterValues("valueAdds[]");
            for (String tagValue : travelGoals) {
                try {
                    GroupBean.addToTagSet(groupID, tagValue);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                group.addTag(tagValue);
            }
            for (String tagValue : locations) {
                try {
                    GroupBean.addToTagSet(groupID, tagValue);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                group.addTag(tagValue);
            }
            for (String tagValue : valueAdds) {
                try {
                    GroupBean.addToTagSet(groupID, tagValue);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                group.addTag(tagValue);
            }
            session.setAttribute("group", group);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/ManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }
        if(request.getParameter("completeGroupQuestionnaire") != null){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/GroupQuestionnaire.jsp");
            requestDispatcher.forward(request, response);
        }

    }

    /*
    To do for full implementation:
    - Group will have a tagset attached to the profile.
    - They will therefore be able to modify their tags and complete the questionnaire - allowing for recommended search
      for the group.
     */
}
