
package controller;

import dao.BanhDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import model.Banh;
import model.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private BanhDAO banhDAO = new BanhDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = getCart(session);

        String action = request.getParameter("action");
        String idRaw = request.getParameter("id");
        int banhId = parseInt(idRaw, -1);
        int quantity = parseInt(request.getParameter("quantity"), 1);
        if (quantity < 1) quantity = 1;

        if ("remove".equals(action)) {
            if (banhId != -1) {
                cart.remove(banhId);
            }
        } else {
            if (banhId != -1) {
                CartItem item = cart.get(banhId);
                if (item == null) {
                    Banh banh = banhDAO.getBanhById(banhId);
                    if (banh != null) {
                        cart.put(banhId, new CartItem(banh, quantity));
                    }
                } else {
                    item.addQuantity(quantity);
                }
            }
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = getCart(session);
        request.setAttribute("cartItems", cart.values());
        request.setAttribute("totalCartPrice", cart.values().stream()
                .map(CartItem::getSubtotal)
                .reduce(0f, Float::sum));
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    private Map<Integer, CartItem> getCart(HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private int parseInt(String raw, int defaultVal) {
        try {
            return Integer.parseInt(raw);
        } catch (Exception e) {
            return defaultVal;
        }
    }
}


