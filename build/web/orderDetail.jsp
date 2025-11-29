<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, model.*" %>

<%
    Customer customer = (Customer) request.getAttribute("customer");
    List<Booking> orderBookings = (List<Booking>) request.getAttribute("orderBookings");
    Float totalPrice = (Float) request.getAttribute("totalPrice");
    Date orderTime = (Date) request.getAttribute("orderTime");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    if (customer == null || orderBookings == null || orderBookings.isEmpty() || orderTime == null) {
        response.sendRedirect("admin");
        return;
    }

    // Lấy status chung (lấy của booking đầu tiên)
    String orderStatus = orderBookings.get(0).getStatus();
    if (orderStatus == null) orderStatus = "Cho xac nhan";

    // Xử lý ghi chú an toàn
    String note = "";
    if (orderBookings.get(0).getNote() != null && !orderBookings.get(0).getNote().isEmpty()) {
        note = orderBookings.get(0).getNote();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background: #f7f9fc; padding-bottom: 40px; }
        .container { margin-top: 35px; max-width: 900px; }
        h2 { color: #2d5567; }
        .btn-back { background-color: #7db9b6; border: none; }
        .order-card { background: #ffffff; border-radius: 12px; padding: 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.06); }
        .note { margin-top: 10px; font-style: italic; color: #333; background: #f3f8f7; padding: 10px; border-radius: 8px; border-left: 4px solid #7db9b6; }
    </style>
</head>
<body>
<div class="container">
    <h2><i class="bi bi-card-checklist"></i> Chi tiết đơn hàng</h2>
    <a href="admin" class="btn btn-back text-white mb-3"><i class="bi bi-arrow-left"></i> Quay về danh sách</a>

    <div class="order-card">
        <p><b>Khách hàng:</b> <%= customer.getName() %></p>
        <p><b>Email:</b> <%= customer.getEmail() %></p>
        <p><b>SĐT:</b> <%= customer.getTel() %></p>
        <p><b>Thời gian đặt:</b> <%= sdf.format(orderTime) %></p>
        <p><b>Địa chỉ:</b> <%= customer.getAddress() != null ? customer.getAddress() : "" %></p>

        <!-- 1 dropdown trạng thái cho cả đơn -->
        <div class="mb-3">
            <b>Trạng thái đơn:</b>
            <span class="badge bg-primary ms-2" id="status-display"><%= orderStatus %></span>

            <form action="updateStatus" method="post" id="status-form" class="d-flex mt-2" style="display:none; align-items:center;">
                <input type="hidden" name="email" value="<%= customer.getEmail() %>">
                <input type="hidden" name="time" value="<%= sdf.format(orderTime) %>">

                <select name="status" class="form-select form-select-sm me-2" style="max-width:180px;">
                     <option value="Cho xac nhan" <%= "Cho xac nhan".equals(orderStatus) ? "selected" : "" %>>Cho xac nhan</option>
                        <option value="Da xac nhan" <%= "Da xac nhan".equals(orderStatus) ? "selected" : "" %>>Da xac nhan</option>
                        <option value="Dang giao hang" <%= "Dang giao hang".equals(orderStatus) ? "selected" : "" %>>Dang giao hang</option>
                        <option value="Giao hang thanh cong" <%= "Giao hang thanh cong".equals(orderStatus) ? "selected" : "" %>>Giao hang thanh cong</option>
                        <option value="Da huy" <%= "Da huy".equals(orderStatus) ? "selected" : "" %>>Da huy</option>
                </select>

                <button type="submit" class="btn btn-success btn-sm">Cập nhật</button>
            </form>
        </div>

        <hr>

        <div class="mb-3">
            <b>Sản phẩm:</b>
            <div class="mt-2">
                <% for (Booking b : orderBookings) { %>
                    <div class="d-flex justify-content-between py-2 border-bottom">
                        <div><%= b.getBanh().getName() %> (x<%= b.getQuantity() %>)</div>
                        <div><%= String.format("%,.0f", b.getBanh().getFinalPrice() * b.getQuantity()) %> đ</div>
                    </div>
                <% } %>
            </div>
        </div>

        <div class="note">
            <b>Ghi chú:</b> <%= note %>
        </div>

        <div class="mt-3 text-end fw-bold">
            Tổng cộng: <%= String.format("%,.0f", totalPrice) %> đ
        </div>
    </div>
</div>

<script>
function showStatusForm() {
    document.getElementById("status-form").style.display = "flex";
    document.getElementById("status-display").style.display = "none";
}
</script>
</body>
</html> 
