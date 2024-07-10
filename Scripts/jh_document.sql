--전체 생성된 테이블 조회
SELECT table_name 
FROM user_tables;

SELECT * FROM ER_DOCUMENT ed ;
SELECT * from ER_APPROVAL_LINE ;
SELECT * from ER_APROVER ;
SELECT * FROM MEMBER;
SELECT * FROM ER_AL_STORAGE;
SELECT * FROM ER_APPROVAL_LINE eal ;
SELECT * FROM ER_APROVER ea ;
SELECT * FROM ER_FILE ;
SELECT * FROM ER_STORAGE es ;
SELECT * FROM ER_DOCUMENT ed ;
SELECT * FROM DEPARTMENT d ;
select * from er_document
	LEFT JOIN ER_APROVER ea using(ER_DOC_KEY)
 where er_doc_writer = 3 and er_doc_approval_date is null
		 order by er_doc_emergency_yn DESC, ER_approval_orderby;
select * from er_document
		 where er_doc_writer = ${no} and er_doc_approval_date is null
		 order by er_doc_emergency_yn DESC;

DROP TABLE ER_DOCUMENT CASCADE CONSTRAINTS;

--제약조건 확인
SELECT *
FROM user_constraints
WHERE table_name = 'ER_DOCUMENT';
--제약조건 삭제
ALTER TABLE ER_DOCUMENT drop CONSTRAINT fk_er_document_writer;
--참조 추가
ALTER TABLE ER_DOCUMENT ADD CONSTRAINT fk_er_doc_writer FOREIGN KEY (er_doc_writer) REFERENCES member(member_key);
DROP TABLE ER_DOCUMENT;

CREATE TABLE ER_DOCUMENT (
	ER_DOC_KEY	VARCHAR2(200)		NOT NULL,
	ER_DOC_WRITER	NUMBER		NOT NULL,
	ER_DOC_TITLE	VARCHAR2(500)		NULL,
	--ER_DOC_CONTENT	VARCHAR2(1000)		NULL,
	ER_DOC_CREATE_DATE	DATE	DEFAULT SYSDATE	NULL,
	ER_DOC_APPROVAL_DATE	DATE		NULL,
	ER_DOC_EMERGENCY_YN	CHAR		NULL,
	ER_DOC_DELETE_YN	CHAR	DEFAULT 'N'	NOT NULL,
	ER_DOC_UPDATE_DATE	DATE	DEFAULT SYSDATE	NULL,
	ER_DOC_STOARGE	VARCHAR2(50)		NULL,
	ER_DOC_FILENAME	VARCHAR2(1000)		NULL
);

ALTER TABLE ER_DOCUMENT DROP COLUMN ER_DOC_CONTENT;
ALTER TABLE ER_DOCUMENT MODIFY er_doc_title varchar2(500);

ALTER TABLE ER_DOCUMENT ADD CONSTRAINT PK_ER_DOCUMENT PRIMARY KEY (
	ER_DOC_KEY
);

ALTER TABLE ER_DOCUMENT ADD CONSTRAINT fk_er_doc_writer 
FOREIGN KEY (er_doc_writer) REFERENCES member(member_key);


SELECT TO_CHAR(SYSDATE, 'YYMMDD') FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYMMDD') || '-' FROM dual;
--문서 시퀀스(자바에서 문자열로 추가할 예정)
CREATE SEQUENCE SEQ_ER_DOC_KEY
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
CACHE 20;
INSERT INTO ER_document values(TO_CHAR(SYSDATE, 'YYMMDD') || '-' || 'D1-F3' || to_char(SEQ_ER_FORM.nextval), 1, '문서제목', default, null, 'N', DEFAULT, null, '경영팀', '기안문.html');
INSERT INTO ER_document values(TO_CHAR(SYSDATE, 'YYMMDD') || '-' || 'D2F3' || '-' || to_char(SEQ_ER_FORM.nextval), 3, '문서제목', default, null, 'N', default, null, '보관함명', '문서제목.html');