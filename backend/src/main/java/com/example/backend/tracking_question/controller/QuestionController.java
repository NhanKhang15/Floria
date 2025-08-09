package com.example.backend.tracking_question.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.backend.tracking_question.dto.QuestionResponse;
import com.example.backend.tracking_question.service.QuestionService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class QuestionController {

    private final QuestionService service;

    public QuestionController(QuestionService service) {
        this.service = service;
    }

    @GetMapping("/questions/{id}")
    public QuestionResponse getOne(@PathVariable Long id) {
        return service.getOne(id);
    }
}