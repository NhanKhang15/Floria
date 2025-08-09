package com.example.backend.tracking_question.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.backend.database.DBConnection;
import com.example.backend.tracking_question.model.Answer;

@Repository
public class AnswerDao {

    private final DBConnection db;

    public AnswerDao(DBConnection db) {
        this.db = db;
    }

    public List<Answer> findByQuestionId(Long questionId) {
        String sql = """
            SELECT answer_id, question_id, answer_text
            FROM Answers
            WHERE question_id = ?
        """;
        List<Answer> list = new ArrayList<>();
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, questionId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Answer a = new Answer();
                    a.setId(rs.getLong("answer_id"));
                    a.setQuestionId(rs.getLong("question_id"));
                    a.setAnswerText(rs.getString("answer_text"));

                    list.add(a);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}