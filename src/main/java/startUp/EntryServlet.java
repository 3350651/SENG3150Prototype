package startUp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = { "" })
public class EntryServlet extends HttpServlet {

    @Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("login");
    }

    @Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
