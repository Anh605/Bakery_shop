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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import model.Booking;
import model.Customer;
import model.Bill;

@WebServlet("/orderDetail")
public class OrderDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer cus = (Customer) session.getAttribute("acc");

        if (cus == null || !"admin".equals(cus.getRole())) {
            response.sendRedirect("index.jsp");
            return;
        }

        String email = request.getParameter("email");
        String timeStr = request.getParameter("time");

        if (email == null || timeStr == null) {
            response.sendRedirect("admin");
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date orderTime = null;
        try {
            orderTime = sdf.parse(timeStr);
        } catch (ParseException e) {
            response.sendRedirect("admin");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        BillDAO billDAO = new BillDAO();

        List<Booking> allBookings = bookingDAO.getAllBooking();
        List<Booking> orderBookings = new ArrayList<>();
        float totalPrice = 0f;

        for (Booking b : allBookings) {
            String bEmail = b.getCustomer().getEmail();
            String bTime = sdf.format(b.getOrderTime());
            if (bEmail.equals(email) && bTime.equals(timeStr)) {
                orderBookings.add(b);
                Bill bill = billDAO.getBillByBookingId(b.getId());
                if (bill != null) totalPrice += bill.getTotalPrice();
            }
        }

        request.setAttribute("orderBookings", orderBookings);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("customer", orderBookings.isEmpty() ? null : orderBookings.get(0).getCustomer());
        request.setAttribute("orderTime", orderTime);

        request.getRequestDispatcher("orderDetail.jsp").forward(request, response);
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
