package com.example.backend.tracking_question.dto;

import java.util.List;

import com.example.backend.tracking_question.model.Answer;

public class QuestionResponse {
    private Long id;
    private String questionText;
    private String category;
    private List<Answer> answers;

    public QuestionResponse(Long id, String questionText, String category, List<Answer> answers) {
        this.id = id;
        this.questionText = questionText;
        this.category = category;
        this.answers = answers;
    }

    public Long getId() {
        return id;
    }

    public String getQuestionText() {
        return questionText;
    }

    public String getCategory() {
        return category;
    }

    public List<Answer> getAnswers() {
        return answers;
    }
    
    
}