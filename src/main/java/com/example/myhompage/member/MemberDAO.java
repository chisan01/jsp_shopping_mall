package com.example.myhompage.member;

import com.example.myhompage.exception.NotExistMemberException;
import com.example.myhompage.exception.WrongPasswordException;

import java.sql.*;

public class MemberDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public MemberDAO() {
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

    public void login(String memberId, String memberPassword) throws Exception {
        String SQL = "SELECT password FROM member WHERE id = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, memberId);
            System.out.println("memberId = " + memberId + ", memberPassword = " + memberPassword);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(memberPassword)) {
                    return;
                } else {
                    throw new WrongPasswordException();
                }
            }
            throw new NotExistMemberException();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void join(Member member) throws Exception {
        String SQL = "INSERT INTO member VALUES (?,?,?)";
        pstmt = conn.prepareStatement(SQL);
        pstmt.setString(1, member.getId());
        pstmt.setString(2, member.getPassword());
        pstmt.setString(3, member.getEmail());
        pstmt.executeUpdate();
    }
}
