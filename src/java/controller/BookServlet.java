
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Customer;
import java.util.Map;

@WebServlet("/book")
public class BookServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();

        // 1. Kiểm tra đăng nhập
        Customer customer = (Customer) session.getAttribute("acc");
        if (customer == null) {
            request.setAttribute("error", "Bạn phải đăng nhập để đặt hàng!");
            request.getRequestDispatcher("booknow.jsp").forward(request, response);
            return;
        }

        // 2. Kiểm tra giỏ hàng
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống!");
            request.getRequestDispatcher("booknow.jsp").forward(request, response);
            return;
        }

        // 3. --- SỬA LỖI TẠI ĐÂY: Lấy thông tin mới từ form và Cập nhật vào Session ---
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");

        // Cập nhật lại thông tin cho đối tượng Customer trong Session
        // Để khi sang trang xác nhận, nó sẽ hiện thông tin mới nhất vừa nhập
        if (name != null) customer.setName(name);
        if (phone != null) customer.setTel(phone); // Hoặc setPhone(phone) tùy vào code model của bạn
        if (address != null) customer.setAddress(address);
        
        // Lưu đối tượng đã cập nhật ngược lại vào session (để chắc chắn)
        session.setAttribute("acc", customer);
        
        session.setAttribute("orderNote", note);

        // 4. Chuyển hướng sang trang Xem lại đơn hàng
        request.getRequestDispatcher("bookconfirm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}