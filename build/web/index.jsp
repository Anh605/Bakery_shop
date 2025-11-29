<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <title>Sugar & Smile</title>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />

    <link
      href="https://fonts.googleapis.com/css?family=Playfair+Display:400,700,900|Rubik:300,400,700"
      rel="stylesheet"
    />

    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/animate.css" />
    <link rel="stylesheet" href="css/owl.carousel.min.css" />

    <link rel="stylesheet" href="fonts/ionicons/css/ionicons.min.css" />
    <link rel="stylesheet" href="fonts/fontawesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/magnific-popup.css" />

    <link rel="stylesheet" href="css/style.css" />
    <style>
    /* ... giữ các style cũ nếu có ... */

    /* 1. Thiết lập vùng chứa tên user */
    .user-profile-box {
      position: relative; /* Để nút đăng xuất định vị theo khung này */
      display: flex;
      align-items: center;
      height: 100%;
      padding-left: 15px;
      cursor: pointer;
    }

    /* 2. Style cho menu con chứa nút đăng xuất (Mặc định ẩn) */
    .logout-dropdown {
      display: none; /* Ẩn đi */
      position: absolute;
      top: 100%; /* Hiện ngay bên dưới tên */
      left: 16px;
      background-color: white;
      padding: 12px 21px;
      box-shadow: 0px 4px 10px rgba(0,0,0,0.1); /* Tạo bóng đổ cho đẹp */
      border-radius: 4px;
      z-index: 9999;
      min-width: 150px;
      white-space: nowrap;
    }

    /* 3. Style cho nút đăng xuất bên trong */
    .logout-dropdown a {
      color: #dc3545 !important; /* Màu đỏ */
      text-decoration: none;
      font-size: 13px;
      font-weight: bold;
      display: block;
    }

    .logout-dropdown a:hover {
      text-decoration: underline;
    }

    /* 4. QUAN TRỌNG: Khi di chuột vào vùng tên (.user-profile-box) thì hiện menu (.logout-dropdown) */
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
                <a class="nav-link active" href="index.jsp">Trang chủ</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="banhlist">Bánh</a>
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
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Tài khoản
                  </a>
                  <div class="dropdown-menu dropdown-menu-right login-dropdown" aria-labelledby="navbarDropdown">
                    
                    <c:if test="${not empty mess}">
                        <div class="alert alert-danger p-2 m-2" style="font-size: 13px;">
                            ${mess}
                        </div>
                    </c:if>

                    <form class="px-2 py-2" action="login" method="post">
                      <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" class="form-control" placeholder="email@example.com" required>
                      </div>
                      <div class="form-group">
                        <label>Mật khẩu</label>
                        <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
                      </div>
                      <div class="form-check mb-3">
                        <input type="checkbox" class="form-check-input" id="dropdownCheck">
                        <label class="form-check-label" for="dropdownCheck">Ghi nhớ tôi</label>
                      </div>
                      <button type="submit" class="btn btn-primary btn-block">Đăng nhập</button>
                    </form>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item text-primary" href="dangky.html">Chưa có tài khoản? Đăng ký ngay</a>
                  </div>
                </li>
              </c:if>

              <c:if test="${sessionScope.acc != null}">
    <li class="nav-item">
        <div class="user-profile-box">
            
            <span style="font-weight: bold; font-size: 16px; color: #b99365;">
                ${sessionScope.acc.name} &nbsp; <i class="fa fa-angle-down"></i>
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
    <section
      class="site-hero site-hero overlay"
      data-stellar-background-ratio="0.5"
      style="
        background-image: url(https://shopbanghe.vn/wp-content/uploads/2021/06/thi%E1%BA%BFt-k%E1%BA%BF-n%E1%BB%99i-th%E1%BA%A5t-c%E1%BB%ADa-h%C3%A0ng-b%C3%A1nh-ng%E1%BB%8Dt-2.jpg);
      "
    >
      <div class="container">
        <div
          class="row align-items-center site-hero-inner justify-content-center"
        >
          <div class="col-md-12 text-center">
            <div class="mb-5 element-animate">
              <h1>Sugar & Smile xin chào!</h1>
              <p>Khám phá thế giới bánh ngọt thơm lừng đang chờ bạn!</p>
              <p>
                <a href="banhlist" class="btn btn-primary">Đặt bánh ngay</a>
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="site-section">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-4">
            <div class="heading-wrap text-center element-animate">
              <h2 class="heading">Đến và trải nghiệm</h2>
              <p class="mb-5">
                Chúng tôi mang đến những chiếc bánh thơm lừng, tươi mới mỗi ngày
                để làm ngọt ngào thêm cuộc sống của bạn. Ghé tiệm để cảm nhận
                tình yêu trong từng lớp bánh và từng mùi thơm!
              </p>
              <p>
                <a href="about.jsp" class="btn btn-primary btn-sm"
                  >Tìm hiểu thêm</a
                >
              </p>
            </div>
          </div>
          <div class="col-md-1"></div>
          <div class="col-md-7">
            <img
              src="https://soon.ismcdn.jp/mwimgs/9/a/1200wm/img_9ac4cfed2c577f6fcbffe0bdd76d733689178.jpg"
              alt="Image placeholder"
              class="img-md-fluid"
            />
          </div>
        </div>
      </div>
    </section>
    <section
      class="section-cover"
      data-stellar-background-ratio="0.5"
      style="
        background-image: url(https://shopbanghe.vn/wp-content/uploads/2021/06/thi%E1%BA%BFt-k%E1%BA%BF-n%E1%BB%99i-th%E1%BA%A5t-c%E1%BB%ADa-h%C3%A0ng-b%C3%A1nh-ng%E1%BB%8Dt-2.jpg);
      "
    >
      <div class="container">
        <div class="row justify-content-center align-items-center intro">
          <div class="col-md-9 text-center element-animate">
            <h2>Hãy đến trải nghiệm ngay</h2>
          </div>
        </div>
      </div>
    </section>
    <footer class="site-footer">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-4">
            <h3>Điện thoại liên hệ</h3>
            <p><i class="icon ion-android-call"></i>&nbsp 0323 093 323</p>          
          </div>
          <div class="col-md-4">
            <h3>Kết nối với chúng tôi</h3>
            <p>
              <a href="#" class="pl-0 p-3"><span class="fa fa-facebook"></span></a>
              <a href="#" class="p-3"><span class="fa fa-twitter"></span></a>
              <a href="#" class="p-3"><span class="fa fa-instagram"></span></a>
              <a href="#" class="p-3"><span class="fa fa-vimeo"></span></a>
              <a href="#" class="p-3"><span class="fa fa-youtube-play"></span></a>
            </p>
          </div>
          <div class="col-md-4">
            <h3>Thông điệp</h3>
            <p>Niềm vui của khách hàng là niềm hạnh phúc của Sugar & Smile.</p>
          </div>
        </div>
      </div>
    </footer>
    <div id="loader" class="show fullscreen">
      <svg class="circular" width="48px" height="48px">
        <circle
          class="path-bg"
          cx="24"
          cy="24"
          r="22"
          fill="none"
          stroke-width="4"
          stroke="#eeeeee"
        />
        <circle
          class="path"
          cx="24"
          cy="24"
          r="22"
          fill="none"
          stroke-width="4"
          stroke-miterlimit="10"
          stroke="#f4b214"
        />
      </svg>
    </div>

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