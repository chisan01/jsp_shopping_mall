package com.example.myhompage.order;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class OrderDAO {
    private Connection conn;

    public OrderDAO() {
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

    public String getDate() {
        String SQL = "SELECT NOW()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public void createOrder(String memberId) throws Exception {
        String SQL = "INSERT INTO order_detail (member_id, ordered_date) VALUES (?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, memberId);
        pstmt.setString(2, getDate());
        pstmt.executeUpdate();
    }

    public Long mostRecentOrder() throws Exception {
        String SQL = "SELECT id FROM order_detail ORDER BY ordered_date DESC";
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        ResultSet rs = pstmt.executeQuery();
        if(rs.next()) {
            return rs.getLong(1);
        }
        return -1L;
    }

    public void addOrderItem(Long orderId, Long productId, Integer amount) throws Exception {
        String SQL = "INSERT INTO order_item (order_id, product_id, amount) VALUES (?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setLong(1, orderId);
        pstmt.setLong(2, productId);
        pstmt.setInt(3, amount);
        pstmt.executeUpdate();
    }

    public ArrayList<Order> findAllByMemberId(String memberId) {
        String SQL = "SELECT * FROM order_detail WHERE member_id = ? ORDER BY ordered_date DESC";
        ArrayList<Order> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, memberId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getLong(1));
                order.setMemberId(rs.getString(2));
                order.setOrderedDate(rs.getString(3));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<OrderItem> findAllOrderItemByOrderId(Long orderId) {
        String SQL = "SELECT * FROM order_item WHERE order_id = ?";
        ArrayList<OrderItem> list = new ArrayList<>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setLong(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                OrderItem orderItem = new OrderItem();
                orderItem.setId(rs.getLong(1));
                orderItem.setOrderId(rs.getLong(2));
                orderItem.setProductId(rs.getLong(3));
                orderItem.setAmount(rs.getInt(4));
                list.add(orderItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
