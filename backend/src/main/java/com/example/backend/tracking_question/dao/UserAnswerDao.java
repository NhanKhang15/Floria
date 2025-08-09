package com.example.backend.tracking_question.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import org.springframework.stereotype.Repository;

import com.example.backend.database.DBConnection;

@Repository
public class UserAnswerDao {

    private final DBConnection db;

    public UserAnswerDao(DBConnection db) {
        this.db = db;
    }

    /** Check answer thuộc đúng question (tránh user gửi cặp sai) */
    public boolean answerBelongsToQuestion(long answerId, long questionId) {
        String sql = "SELECT 1 FROM dbo.Answers WHERE answer_id = ? AND question_id = ?";
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, answerId);
            ps.setLong(2, questionId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Nút Next: upsert theo (user_id, question_id, cycle_id NULL-safe).
     * Chiến lược: UPDATE trước, nếu 0 dòng thì INSERT. Bọc transaction để safe.
     * Trả về "updated" hoặc "created".
     */
    public String upsertFromNext(long userId, long questionId, long answerId, Long cycleId) {
        try (Connection con = db.getConnection()) {
            con.setAutoCommit(false);
            try {
                // 1) UPDATE trước
                String update = """
                    UPDATE dbo.UserAnswers
                       SET answer_id = ?, created_at = GETDATE()
                     WHERE user_id = ? AND question_id = ?
                       AND ((cycle_id IS NULL AND ? IS NULL) OR (cycle_id = ?))
                    """;
                try (PreparedStatement ps = con.prepareStatement(update)) {
                    ps.setLong(1, answerId);
                    ps.setLong(2, userId);
                    ps.setLong(3, questionId);
                    if (cycleId == null) {
                        ps.setNull(4, Types.INTEGER);
                        ps.setNull(5, Types.INTEGER);
                    } else {
                        // vế IS NULL vẫn truyền null để so sánh
                        ps.setNull(4, Types.INTEGER);
                        ps.setLong(5, cycleId);
                    }
                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        con.commit();
                        return "updated";
                    }
                }

                // 2) INSERT nếu chưa có
                String insert = """
                    INSERT INTO dbo.UserAnswers(user_id, question_id, answer_id, cycle_id)
                    VALUES (?, ?, ?, ?)
                    """;
                try (PreparedStatement ps = con.prepareStatement(insert)) {
                    ps.setLong(1, userId);
                    ps.setLong(2, questionId);
                    ps.setLong(3, answerId);
                    if (cycleId == null) ps.setNull(4, Types.INTEGER);
                    else ps.setLong(4, cycleId);
                    ps.executeUpdate();
                }

                con.commit();
                return "created";
            } catch (SQLException ex) {
                con.rollback();
                throw ex;
            } finally {
                con.setAutoCommit(true);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}