package dao;

import model.Bill;
import java.sql.*;
import model.Booking;

public class BillDAO extends DAO {

    public BillDAO() {
        super();
    }

    // Insert bill, trả về billId vừa tạo
    public int insertBill(Bill bill) {
        String sql = "INSERT INTO bill (bookId, totalPrice) VALUES (?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, bill.getBooking().getId());
            ps.setFloat(2, bill.getTotalPrice());
            int cnt = ps.executeUpdate();
            if (cnt > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) return rs.getInt(1);
            }
        } catch (Exception ex) {
        }
        return -1;
    }

    // Lấy bill theo bookId
    public Bill getBillByBookingId(int bookId) {
        String sql = "SELECT * FROM bill WHERE bookId=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Booking booking = new BookingDAO().getBookingById(rs.getInt("bookId"));
                float totalPrice = rs.getFloat("totalPrice");
                return new Bill(rs.getInt("billId"), booking, totalPrice);
            }
        } catch (Exception ex) {
        }
        return null;
    }
}
