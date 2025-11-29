
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy phiên làm việc (session) hiện tại
        // Tham số 'false' nghĩa là: nếu chưa có session thì không tạo mới (trả về null)
        HttpSession session = request.getSession(false);
        
        // 2. Nếu session tồn tại, thực hiện hủy (invalidate)
        if (session != null) {
            session.invalidate(); // Xóa sạch dữ liệu trong session (như biến "acc")
        }
        
        // 3. Chuyển hướng người dùng về trang chủ (hoặc trang đăng nhập)
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}