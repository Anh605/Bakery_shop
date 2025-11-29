
package controller;

import dao.BillDAO;
import dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.Bill;
import model.Booking;
import model.CartItem;
import model.Customer;

@WebServlet("/confirm")
public class ConfirmSerlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("acc");
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        String note = (String) session.getAttribute("orderNote"); 
        if (customer == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("banhlist");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        BillDAO billDAO = new BillDAO();
        List<Booking> savedBookings = new ArrayList<>();
        float totalPrice = 0f;

        try {
            for (CartItem item : cart.values()) {
                int bookingId = bookingDAO.insertBooking(customer.getId(), item.getBanh().getId(), item.getQuantity(), note, "Cho xac nhan");
                
                if (bookingId != -1) {
                    Timestamp now = new Timestamp(System.currentTimeMillis());
                    Booking booking = new Booking(bookingId, customer, item.getBanh(), item.getQuantity(), note, now, "Cho xac nhan");
                    savedBookings.add(booking);
                    float subTotal = item.getSubtotal();
                    totalPrice += subTotal;
                    billDAO.insertBill(new Bill(booking, subTotal));
                }
            }
            session.removeAttribute("cart");
            session.removeAttribute("orderNote");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!doctype html><html lang='vi'><head>");
                out.println("<meta charset='UTF-8'><title>Đặt hàng thành công</title>");
                out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>");
                out.println("</head><body><div class='container mt-5 text-center'>");
                
                out.println("<div class='alert alert-success shadow p-5 rounded'>");
                out.println("<h2>Đặt hàng thành công!</h2>");
                out.println("<p class='lead'>Cảm ơn <b>" + customer.getName() + "</b>đã đặt hàng.</p>");
                
                out.println("<div class='card mt-4 mx-auto' style='max-width: 600px;'>");
                out.println("<div class='card-header bg-transparent'>Chi tiết đơn hàng</div>");
                out.println("<ul class='list-group list-group-flush text-start'>");
                
                for (Booking b : savedBookings) {
                    out.println("<li class='list-group-item d-flex justify-content-between'>");
                    out.println("<span>" + b.getBanh().getName() + " (x" + b.getQuantity() + ")</span>");
                    out.println("<span>" + String.format("%,.0f", b.getBanh().getFinalPrice() * b.getQuantity()) + " đ</span>");
                    out.println("</li>");
                }
                
                out.println("</ul>");
                out.println("<div class='card-footer bg-transparent fw-bold text-end'>Tổng cộng: " + String.format("%,.0f", totalPrice) + " đ</div>");
                out.println("</div>");

                out.println("<a href='banhlist' class='btn btn-primary mt-4'> Tiếp tục mua sắm</a>");
                out.println("</div></div></body></html>");
            }

        } catch (Exception e) {
            response.sendRedirect("booknow.jsp?error=SystemError");
        }
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
