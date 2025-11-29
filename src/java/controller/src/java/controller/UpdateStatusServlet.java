package controller;

import dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String timeStr = request.getParameter("time");
        String status = request.getParameter("status");

        if (email == null || timeStr == null || status == null) {
            response.sendRedirect("admin");
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date orderTime = sdf.parse(timeStr);
            Timestamp ts = new Timestamp(orderTime.getTime());

            BookingDAO bookingDAO = new BookingDAO();
            bookingDAO.updateOrderStatus(email, ts, status);

        } catch (ParseException e) {
        }

        // redirect về orderDetail (encode params để an toàn)
        String redirectUrl = "orderDetail?email=" + URLEncoder.encode(email, "UTF-8")
                + "&time=" + URLEncoder.encode(timeStr, "UTF-8");
        response.sendRedirect(redirectUrl);
    }
}
