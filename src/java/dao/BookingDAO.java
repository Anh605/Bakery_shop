package dao;

import java.sql.*;
import java.util.ArrayList;
import model.Banh;
import model.Booking;
import model.Customer;

public class BookingDAO extends DAO {

    public BookingDAO() {
        super();
    }

    // Thêm booking
        public int insertBooking(int customerId, int banhId, int quantity, String note, String status) {
        String sql = "INSERT INTO booking (customerId, banhId, quantity, note, orderTime, status) VALUES (?, ?, ?, ?, NOW(), ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setInt(2, banhId);
            ps.setInt(3, quantity);
            ps.setString(4, note);
            ps.setString(5, status);  // Lưu địa chỉ riêng cho booking
            int cnt = ps.executeUpdate();
            if (cnt > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return -1;
    }
    
   // Lấy booking theo bookId
    public Booking getBookingById(int bookId) {
        String sql = "SELECT * FROM booking WHERE bookId=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customer customer = new CustomerDAO().getCustomerById(rs.getInt("customerId"));
                Banh banh = new BanhDAO().getBanhById(rs.getInt("banhId"));
                int quantity = rs.getInt("quantity");
                String note = rs.getString("note");
                String status = rs.getString("status");
                Timestamp orderTime = rs.getTimestamp("orderTime");
                return new Booking(bookId, customer, banh, quantity, note, orderTime, status);
                
            }
        } catch (Exception ex) {
        }
        return null;
    }

    // Lấy tất cả booking
    public ArrayList<Booking> getAllBooking() {
        ArrayList<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM booking ORDER BY orderTime";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int bookId = rs.getInt("bookId");
                Customer customer = new CustomerDAO().getCustomerById(rs.getInt("customerId"));
                Banh banh = new BanhDAO().getBanhById(rs.getInt("banhId"));
                int quantity = rs.getInt("quantity");
                String note = rs.getString("note");
                Timestamp orderTime = rs.getTimestamp("orderTime");
                String status = rs.getString("status");
                list.add(new Booking(bookId, customer, banh, quantity, note, orderTime, status));
            }
        } catch (Exception ex) {
        }
        return list;
    }
    
    public void updateOrderStatus(String email, Timestamp orderTime, String status) {
        String sql = "UPDATE booking b " +
                     "JOIN customers c ON b.customerId = c.customerId " +
                     "SET b.status = ? " +
                     "WHERE c.email = ? AND b.orderTime = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, email);
            ps.setTimestamp(3, orderTime);
            ps.executeUpdate();
        } catch (Exception ex) {
        }
    }

}
