package com.example.backend.login;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin(origins = "*")
public class Login {
    @Autowired
    private CheckPassword checkPassword;

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody LoginRequest request) {
        boolean success = checkPassword.check(request.getUsername(), request.getPassword());

        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        response.put("message", success ? "Login thành công!" : "Sai tài khoản hoặc mật khẩu!");

        return response;
    }    
}
