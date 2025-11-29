<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="java.util.*"%>
<%@page import="model.CartItem"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- Thêm thư viện format tiền tệ --%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận đặt bánh</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700,900|Rubik:300,400,700" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        body { background: #f7f7fb; font-family: 'Rubik', sans-serif; }
        .confirm-container { max-width: 900px; margin: 40px auto; }
        .card { border-radius: 14px; border: none; box-shadow: 0 12px 30px rgba(0,0,0,0.08); }
        .card h4 { margin-bottom: 16px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 10px; }
        .summary-row span { font-weight: 500; }
    </style>
</head>
<body>

<div class="confirm-container">
    <div class="card p-4 mb-4">
        <h3 class="text-center mb-3">Xác nhận thông tin đặt bánh</h3>
        <p class="text-center text-muted mb-0">Vui lòng kiểm tra lại chi tiết trước khi xác nhận.</p>
    </div>

    <div class="row g-4">
        <div class="col-md-6">
            <div class="card p-4 h-100">
                <h4>Thông tin khách hàng</h4>
                <p><strong>Họ tên:</strong> ${sessionScope.acc.name}</p>
                <p><strong>Email:</strong> ${sessionScope.acc.email}</p>
                <p><strong>Số điện thoại:</strong> ${sessionScope.acc.tel}</p>
                <p><strong>Địa chỉ giao bánh:</strong> ${sessionScope.acc.address}</p>
                <p><strong>Ghi chú:</strong> ${sessionScope.orderNote}</p>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card p-4 h-100">
                <h4>Các bánh đã chọn</h4>
                <ul class="list-group">
                    <c:set var="total" value="0"/>
                    <c:forEach items="${sessionScope.cart}" var="entry">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <strong>${entry.value.banh.name}</strong><br>
                                <small>Số lượng: ${entry.value.quantity}</small>
                            </div>
                            <span><fmt:formatNumber value="${entry.value.subtotal}" pattern="#,###"/> đ</span>
                        </li>
                        <c:set var="total" value="${total + entry.value.subtotal}"/>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>

    <div class="card p-4 mt-4">
        <h4>Tóm tắt đơn hàng</h4>
        <div class="summary-row" style="font-size: 1.2rem;">
            <span><strong>Tổng thanh toán</strong></span>
            <span class="text-success">
                <strong><fmt:formatNumber value="${total}" pattern="#,###"/> đ</strong>
            </span>
        </div>
    </div>

    <div class="text-center mt-4">
        <form action="confirm" method="post">
            <a href="booknow.jsp" class="btn btn-secondary me-2">Quay lại sửa</a>
            <button type="submit" class="btn btn-success px-3">Xác nhận đặt bánh</button>
        </form>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>