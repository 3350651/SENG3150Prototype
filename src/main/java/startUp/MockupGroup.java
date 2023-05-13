package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.http.*;

@WebServlet(urlPatterns = { "/MockupGroup" })
public class MockupGroup extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        RequestDispatcher requestDispatcher = null;

        requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockGroup.jsp");
        requestDispatcher.forward(request, response);

    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        RequestDispatcher requestDispatcher = null;

        if(request.getParameter("getPool") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockPool.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("manageGroup") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("addMember") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockAddMember.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("memberAdded") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("removeMember") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockRemoveMember.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("memberRemoved") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("addPool") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockAddPool.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("moneyAdded") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockPool.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("other") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockManageGroup.jsp");
            requestDispatcher.forward(request, response);
        }

        if(request.getParameter("withdraw") != null){
            requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockPool.jsp");
            requestDispatcher.forward(request, response);
        }


        requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/MockGroup.jsp");
        requestDispatcher.forward(request, response);
    }


}
