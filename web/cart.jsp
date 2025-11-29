<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="model.CartItem"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng - Sugar & Smile</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<header role="banner">
    <nav class="navbar navbar-expand-md navbar-dark bg-light">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Sugar & Smile</a>
            <div class="collapse navbar-collapse navbar-light" id="navbarsExample05">
                <ul class="navbar-nav ml-auto pl-lg-5 pl-0">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/banhlist">Bánh</a></li>
                    <li class="nav-item active"><a class="nav-link" href="<%= request.getContextPath() %>/cart">Giỏ hàng</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<section class="site-section">
    <div class="container">
        <h2 class="mb-4">Giỏ hàng</h2>
        <%
            Collection<CartItem> cartItems = (Collection<CartItem>) request.getAttribute("cartItems");
            if (cartItems == null) cartItems = Collections.emptyList();
            float total = 0;
        %>
        <% if (cartItems.isEmpty()) { %>
            <div class="alert alert-info">Giỏ hàng trống. Hãy quay lại <a href="<%= request.getContextPath() %>/banhlist">danh sách bánh</a>.</div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Bánh</th>
                            <th>Số lượng</th>
                            <th>Giá gốc</th>
                            <th>Giá sau giảm</th>
                            <th>Tạm tính</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (CartItem item : cartItems) {
                               total += item.getSubtotal();
                        %>
                        <tr>
                            <td><%= item.getBanh().getName() %></td>
                            <td><%= item.getQuantity() %></td>
                            <td><%= String.format("%,.0f",item.getSumrawPrice()) %> đ</td>
                            <td><%= String.format("%,.0f", item.getSumsalePrice()) %> đ</td>
                            <td><%= String.format("%,.0f", item.getSubtotal()) %> đ</td>
                            <td>
                                <form action="<%= request.getContextPath() %>/cart" method="post">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="id" value="<%= item.getBanh().getId() %>">
                                    <button class="btn btn-danger btn-sm" type="submit">Xóa</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <div class="d-flex justify-content-between align-items-center">
                <h4>Tổng cộng: <%= String.format("%,.0f", total) %> đ</h4>
                <div>
                    <a href="<%= request.getContextPath() %>/banhlist" class="btn btn-secondary">Tiếp tục chọn bánh</a>
                    <a href="booknow.jsp" class="btn btn-primary">Thanh toán</a>
                </div>
            </div>
        <% } %>
    </div>
</section>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>