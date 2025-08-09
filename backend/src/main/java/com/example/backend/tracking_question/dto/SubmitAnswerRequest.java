package com.example.backend.tracking_question.dto;

import jakarta.validation.constraints.NotNull;

public class SubmitAnswerRequest {
    @NotNull
    private Long userId;

    @NotNull
    private Long questionId;

    @NotNull
    private Long answerId;

    // có thể null
    private Long cycleId;

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public Long getQuestionId() { return questionId; }
    public void setQuestionId(Long questionId) { this.questionId = questionId; }

    public Long getAnswerId() { return answerId; }
    public void setAnswerId(Long answerId) { this.answerId = answerId; }

    public Long getCycleId() { return cycleId; }
    public void setCycleId(Long cycleId) { this.cycleId = cycleId; }
}