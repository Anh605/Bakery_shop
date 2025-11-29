package controller;

import dao.BanhDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Banh;

@WebServlet("/banhlist")
public class BanhListServLet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        BanhDAO banhDAO = new BanhDAO();

        ArrayList<Banh> list = banhDAO.getAllBanh();

        if (list != null && !list.isEmpty()) {
            request.setAttribute("data", list);
        } else {
            request.setAttribute("error", "Không có dữ liệu bánh!");
        }

        request.getRequestDispatcher("banhlist.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
