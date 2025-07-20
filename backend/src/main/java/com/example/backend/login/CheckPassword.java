package com.example.backend.login;

import com.example.backend.database.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@Component
public class CheckPassword {
    @Autowired
    private DBConnection dbConnection;

    public boolean check(String username, String passwordInput) {
        String query = "SELECT Password FROM Users WHERE UserName = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String passwordInDb = rs.getString("Password");
                return passwordInput.equals(passwordInDb); // So sánh trực tiếp
            } else {
                System.out.println("⚠️ Không tìm thấy người dùng: " + username);
                return false;
            }

        } catch (Exception e) {
            System.err.println("❌ Lỗi kiểm tra mật khẩu: " + e.getMessage());
            return false;
        }
    }
}
