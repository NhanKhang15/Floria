package com.example.backend.tracking_question.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.backend.tracking_question.dto.SubmitAnswerRequest;
import com.example.backend.tracking_question.service.UserAnswerService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class UserAnswerController {

    private final UserAnswerService service;

    public UserAnswerController(UserAnswerService service) {
        this.service = service;
    }

    /** PUT /api/user-answers  — gọi khi bấm Next */
    @PutMapping("/user-answers")
    public ResponseEntity<Map<String, Object>> next(@Valid @RequestBody SubmitAnswerRequest req) {
        return ResponseEntity.ok(service.nextSubmit(req));
    }
}