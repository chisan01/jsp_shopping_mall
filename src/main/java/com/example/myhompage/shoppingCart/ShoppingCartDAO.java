package com.example.myhompage.shoppingCart;

import com.example.myhompage.exception.NotExistMemberException;
import com.example.myhompage.exception.WrongPasswordException;
import com.example.myhompage.member.Member;
import com.example.myhompage.product.Product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ShoppingCartDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public ShoppingCartDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3307/web_programming_hw?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
            String dbUser = "web_programming_user";
            String dbPassword = "1234";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addProduct(String memberId, Long productId) throws Exception {
        String SQL = "INSERT INTO shopping_cart (member_id, product_id) VALUES (?,?)";
        pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, memberId);
        pstmt.setLong(2,productId);
        pstmt.executeUpdate();
    }

    public ArrayList<ShoppingCart> findAllByMemberId(String memberId) {
        String SQL = "SELECT *, COUNT(product_id) AS amount\n" +
                "FROM shopping_cart\n" +
                "WHERE member_id = ?\n" +
                "GROUP BY product_id";
        ArrayList<ShoppingCart> list = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, memberId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                ShoppingCart shoppingCart = new ShoppingCart();
                shoppingCart.setId(rs.getLong(1));
                shoppingCart.setMemberId(rs.getString(2));
                shoppingCart.setProductId(rs.getLong(3));
                shoppingCart.setAmount(rs.getInt(4));
                list.add(shoppingCart);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void delProduct(Long productId) throws Exception {
        String SQL = "DELETE FROM shopping_cart WHERE product_id = ?";
        pstmt = conn.prepareStatement(SQL);
        pstmt.setLong(1,productId);
        pstmt.executeUpdate();
    }

    public int countProductAmount(String memberId, Long productId) {
        String SQL = "SELECT COUNT(*) AS amount\n" +
                "FROM shopping_cart\n" +
                "WHERE member_id = ? AND product_id = ?\n";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, memberId);
            pstmt.setLong(2, productId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    // public Long countAllProduct
}
