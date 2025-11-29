/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import model.Customer;

public class CustomerDAO extends DAO {

    public CustomerDAO() {
        super();
    }
    // Kiểm tra đăng nhập
    public Customer login(String email, String password) {
        String sql = "SELECT * FROM customers WHERE email = ? AND password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("customerId"),
                        rs.getString("customerName"),
                        rs.getString("email"),
                        rs.getString("tel"),
                        rs.getString("address"),
                        rs.getString("password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra xem email đã tồn tại chưa
    public Customer checkAccountExist(String email) {
        String sql = "SELECT * FROM customers WHERE email = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                 return new Customer(
                        rs.getInt("customerId"),
                        rs.getString("customerName"),
                        rs.getString("email"),
                        rs.getString("tel"),
                        rs.getString("address"),
                        rs.getString("password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    // Thêm khách hàng mới, trả về id của khách hàng vừa thêm
    public int insertCustomer(Customer cus) {
        try {
            String sql = "INSERT INTO customers (customerName, email, tel, address, password) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, cus.getName());
            ps.setString(2, cus.getEmail());
            ps.setString(3, cus.getTel());
            ps.setString(4, cus.getAddress());
            ps.setString(5, cus.getPassword());

            int cnt = ps.executeUpdate();
            if (cnt > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return -1; 
    }
    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM customers WHERE customerId = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customer cus = new Customer(
                        rs.getString("customerName"),
                        rs.getString("email"),
                        rs.getString("tel"),
                        rs.getString("address"),
                        rs.getString("password")
                );
                cus.setId(rs.getInt("customerId"));
                return cus;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }
}
