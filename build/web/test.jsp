<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Không thành công - Sugar & Smile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- CSS -->
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700,900|Rubik:300,400,700" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Rubik', sans-serif;
        }
        .error-card {
            margin-top: 80px;
            max-width: 600px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        }
        .error-card h4 {
            color: #dc3545;
        }
        .btn-primary {
            background-color: #ff7a18;
            border-color: #ff7a18;
        }
        .btn-primary:hover {
            background-color: #ff5500;
            border-color: #ff5500;
        }
    </style>
</head>
<body>

<%
    ArrayList<String> arr = (ArrayList<String>) request.getAttribute("data");
%>

<div class="container">
    <div class="card error-card mx-auto p-4">
        <div class="card-body text-center">
            <h4 class="alert-heading mb-3"> Lỗi đặt bánh!</h4>
            <p class="mb-3">Rất tiếc, hiện tại bánh bạn chọn đã hết hoặc không thể đặt.</p>

            <% if (arr != null && !arr.isEmpty()) { %>
                <ul class="list-unstyled">
                    <% for (String msg : arr) { %>
                        <li><p class="text-danger"><%= msg %></p></li>
                    <% } %>
                </ul>
            <% } else { %>
                <p class="text-muted">Không có thông tin chi tiết lỗi.</p>
            <% } %>

            <hr>
            <a href="<%= request.getContextPath() %>/banhlist" class="btn btn-primary mt-3">
                 Trở về danh sách bánh
            </a>
        </div>
    </div>
</div>

</body>
</html>
