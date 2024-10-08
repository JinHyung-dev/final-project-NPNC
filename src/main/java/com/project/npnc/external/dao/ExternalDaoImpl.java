package com.project.npnc.external.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.npnc.external.dto.ExternalDto;

@Repository
public class ExternalDaoImpl implements ExternalDao {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<ExternalDto> getAllContacts(int memberkey) {
        return sqlSession.selectList("com.project.npnc.external.dao.ExternalDao.getAllContacts",memberkey);
    }

    @Override
    public ExternalDto getContactById(int id) {
        return sqlSession.selectOne("com.project.npnc.external.dao.ExternalDao.getContactById", id);
    }

    @Override
    public void addContact(ExternalDto externalDto) {
        sqlSession.insert("com.project.npnc.external.dao.ExternalDao.addContact", externalDto);
    }

    @Override
    public void updateContact(ExternalDto externalDto) {
        sqlSession.update("com.project.npnc.external.dao.ExternalDao.updateContact", externalDto);
    }

    @Override
    public void deleteContact(int id) {
        sqlSession.delete("com.project.npnc.external.dao.ExternalDao.deleteContact", id);
    }

    @Override
    public void toggleFavorite(int id) {
        sqlSession.update("com.project.npnc.external.dao.ExternalDao.toggleFavorite", id); // 수정된 부분
    }
    
    @Override
    public List<ExternalDto> searchContacts(String query) {
        return sqlSession.selectList("com.project.npnc.external.dao.ExternalDao.searchContacts", query);
    }
}
