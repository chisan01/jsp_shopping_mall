package com.example.myhompage.product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProductDAO {
    private Connection conn;
    private ResultSet rs;

    public ProductDAO() {
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

    public ArrayList<Product> findAllByCategory(String category) {
        String SQL;
        PreparedStatement pstmt;
        ArrayList<Product> list = new ArrayList<>();
        try {
            if (category == null) {
                SQL = "SELECT * FROM product ORDER BY id DESC";
                pstmt = conn.prepareStatement(SQL);
            } else {
                SQL = "SELECT * FROM product WHERE category = ? ORDER BY id DESC";
                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, category);
            }
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getLong(1));
                product.setName(rs.getString(2));
                product.setPrice(rs.getInt(3));
                product.setImageSrc(rs.getString(4));
                product.setCategory(rs.getString(5));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product findById(Long id) {
        String SQL = "SELECT * FROM product WHERE id = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setLong(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getLong(1));
                product.setName(rs.getString(2));
                product.setPrice(rs.getInt(3));
                product.setImageSrc(rs.getString(4));
                product.setCategory(rs.getString(5));
                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Product> findAllByNameKeyword(String keyword) {
        String SQL;
        PreparedStatement pstmt;
        ArrayList<Product> list = new ArrayList<>();
        try {
            SQL = "SELECT *\n" +
                    "FROM product\n" +
                    "WHERE product.name LIKE ?\n" +
                    "order BY name DESC";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + keyword + "%");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getLong(1));
                product.setName(rs.getString(2));
                product.setPrice(rs.getInt(3));
                product.setImageSrc(rs.getString(4));
                product.setCategory(rs.getString(5));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

