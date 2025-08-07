package com.example.backend.login;

public class UserData {
    private String username;
    private String email;

    public UserData(String username, String email) {
        this.username = username;
        this.email = email;
    }

    public String getUsername() { return username; }
    public String getEmail() { return email; }
}
