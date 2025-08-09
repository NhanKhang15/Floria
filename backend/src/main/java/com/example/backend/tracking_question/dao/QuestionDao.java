package com.example.backend.tracking_question.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import com.example.backend.database.DBConnection;
import com.example.backend.tracking_question.model.Question;

@Repository
public class QuestionDao {

    private final DBConnection db;

    public QuestionDao(DBConnection db) {
        this.db = db;
    }

    public Optional<Question> findById(Long id) {
        String sql = "SELECT question_id, question_text, question_type FROM Questions WHERE question_id = ?";
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Question q = new Question();
                    q.setId(rs.getLong("question_id"));
                    q.setQuestionText(rs.getString("question_text"));
                    q.setQuestionType(rs.getString("question_type"));
                    return Optional.of(q);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Optional.empty();
    }
}