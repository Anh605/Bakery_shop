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
import java.text.SimpleDateFormat;
import java.util.*;
import model.Bill;
import model.Booking;
import model.Customer;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin"})
public class AdminOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("acc");

        // Kiểm tra quyền admin
        if (cus == null || !"admin".equals(cus.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        BillDAO billDAO = new BillDAO();

        // Lấy tất cả booking
        List<Booking> bookings = bookingDAO.getAllBooking();

        // Gom theo email + thời gian đặt hàng 
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Map<String, List<Booking>> ordersMap = new LinkedHashMap<>();
        for (Booking b : bookings) {
            String timeKey = sdf.format(b.getOrderTime());
            String key = b.getCustomer().getEmail() + "_" + timeKey;
            ordersMap.computeIfAbsent(key, k -> new ArrayList<>()).add(b);
        }

        // Chuyển sang list để JSP dễ hiển thị
        List<Map<String, Object>> ordersList = new ArrayList<>();
        for (Map.Entry<String, List<Booking>> entry : ordersMap.entrySet()) {
            List<Booking> list = entry.getValue();
            Map<String, Object> order = new HashMap<>();
            Customer customer = list.get(0).getCustomer();
            order.put("customer", customer);
            order.put("note", list.get(0).getNote());
            order.put("orderTime", list.get(0).getOrderTime());

            // Gom sản phẩm + tổng tiền
            StringBuilder products = new StringBuilder();
            float totalPrice = 0f;
            for (Booking b : list) {
                products.append(b.getBanh().getName())
                        .append(" (x").append(b.getQuantity()).append(")<br>");
                Bill bill = billDAO.getBillByBookingId(b.getId());
                if (bill != null) totalPrice += bill.getTotalPrice();
            }
            order.put("products", products.toString());
            order.put("totalPrice", totalPrice);
            order.put("orderBookings", list);

            ordersList.add(order);
        }

        request.setAttribute("ordersList", ordersList);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
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
