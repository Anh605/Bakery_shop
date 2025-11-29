
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Lấy dữ liệu từ form (trong dropdown header hoặc trang login riêng)
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        
        CustomerDAO dao = new CustomerDAO();
        Customer a = dao.login(email, pass);
        
        if (a == null) {
            // Đăng nhập thất bại
            request.setAttribute("mess", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            // Đăng nhập thành công -> Lưu vào Session
            HttpSession session = request.getSession();
            session.setAttribute("acc", a); // "acc" là biến dùng để check login trên JSP
            session.setMaxInactiveInterval(60 * 60 * 24); // Session tồn tại 1 ngày
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}