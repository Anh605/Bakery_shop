
package controller;

import dao.BanhDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Banh;
import org.json.simple.JSONObject;

public class getDetailAjax extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        JSONObject jo = new JSONObject();

        try (PrintWriter out = response.getWriter()) {

            String id = request.getParameter("id");

            // Kiểm tra đầu vào
            if (id == null || id.trim().isEmpty()) {
                jo.put("error", "invalid_request");
                out.print(jo);
                return;
            }

            int banhId;
            try {
                banhId = Integer.parseInt(id);
            } catch (NumberFormatException e) {
                jo.put("error", "invalid_id");
                out.print(jo);
                return;
            }

            // Lấy dữ liệu từ DB
            BanhDAO banhDAO = new BanhDAO();
            Banh banh = banhDAO.getBanhById(banhId);

            if (banh == null) {
                jo.put("error", "not_found");
            } else {
                jo.put("id", banh.getId());
                jo.put("name", banh.getName());               
                jo.put("description", banh.getDescription());
                jo.put("price", banh.getRawPrice());
                jo.put("sale", banh.getSale());
                jo.put("image", banh.getMainImage());
            }

            out.print(jo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Return Banh detail for AJAX request";
    }
}
