package com.example.backend.login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Component;

import com.example.backend.database.DBConnection;

@Component
public class CheckPassword {
    @Autowired
    private DBConnection dbConnection;

    public String check(String username, String passwordInput) {
        String query = "SELECT password_hashed, email FROM Users WHERE name = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String passwordInDb = rs.getString("password_hashed");
                String email = rs.getString("email");
                if (BCrypt.checkpw(passwordInput, passwordInDb)){
                    System.out.println("Đăng nhập thành công!!" + LocalDateTime.now());
                    return email;
                }else{
                    System.out.println("sai tài khoản hoặc mật khẩu!!");
                }

            } else {
                System.out.println("⚠️ Không tìm thấy người dùng: " + username);
            }

        } catch (Exception e) {
            System.err.println("❌ Lỗi kiểm tra mật khẩu: " + e.getMessage());
        }
        return null;
    }
}
