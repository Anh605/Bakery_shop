<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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

    <!-- Theme Style -->
    <link rel="stylesheet" href="css/style.css" />
    <style>
        .user-profile-box {
            position: relative;
            display: flex;           /* Quan trọng: Giúp căn giữa theo chiều dọc */
            align-items: center;     /* Quan trọng: Căn giữa thẳng hàng với menu */
            height: 100%;
            padding-left: 15px;      /* Khoảng cách trái */
            cursor: pointer;
        }

        .logout-dropdown {
            display: none;           /* Mặc định ẩn */
            position: absolute;
            top: 100%;
            left: 0;                 /* Hoặc right: 0 tùy vị trí */
            background-color: white;
            padding: 10px 20px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            border-radius: 4px;
            z-index: 9999;
            min-width: 150px;
        }

        .logout-dropdown a {
            color: #dc3545 !important; /* Màu đỏ cho nút đăng xuất */
            text-decoration: none;
            display: block;
            font-weight: bold;
        }

        .logout-dropdown a:hover {
            text-decoration: underline;
        }

        /* Khi di chuột vào vùng tên thì hiện menu con */
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
                <a class="nav-link" href="banhlist">Bánh</a>
              </li>

              <li class="nav-item">
                <a class="nav-link active" href="about.jsp">Giới thiệu</a>
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
    <!-- END header -->

    <section
      class="site-hero site-hero-innerpage overlay"
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
              <h1>Một chút về Sugar & Smile</h1>
              <p>Sugar & Smile</p>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- END section -->

    <section class="site-section">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-4">
            <div class="heading-wrap element-animate">
              <h2 class="heading">Lịch sử</h2>
              <p class="">
                Sugar & Smile ra đời từ niềm đam mê làm bánh thủ công của chúng
                tôi. Bắt đầu chỉ từ một gian bếp nhỏ và những mẻ bánh dành tặng
                bạn bè, tiệm dần lớn lên nhờ sự tin yêu của khách hàng.
              </p>

              <p>
                Chúng tôi luôn tin rằng một chiếc bánh ngon không chỉ nằm ở
                hương vị mà còn trong sự chăm chút từng chi tiết.
              </p>

              <p>
                Sugar & Smile luôn nỗ lực mang đến những chiếc bánh tươi ngon,
                an toàn và chứa đựng sự ấm áp dành cho mọi dịp đặc biệt của bạn.
              </p>
            </div>
          </div>
          <div class="col-md-1"></div>
          <div class="col-md-7">
            <img
              src="https://media.istockphoto.com/id/586209206/vi/anh/ng%C6%B0%E1%BB%9Di-ph%E1%BB%A5-n%E1%BB%AF-ph%E1%BB%A5c-v%E1%BB%A5-kh%C3%A1ch-h%C3%A0ng-t%E1%BA%A1i-m%E1%BB%99t-ti%E1%BB%87m-b%C3%A1nh.jpg?s=170667a&w=0&k=20&c=c5-CRFoOfsZje8z8wL2ab4MZ6O9WVOIHPe_tMt-uCSc="
              alt="Image placeholder"
              class="img-md-fluid"
            />
          </div>
        </div>
      </div>
    </section>
    <!-- END section -->

    <section class="site-section bg-light">
      <div class="container">
        <div class="row mb-5">
          <div class="col-md-12 heading-wrap text-center">
            <h2 class="heading">Nhân viên</h2>
          </div>
        </div>
        <div class="row">
          <div class="col-md-4">
            <div class="post-entry">
              <img
                src="https://amcollege.edu.vn/wp-content/uploads/2022/06/nghiep-vu-bep-viet-amcollege.jpg"
                alt="Image placeholder"
                class="img-fluid"
              />
              <div class="body-text">
                <div class="category">Bếp Trưởng</div>
                <h3 class="mb-3"><a href="#">Anh Minh</a></h3>
                <p class="mb-4">
                  Với hơn 8 năm kinh nghiệm làm bánh Pháp, anh luôn chú trọng
                  vào chất lượng và hương vị tinh tế, biến mỗi chiếc bánh thành
                  một tác phẩm nghệ thuật nhỏ.
                </p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="post-entry">
              <img
                src="https://madamehuong.vn/wp-content/uploads/2019/06/madamehuong-723x800.jpg"
                alt="Image placeholder"
                class="img-fluid"
              />
              <div class="body-text">
                <div class="category">Bếp phó</div>
                <h3 class="mb-3"><a href="#">Thu Hương</a></h3>
                <p class="mb-4">
                  Chị Hương là người đứng sau những ổ bánh mì thơm nức, vỏ giòn
                  ruột mềm mà khách hàng yêu thích. Tỉ mỉ, kỷ luật và tận tâm,
                  chị luôn đảm bảo quy trình làm bánh đạt chuẩn và giữ vững sự
                  đồng nhất trong chất lượng mỗi ngày.
                </p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="post-entry">
              <img
                src="https://images.baoangiang.com.vn/image/fckeditor/upload/2023/20231104/images/z4837701228355_332fb590acb9eed46888f83766ec3a10.jpg"
                alt="Image placeholder"
                class="img-fluid"
              />
              <div class="body-text">
                <div class="category">Nhân viên tiêu biểu</div>
                <h3 class="mb-3"><a href="#">Thùy Linh</a></h3>
                <p class="mb-4">
                  Linh là gương mặt thân thiện của tiệm, luôn mang lại cảm giác
                  gần gũi cho mọi khách ghé thăm. Với phong cách phục vụ nhẹ
                  nhàng và nhiệt tình, Linh giúp khách hàng chọn được chiếc bánh
                  phù hợp nhất cho từng dịp đặc biệt.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- END section -->

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
    <!-- END section -->

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
    <!-- END footer -->

    <!-- loader -->
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
