
package controller;

import dao.CustomerDAO;
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
        Customer customer = (Customer) session.getAttribute("acc");
        if (customer == null) {
            request.setAttribute("error", "Bạn phải đăng nhập để đặt hàng!");
            request.getRequestDispatcher("booknow.jsp").forward(request, response);
            return;
        }
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Giỏ hàng trống!");
            request.getRequestDispatcher("booknow.jsp").forward(request, response);
            return;
        }
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        if (name != null) customer.setName(name);
        if (phone != null) customer.setTel(phone); 
        if (address != null) customer.setAddress(address);
        
        session.setAttribute("acc", customer);
        
        session.setAttribute("orderNote", note);
        if (address != null && !address.isEmpty()) {
        new CustomerDAO().updateAddress(customer.getId(), address);
}

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
