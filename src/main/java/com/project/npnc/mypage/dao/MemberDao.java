package com.project.npnc.mypage.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.data.repository.query.Param;

import com.project.npnc.security.dto.Member;

public interface MemberDao {
    Member findById(SqlSession session, String memberId);
    int updateProfileImage(SqlSession session, Map<String, Object> paramMap);
    Member findByEmail(SqlSession session, String email);
    int updatePassword(SqlSession session, Map<String, Object> paramMap);
    int updateProfileImage(Map<String, Object> paramMap);
    String getProfileImageFileName(SqlSession session, String memberId);
    void updateAddress(@Param("memberId") String memberId, 
            @Param("fullAddress") String fullAddress);
}