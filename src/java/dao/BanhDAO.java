/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import model.Banh;

public class BanhDAO extends DAO {

    public BanhDAO() {
        super();
    }

    public ArrayList<Banh> getAllBanh() {
        String sql = """
            SELECT b.*, bi.imgURL
            FROM banhs b
            LEFT JOIN (
                SELECT banhId, MIN(imgURL) AS imgURL
                FROM banhImages
                GROUP BY banhId
            ) bi ON b.banhId = bi.banhId
            """;

        ArrayList<Banh> list = new ArrayList<>();

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ArrayList<String> imgs = new ArrayList<>();
                imgs.add(rs.getString("imgURL")); 

                Banh b = new Banh(
                        rs.getInt("banhId"),
                        rs.getString("banhName"),
                        rs.getFloat("price"),
                        rs.getFloat("sale"),
                        imgs,
                        rs.getString("description")
                );
                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Banh getBanhById(int id) {
        String sql = "SELECT * FROM banhs WHERE banhId = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                   ArrayList<String> imgs= new ArrayList();
                    return new Banh(
                            rs.getInt("banhId"),
                            rs.getString("banhName"),
                            rs.getFloat("price"),
                            rs.getFloat("sale"),
                            imgs,
                            rs.getString("description")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
