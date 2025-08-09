package com.example.backend.tracking_question.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.backend.tracking_question.dao.AnswerDao;
import com.example.backend.tracking_question.dao.QuestionDao;
import com.example.backend.tracking_question.dto.QuestionResponse;
import com.example.backend.tracking_question.exception.NotFoundException;
import com.example.backend.tracking_question.model.Answer;
import com.example.backend.tracking_question.model.Question;

@Service
public class QuestionService {

    private final QuestionDao questionDao;
    private final AnswerDao answerDao;

    public QuestionService(QuestionDao questionDao, AnswerDao answerDao) {
        this.questionDao = questionDao;
        this.answerDao = answerDao;
    }

    public QuestionResponse getOne(Long id) {
        Question q = questionDao.findById(id)
                .orElseThrow(() -> new NotFoundException("Question not found: " + id));
        List<Answer> answers = answerDao.findByQuestionId(id);
        return new QuestionResponse(q.getId(), q.getQuestionText(), q.getQuestionType(), answers);
    }

}
