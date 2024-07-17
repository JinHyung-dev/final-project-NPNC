package com.project.npnc.mypage.service;

import java.util.HashMap;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.project.npnc.mypage.dao.MemberDao;
import com.project.npnc.security.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MemberService {
    private final SqlSession sqlSession;
    private final MemberDao memberDao;

    @Override
    public Member getMemberById(String memberId) {
        return memberDao.findById(sqlSession, memberId);
    }

    @Override
    @Transactional
    public void updateProfileImage(String memberId, MultipartFile file) {
        String profileImagePath = saveFile(file);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("profileImagePath", profileImagePath);
        memberDao.updateProfileImage(sqlSession, paramMap);
    }

    private String saveFile(MultipartFile file) {
        try {
            // 파일 저장 로직 구현
            return "/path/to/saved/file";
        } catch (Exception e) {
            throw new RuntimeException("파일 저장 중 오류 발생", e);
        }
    }

    @Override
    public Member getMemberByEmail(String email) {
        return memberDao.findByEmail(sqlSession, email);
    }

    @Override
    @Transactional
    public void changePassword(String memberId, String newPassword) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("memberId", memberId);
        paramMap.put("newPassword", newPassword);
        memberDao.updatePassword(sqlSession, paramMap);
    }
}