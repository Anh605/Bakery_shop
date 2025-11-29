<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat, model.*" %>
<%
    Customer cus = (Customer) session.getAttribute("acc");
    if (cus == null || !"admin".equals(cus.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Map<String, Object>> ordersList = (List<Map<String, Object>>) request.getAttribute("ordersList");
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif; background: #f7f9fc; padding-bottom: 40px; }
        .container { margin-top: 35px; }
        h2 { color: #2d5567; font-weight: bold; margin-bottom: 20px; }
        .btn-home { background-color: #7db9b6; border: none; }
        .btn-home:hover { background-color: #69a7a3; }
        .order-card { background: #ffffff; border-radius: 14px; border: 1px solid #e3ecf0; box-shadow: 0 4px 12px rgba(0,0,0,0.06); padding: 22px; margin-bottom: 20px; transition: 0.25s; }
        .order-card:hover { transform: translateY(-4px); box-shadow: 0 6px 18px rgba(0,0,0,0.12); }
        .order-header h5 { color: #355c7d; font-weight: bold; }
        .badge-total { font-size: 1rem; padding: 8px 14px; border-radius: 8px; background: #7db9b6; }
        .note { margin-top: 10px; font-style: italic; color: #555; background: #f3f8f7; padding: 10px 12px; border-radius: 8px; border-left: 4px solid #7db9b6; }
        a.order-link { text-decoration: none; color: inherit; }
        .status-form { display: flex; align-items: center; margin-top: 5px; }
        .status-badge { cursor: pointer; }
    </style>
</head>

<body>
<div class="container">
    <h2><i class="bi bi-card-checklist"></i> Quản lý đơn hàng</h2>

    <a class="btn btn-home text-white mb-3" href="index.jsp">
        <i class="bi bi-house-door-fill"></i> Quay về trang chủ
    </a>

    <%
        if (ordersList != null && !ordersList.isEmpty()) {
            ordersList.sort(Comparator.comparing(o -> (Date)o.get("orderTime")));
            int index = 1;
            for (Map<String, Object> order : ordersList) {
                Customer customer = (Customer) order.get("customer");
                List<Booking> orderBookings = (List<Booking>) order.get("orderBookings");
                String timeKey = sdf.format(order.get("orderTime"));
                Float totalPrice = (Float) order.get("totalPrice");
                String productsGop = (String) order.get("products");
                String noteGop = (String) order.get("note");

                String orderStatus = "Cho xac nhan";
                if(orderBookings != null && !orderBookings.isEmpty() && orderBookings.get(0).getStatus()!=null) {
                    orderStatus = orderBookings.get(0).getStatus();
                }
    %>
    <a href="orderDetail?email=<%= customer.getEmail() %>&time=<%= timeKey %>" class="order-link">
        <div class="order-card">
            <div class="order-header d-flex justify-content-between align-items-center">
                <h5>Đơn hàng <%= index %> - <%= customer.getName() %></h5>
                <span class="badge badge-total text-white">
                    <%= String.format("%,.0f", totalPrice) %> đ
                </span>
            </div>

            <!-- Thông tin khách hàng -->
            <p>
                <i class="bi bi-envelope-fill"></i> <b>Email:</b> <%= customer.getEmail() %>
                &nbsp; | &nbsp;
                <i class="bi bi-telephone-fill"></i> <b>SĐT:</b> <%= customer.getTel() %>
                &nbsp; | &nbsp;
                <i class="bi bi-clock-fill"></i> <b>Thời gian:</b> <%= timeKey %>
            </p>
            <p>
                <i class="bi bi-geo-alt-fill"></i> <b>Địa chỉ:</b> <%= customer.getAddress() %>
            </p>

            <!-- Hiển thị trạng thái -->
            <div>
                <b>Trạng thái:</b>
                <span class="badge bg-primary status-badge" onclick="showForm('<%=index%>')"><%= orderStatus %></span>

                <form class="status-form" id="status-form-<%=index%>" action="updateStatus" method="post" style="display:none;">
                    <input type="hidden" name="email" value="<%= customer.getEmail() %>">
                    <input type="hidden" name="time" value="<%= timeKey %>">
                    <select name="status" class="form-select form-select-sm me-2" style="max-width:180px;">
                        <option value="Cho xac nhan" <%= "Cho xac nhan".equals(orderStatus)?"selected":"" %>>Cho xac nhan</option>
                        <option value="Da xac nhan" <%= "Da xac nhan".equals(orderStatus)?"selected":"" %>>Da xac nhan</option>
                        <option value="Dang giao hang" <%= "Dang giao hang".equals(orderStatus)?"selected":"" %>>Dang giao hang</option>
                        <option value="Giao hang thanh cong" <%= "Giao hang thanh cong".equals(orderStatus)?"selected":"" %>>Giao hang thanh cong</option>
                        <option value="Da huy" <%= "Da huy".equals(orderStatus)?"selected":"" %>>Da huy</option>
                    </select>
                    <button type="submit" class="btn btn-success btn-sm">Cập nhật</button>
                </form>
            </div>

            <hr>

            <!-- Hiển thị sản phẩm -->
            <div>
                <ul>
                <% 
                    if(orderBookings != null){
                        for(Booking b : orderBookings){ 
                %>
                    <li><%= b.getBanh().getName() %> (x<%= b.getQuantity() %>)</li>
                <% 
                        } 
                    } 
                %>
                </ul>
            </div>

            <div class="note">
                <b>Ghi chú:</b> <%= noteGop %>
            </div>
        </div>
    </a>
    <%
            index++;
            } // end for
        } else {
    %>
        <div class="alert alert-info">Chưa có đơn hàng nào.</div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function showForm(index){
    document.getElementById("status-form-"+index).style.display = "flex";
}
</script>
</body>
</html>
