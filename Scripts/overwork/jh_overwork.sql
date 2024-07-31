--전체 생성된 테이블 조회
SELECT table_name 
FROM user_tables;

SELECT * FROM attendance;
SELECT * FROM member;
SELECT * FROM OVERTIMEWORK o ;
SELECT * FROM MEMBER_VACATION ;
SELECT * FROM VACATION_APPLY ;

UPDATE VACATION_APPLY SET VACATION_KEY = 3;

SELECT * 
        FROM attendance 
        WHERE MEMBER_KEY = 1
        AND ATTENDANCE_STATE != '결근'
       AND ATTENDANCE_STATE != '휴가';
          AND EXTRACT(YEAR FROM attendance_date) = TOCHAR(sysdate, 'yyyy')
          AND EXTRACT(MONTH FROM date) = TOCHAR(sysdate, 'MM');
   
SELECT * FROM ER_DOCUMENT ed ORDER BY ER_DOC_CREATE_DATE desc;
SELECT * FROM ER_DOCUMENT ed WHERE ER_DOC_STATE = '처리완료' ORDER BY ER_DOC_CREATE_DATE DESC;
SELECT * from er_ap_line_storage ;
SELECT * from er_ap_line;
SELECT * from ER_APROVER  ORDER BY ER_DOC_SERIAL_KEY desc;
SELECT * from ER_REFERER er ;
SELECT * FROM MEMBER;
SELECT * FROM job;
SELECT * FROM ER_AL_STORAGE;
SELECT * FROM ER_APROVER ea ;
SELECT * FROM ER_FILE ORDER BY ER_FILE_UPLOAD_DATE desc;
SELECT * FROM ER_STORAGE es ;
SELECT * FROM DEPARTMENT d ;
SELECT * FROM ER_FORM ef ;
SELECT * FROM ER_FORM_FOLDER eff ;
SELECT * FROM DEPARTMENT d ;


--제약조건 확인
SELECT *
FROM user_constraints
WHERE table_name = 'ER_DOCUMENT';
--제약조건 삭제
ALTER TABLE ER_DOCUMENT drop CONSTRAINT fk_er_document_writer;
--참조 추가
ALTER TABLE ER_DOCUMENT ADD CONSTRAINT fk_er_doc_writer FOREIGN KEY (er_doc_writer) REFERENCES member(member_key);

DROP TABLE OVERTIMEWORK CASCADE CONSTRAINTS;

CREATE TABLE OVERTIMEWORK (
	OVERTIME_KEY	NUMBER		NOT NULL,
	ER_DOC_SERIAL_KEY	VARCHAR2(500)		NOT NULL,
	OVERTIME_APPLY_DATE	DATE	DEFAULT sysdate	NOT NULL,
	OVERTIME_DATE	DATE		NOT NULL,
	OVERTIME_REASON	VARCHAR2(1000)		NOT NULL,
	OVERTIME_STATUS	VARCHAR2(50)	DEFAULT '대기'	NOT NULL,
	OVERTIME_START_TIME	TIMESTAMP		NOT NULL,
	OVERTIME_END_TIME	TIMESTAMP		NOT NULL,
	OVERTIME_MEMBER_KEY	NUMBER		NOT NULL,
	OVERTIME_CATEGORY varchar2(50) NULL,
	OVERTIME_CONFIRM_DATE DATE null
);
ALTER TABLE OVERTIMEWORK ADD OVERTIME_CONFIRM_DATE DATE null;
ALTER TABLE OVERTIMEWORK ADD overtime_category varchar2(50) null;

ALTER TABLE OVERTIMEWORK ADD CONSTRAINT PK_OVERTIMEWORK PRIMARY KEY (
	OVERTIME_KEY
);


ALTER TABLE ER_DOCUMENT RENAME column ER_DOC_STOARGE_KEY TO ER_DOC_STORAGE_KEY;
ALTER TABLE ER_DOCUMENT RENAME column ER_DOC_STATE_UPDTE_DATE TO ER_DOC_STATE_UPDATE_DATE;
ALTER TABLE ER_DOCUMENT RENAME column ER_DOC_UNIQUE_NUM TO ER_DOC_SERIAL_KEY;
--ALTER TABLE ER_DOCUMENT ADD ER_DOC_STATE VARCHAR2(50) DEFAULT '처리중' NOT null;
ALTER TABLE MEMBER_VACATION MODIFY MEMBER_VAC_YEAR varchar2(50) DEFAULT TO_CHAR(sysdate, 'YYYY');
UPDATE ER_DOCUMENT SET er_doc_storage_key = 1;

ALTER TABLE ER_DOCUMENT DROP COLUMN ER_DOC_STOARGE;
ALTER TABLE ER_DOCUMENT DROP COLUMN er_file_key;

--참조
ALTER TABLE ER_DOCUMENT ADD CONSTRAINT fk_er_doc_writer 
FOREIGN KEY (er_doc_writer) REFERENCES member(member_key);
ALTER TABLE ER_DOCUMENT ADD CONSTRAINT er_file_key 
FOREIGN KEY (er_file) REFERENCES member(er_file_key);

--시퀀스
DROP sequence SEQ_ER_DOC_UNIQUE_NUM;

SELECT SEQ_MEMBER_VAC_KEY.nextval FROM DUAL;
CREATE SEQUENCE SEQ_OVERTIME_KEY
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
CACHE 20;
COMMIT;
ROLLBACK;
INSERT INTO VACATION v values(SEQ_VACATION_KEY.nextval, '오전반차', 'Y');
INSERT INTO VACATION v values(SEQ_VACATION_KEY.nextval, '오후반차', 'Y');