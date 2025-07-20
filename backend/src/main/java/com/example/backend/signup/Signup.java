package com.example.backend.signup;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.backend.database.DBConnection;

@Service
public class Signup {

    @Autowired
    private DBConnection dbConnection;

    @Autowired
    private HashPassword hashPassword;

    public boolean register(SignupRequest request) {
        String insertQuery = "INSERT INTO Users (UserName, Email, Password, PasswordHashed, PhoneNumber) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(insertQuery)) {

            String hashed = hashPassword.hash(request.getPassword());

            stmt.setString(1, request.getUsername());
            stmt.setString(2, request.getEmail());
            stmt.setString(3, request.getPassword()); // Lưu cả raw nếu bạn muốn debug
            stmt.setString(4, hashed); // Lưu hash để dùng sau
            stmt.setString(5, request.getPhoneNumber());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;

        } catch (Exception e) {
            System.err.println("❌ Đăng ký thất bại: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
