
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;

@WebServlet(name = "SignupServlet", urlPatterns = {"/signup"})
public class SignupServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // lay du lieu form dangky.html
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("re-password");

        // kiem tra mat khau
        if (!password.equals(rePassword)) {
            request.setAttribute("mess", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("dangky.html").forward(request, response);
        } else {
            CustomerDAO dao = new CustomerDAO();
            Customer a = dao.checkAccountExist(email);
            
            if (a == null) {
                Customer newCus = new Customer(fullname, email, phone, "", password, "user");
                dao.insertCustomer(newCus);               
                response.sendRedirect("index.jsp"); 
            } else {
                request.setAttribute("mess", "Email đã tồn tại!");
                request.getRequestDispatcher("dangky.html").forward(request, response);
            }
        }
    }

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
