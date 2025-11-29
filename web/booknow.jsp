<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="java.util.*"%>
<%@page import="model.CartItem"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt bánh - Sugar & Smile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        body { background-color: #f9f9f9; }
        .container { margin-top: 50px; }
        .card { border-radius: 12px; box-shadow: 0 6px 18px rgba(0,0,0,0.1); }
        .btn-primary { background-color: #ff7a18; border-color: #ff7a18; }
        .btn-primary:hover { background-color: #ff5500; border-color: #ff5500; }
    </style>
</head>
<body>

<%
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    if (cart == null) cart = new LinkedHashMap<>();
    boolean emptyCart = cart.isEmpty();
    Float totalPrice = 0f;
    for (CartItem item : cart.values()) {
        totalPrice += item.getSubtotal();
    }
%>

<div class="container mt-4">
    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-4">
            ${error}
            
            <c:if test="${sessionScope.acc == null}">
                <br>
                <a href="dangky.html" style="font-weight: bold; text-decoration: underline;">
                    Nhấn vào đây để Đăng nhập ngay
                </a> 
            </c:if>
        </div>
    </c:if>
    <% if (emptyCart) { %>
        <div class="text-center">
            <h3 class="text-danger">Giỏ hàng trống!</h3>
            <a href="<%= request.getContextPath() %>/banhlist" class="btn btn-primary mt-3">⬅ Quay lại danh sách bánh</a>
        </div>
    </div>
        <% } else { %>
            <div class="row">
                <div class="col-md-7 mb-4">
                    <div class="card p-4">
                        <h3 class="mb-4">Thông tin giao hàng</h3>
                        
                        <form action="book" method="post">
                            
                            <div class="form-group mb-3">
                                <label>Họ và tên</label>
                                <input type="text" name="name" class="form-control" placeholder="Tên của bạn" 
                                       value="${sessionScope.acc != null ? sessionScope.acc.name : ''}" required>
                            </div>
                            
                            <div class="form-group mb-3">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" 
                                       value="${sessionScope.acc != null ? sessionScope.acc.email : ''}" required>
                            </div>
                            
                            <div class="form-group mb-3">
                                <label>Số điện thoại</label>
                                <input type="tel" name="phone" class="form-control" placeholder="Số điện thoại" 
                                       value="${sessionScope.acc != null ? sessionScope.acc.tel : ''}" required>
                                       
                            </div>
                            
                            <div class="form-group mb-3">
                                <label>Địa chỉ giao bánh</label>
                                <input type="text" name="address" class="form-control" placeholder="Số nhà, đường, quận/huyện" 
                                       value="${sessionScope.acc != null ? sessionScope.acc.address : ''}" required>
                            </div>
                            
                            <div class="form-group mb-4">
                                <label>Ghi chú</label>
                                <textarea name="note" class="form-control" rows="2"></textarea>
                            </div>

                            <c:if test="${sessionScope.acc != null}">
                                <input type="hidden" name="customerId" value="${sessionScope.acc.id}">
                            </c:if>

                            <button type="submit" class="btn btn-primary w-100">Đặt hàng</button>
                        </form>
                        </div>
                </div>
        <div class="col-md-5">
            <div class="card p-4">
                <h3 class="mb-4">Đơn hàng của bạn</h3>
                <ul class="list-group mb-3">
                    <% for (CartItem item : cart.values()) { %>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong><%= item.getBanh().getName() %></strong><br>
                                <small>Số lượng: <%= item.getQuantity() %></small>
                            </div>
                            <span><%= String.format("%,.0f", item.getSubtotal()) %> đ</span>
                        </li>
                    <% } %>
                </ul>
                <h4 class="text-end">Tổng cộng: <%= String.format("%,.0f", totalPrice) %> đ</h4>
            </div>
        </div>
    </div>
    <% } %>
</div>

</body>
</html>