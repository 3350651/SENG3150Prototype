package startUp;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = { "/recSearch" })
public class mockRecSearch extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Mock-Rec-Home.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (request.getParameter("searchResults") != null) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Mock-Rec-SearchResults.jsp");
            requestDispatcher.forward(request, response);
        }

        if (request.getParameter("saveParam") != null) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Mock-Rec-Home-SavedParam.jsp");
            requestDispatcher.forward(request, response);
        }
    }


}