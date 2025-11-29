<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="java.util.*"%>
<%@page import="model.Banh"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách bánh - Sugar & Smile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700,900|Rubik:300,400,700" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="fonts/ionicons/css/ionicons.min.css">
    <link rel="stylesheet" href="fonts/fontawesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/style.css">

    <style>
        .banh-card { border-radius: 12px; overflow: hidden; box-shadow: 0 6px 18px rgba(0,0,0,0.15); transition: 0.3s; margin-bottom: 20px; }
        .banh-card:hover { transform: translateY(-5px); box-shadow:0 12px 22px rgba(0,0,0,0.22);}
        .banh-btn-group { display:flex; gap:10px; margin-top:10px;}
        .btn-detail { padding:10px 18px; border:none; border-radius:8px; background:#007bff; color:#fff; cursor:pointer; transition:0.25s; }
        .btn-detail:hover { background:#0056b3; transform:translateY(-2px);}
        .btn-book { padding:10px 18px; border-radius:8px; background:#ff7a18; color:#fff; text-decoration:none; transition:0.25s; }
        .btn-book:hover { background:#ff5500; transform:translateY(-2px);}
        figure img { width:100%; border-radius:12px 12px 0 0; }
        figure { position:relative; margin:0;}
        figure span { position:absolute; bottom:10px; left:0; background:rgba(0,0,0,0.6); padding:5px 10px; color:#fff; font-weight:bold; }
        
    
        .user-profile-box {
            position: relative;
            display: flex;
            align-items: center;
            height: 100%;
            padding-left: 15px;
            cursor: pointer;
        }
        .logout-dropdown {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: white;
            padding: 10px 20px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            border-radius: 4px;
            z-index: 9999;
            min-width: 150px;
        }
        .logout-dropdown a {
            color: #dc3545 !important;
            text-decoration: none;
            display: block;
            font-weight: bold;
        }
        .user-profile-box:hover .logout-dropdown {
            display: block;
        }
    </style>
</head>
<body>
<header role="banner">
    <nav class="navbar navbar-expand-md navbar-dark bg-light">
      <div class="container">
        <a class="navbar-brand" href="index.jsp">Sugar & Smile</a>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarsExample05"
          aria-controls="navbarsExample05"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <div
          class="collapse navbar-collapse navbar-light"
          id="navbarsExample05"
        >
          <ul class="navbar-nav ml-auto pl-lg-5 pl-0">
            <li class="nav-item">
              <a class="nav-link" href="index.jsp">Trang chủ</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="banhlist">Bánh</a> 
            </li>

            <li class="nav-item">
              <a class="nav-link" href="about.jsp">Giới thiệu</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="contact.jsp">Liên hệ</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="cart">Giỏ hàng</a>
            </li>

            <c:if test="${sessionScope.acc == null}">
              <li class="nav-item dropdown">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  id="navbarDropdown"
                  role="button"
                  data-toggle="dropdown"
                  aria-haspopup="true"
                  aria-expanded="false"
                >
                  Tài khoản
                </a>
                <div
                  class="dropdown-menu dropdown-menu-right login-dropdown"
                  aria-labelledby="navbarDropdown"
                >
                  <c:if test="${not empty mess}">
                    <div
                      class="alert alert-danger p-2 m-2"
                      style="font-size: 13px"
                    >
                      ${mess}
                    </div>
                  </c:if>

                  <form class="px-2 py-2" action="login" method="post">
                    <div class="form-group">
                      <label>Email</label>
                      <input
                        type="email"
                        name="email"
                        class="form-control"
                        placeholder="email@example.com"
                        required
                      />
                    </div>
                    <div class="form-group">
                      <label>Mật khẩu</label>
                      <input
                        type="password"
                        name="password"
                        class="form-control"
                        placeholder="Mật khẩu"
                        required
                      />
                    </div>
                    <div class="form-check mb-3">
                      <input
                        type="checkbox"
                        class="form-check-input"
                        id="dropdownCheck"
                      />
                      <label class="form-check-label" for="dropdownCheck"
                        >Ghi nhớ tôi</label
                      >
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">
                      Đăng nhập
                    </button>
                  </form>
                  <div class="dropdown-divider"></div>
                  <a class="dropdown-item text-primary" href="dangky.html"
                    >Chưa có tài khoản? Đăng ký ngay</a
                  >
                </div>
              </li>
            </c:if>

            <c:if test="${sessionScope.acc != null}">
              <li class="nav-item">
                <div class="user-profile-box">
                  <span
                    style="font-weight: bold; font-size: 16px; color: #b99365"
                  >
                    ${sessionScope.acc.name} &nbsp;
                    <i class="fa fa-angle-down"></i>
                  </span>

                  <div class="logout-dropdown">
                    <a href="logout">
                      <i class="fa fa-sign-out"></i> Đăng xuất
                    </a>
                  </div>
                </div>
              </li>
            </c:if>
            </ul>
        </div>
      </div>
    </nav>
</header>
<section class="site-hero site-hero-innerpage overlay" data-stellar-background-ratio="0.5"
         style="background-image: url(https://shopbanghe.vn/wp-content/uploads/2021/06/thi%E1%BA%BFt-k%E1%BA%BF-n%E1%BB%99i-th%E1%BA%A5t-c%E1%BB%ADa-h%C3%A0ng-b%C3%A1nh-ng%E1%BB%8Dt-2.jpg);">
    <div class="container">
        <div class="row align-items-center site-hero-inner justify-content-center">
            <div class="col-md-12 text-center">
                <div class="mb-5 element-animate">
                    <h1>Danh sách bánh</h1>
                    <p>Các loại bánh ngon và chất lượng nhất từ Sugar & Smile</p>
                </div>
<!--                <a href="about.html"></a>-->
            </div>
        </div>
    </div>
</section>


                    
<%
    ArrayList<Banh> arr = (ArrayList<Banh>) request.getAttribute("data");
    String contextPath = request.getContextPath();
%>

<section class="site-section">
        <div class="row">
            <% if (arr != null) { 
                for(Banh b : arr) { %>
                <div class="col-md-4">
                    <div class="banh-card">
                        <figure>
                            <img src="<%= b.getMainImage() %>" alt="Bánh">
                            <span><%= b.getFormattedPrice() %> ₫</span>
                        </figure>
                        <div class="p-3">
                            <h5><%= b.getName() %></h5>
                            <p><%= b.getDescription() %></p>
                            <form action="<%= contextPath %>/cart" method="post" class="banh-btn-group align-items-center">
                                <input type="hidden" name="id" value="<%= b.getId() %>">
                                <input type="number" name="quantity" min="1" value="1" class="form-control" style="max-width:80px;">
                                <button type="submit" class="btn-detail">Thêm vào giỏ</button>
                            </form>
                        </div>
                    </div>
                </div>
            <% }} else { %>
                <div class="col-12 text-center">
                    <p>Không có dữ liệu bánh!</p>
                </div>
            <% } %>
        </div>
    </div>
</section>

<footer class="site-footer">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-4">
            <h3>Số điện thoại liên hệ</h3>
            <p><i class="icon ion-android-call"></i>&nbsp 0323 093 323</p>
          </div>
          <div class="col-md-4">
            <h3>Liên hệ với chúng tôi</h3>
            <p>
              <a href="#" class="pl-0 p-3"
                ><span class="fa fa-facebook"></span
              ></a>
              <a href="#" class="p-3"><span class="fa fa-twitter"></span></a>
              <a href="#" class="p-3"><span class="fa fa-instagram"></span></a>
              <a href="#" class="p-3"><span class="fa fa-vimeo"></span></a>
              <a href="#" class="p-3"
                ><span class="fa fa-youtube-play"></span
              ></a>
            </p>
          </div>
          <div class="col-md-4">
            <h3>Thông điệp</h3>
            <p>Niềm vui của khách hàng là niềm hạnh phúc của Sugar & Smile.</p>
          </div>
        </div>
      </div>
    </footer>
        
        
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/jquery-migrate-3.0.0.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>

    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/magnific-popup-options.js"></script>

    <script src="js/main.js"></script>
</body>
</html>
