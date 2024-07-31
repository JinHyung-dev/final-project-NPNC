-- 공지사항 테이블 생성
CREATE TABLE NOTICE (
    NOTICE_KEY NUMBER PRIMARY KEY,  -- 자동 증가 ID
    NOTICE_TITLE VARCHAR2(255) NOT NULL,  -- 공지사항 제목
    NOTICE_DETAIL CLOB NOT NULL,  -- 공지사항 내용
    MEMBER_KEY NUMBER NOT NULL,  -- 작성자 ID
    NOTICE_ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,  -- 작성일
    NOTICE_UPDATE_DATE DATE DEFAULT SYSDATE,  -- 수정일
    NOTICE_DELETE CHAR(1) DEFAULT 'N' CHECK (NOTICE_DELETE IN ('Y', 'N'))  -- 삭제 여부
);

-- 시퀀스 생성
CREATE SEQUENCE NOTICE_SEQ
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
   -- 트리거 생성
CREATE OR REPLACE TRIGGER NOTICE_BI
BEFORE INSERT ON NOTICE
FOR EACH ROW
BEGIN
    IF :NEW.NOTICE_KEY IS NULL THEN
        SELECT NOTICE_SEQ.NEXTVAL
        INTO :NEW.NOTICE_KEY
        FROM DUAL;
    END IF;
END;
/


-- 공지사항 작성자 정보를 저장하는 테이블 (예시)
CREATE TABLE MEMBER (
    MEMBER_KEY NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, -- 자동 증가 ID
    MEMBER_NAME VARCHAR2(100) NOT NULL,                           -- 작성자 이름
    MEMBER_EMAIL VARCHAR2(255)                                   -- 작성자 이메일
);
