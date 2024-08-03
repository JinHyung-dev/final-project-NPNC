--전체 생성된 테이블 조회
SELECT table_name 
FROM user_tables;
SELECT 
			d.ER_DOC_KEY,
			d.ER_DOC_SERIAL_KEY,
			d.ER_DOC_WRITER,
			d.ER_DOC_TITLE,
			d.ER_DOC_CREATE_DATE,
			d.ER_DOC_EMERGENCY_YN,
			d.ER_DOC_DELETE_YN,
			d.ER_DOC_STORAGE_KEY,
			d.ER_DOC_FILENAME, 
			d.ER_DOC_STATE, 
			d.ER_DOC_STATE_UPDATE_DATE,
			d.ER_DOC_LAST_UPDATER,
			d.ER_DOC_LAST_UPDATE_REASON,
			d.ER_DOC_COMPLETE_DATE,
			d.ER_DOC_FORM_KEY,
			f.ER_FILE_KEY,
			f.ER_FILE_ORI_NAME,
			f.ER_FILE_RENAME,
			f.ER_DOC_KEY,
			f.ER_DOC_SERIAL_KEY,
			f.ER_FILE_SIZE,
			f.ER_FILE_FORM,
			f.ER_FILE_UPLOAD_DATE,
			f.ER_FILE_ORDERBY,
			f.ER_FILE_UPLODAER,
			f.ER_FILE_UPDATE_DATE,
			f.ER_FILE_UPDATER,
			f.ER_FILE_UPDATE_REASON,
			ea.ER_APPROVER_KEY,
			ea.MEMBER_KEY,
			ea.ER_APPROVER_NAME,
			ea.ER_APPROVER_TEAM_KEY,
			d2.DEPARTMENT_NAME,
			ea.ER_APPROVER_JOB_KEY,
			j.JOB_NAME,
			ea.ER_APPROVAL_CATEGORY,
			ea.ER_APPROVAL_STATE,
			ea.ER_APPROVAL_OPINION,
			ea.ER_DOC_SERIAL_KEY,
			ea.ER_APPROVAL_DATE,
			ea.ER_APPROVAL_ORDERBY,
			er.ER_REFERER_KEY,
			er.ER_DOC_SERIAL_KEY,
			er.ER_REFERER_TEAM_KEY,
			d3.DEPARTMENT_NAME as ER_REFERER_TEAM_NAME,
			er.ER_REFERER_JOB_KEY,
			j2.JOB_NAME as ER_REFERER_JOB_NAME,
			er.ER_REFERER_NAME,
			er.MEMBER_KEY,
			s.ER_STORAGE_NAME,
			s.ER_STORAGE_TERM,
			sf.ER_FOLDER_NAME
		FROM   
			er_document d
        LEFT JOIN 
       		er_aprover ea ON d.ER_DOC_SERIAL_KEY = ea.ER_DOC_SERIAL_KEY
		LEFT JOIN
      		ER_REFERER er ON d.ER_DOC_SERIAL_KEY = er.ER_DOC_SERIAL_KEY 
		LEFT JOIN
			job j ON ea.ER_APPROVER_JOB_KEY = j.JOB_KEY
		LEFT JOIN
			job j2 ON er.ER_REFERER_JOB_KEY = j2.JOB_KEY 
		LEFT JOIN
			DEPARTMENT d2 ON ea.ER_APPROVER_TEAM_KEY = d2.DEPARTMENT_KEY 
		LEFT JOIN
			DEPARTMENT d3 ON er.ER_REFERER_TEAM_KEY = d3.DEPARTMENT_KEY 
        LEFT JOIN 
        	er_file f ON d.ER_DOC_SERIAL_KEY = f.ER_DOC_SERIAL_KEY 
        LEFT JOIN
      		ER_STORAGE s ON d.ER_DOC_STORAGE_KEY = s.ER_STORAGE_KEY
      	LEFT JOIN
      		ER_STORAGE_FOLDER sf ON s.ER_STORAGE_FOLDER_KEY = sf.ER_FOLDER_KEY;
		WHERE  
			d.ER_DOC_KEY = 364
		ORDER BY
			ea.ER_APPROVAL_ORDERBY asc,
			ER_FILE_ORDERBY;
--UPDATE ER_DOCUMENT SET ER_DOC_COMPLETE_DATE = NULL WHERE ER_DOC_STATE = '처리중';
SELECT 
				ER_DOC_SERIAL_KEY
			FROM   
				ER_DOCUMENT
			WHERE
				ER_DOC_KEY = 365;
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
SELECT * FROM ER_STORAGE_FOLDER esf;
SELECT * FROM DEPARTMENT d ;
SELECT * FROM ER_FORM ef ;
SELECT * FROM ER_FORM_FOLDER eff ;
SELECT * FROM DEPARTMENT d ;
SELECT * FROM job;
SELECT * FROM VACATION_APPLY va ;

--DROP TABLE ER_REFERENCE CASCADE CONSTRAINTS;

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
	ER_DOC_KEY	number	NOT NULL,
	ER_DOC_SERIAL_KEY	VARCHAR2(200)	unique	NOT NULL,
	ER_DOC_WRITER	NUMBER		NOT NULL,
	ER_DOC_TITLE	VARCHAR2(500)		NULL,
	ER_DOC_CREATE_DATE	DATE	DEFAULT SYSDATE	NULL,
	ER_DOC_EMERGENCY_YN	CHAR		NULL,
	ER_DOC_DELETE_YN	CHAR	DEFAULT 'N'	NOT NULL,
	ER_DOC_STOARGE_KEY	NUMBER		NULL,
	ER_DOC_FILENAME	VARCHAR2(1000)		NULL,
	ER_DOC_STATE VARCHAR2(50) DEFAULT '처리중' NOT NULL,
	ER_DOC_STATE_UPDATE_DATE	DATE		NULL,
	ER_DOC_LAST_UPDATER NUMBER NULL,
	ER_DOC_LAST_UPDATE_REASON VARCHAR2(1000) NULL,
	ER_DOC_COMPLETE_DATE DATE NULL,
	ER_DOC_FORM_KEY NUMBER NOT NULL
);
ALTER TABLE ER_STORAGE RENAME column ER_STOARGE_KEY TO ER_STORAGE_KEY;
ALTER TABLE ER_DOCUMENT RENAME column ER_DOC_STATE_UPDTE_DATE TO ER_DOC_STATE_UPDATE_DATE;
ALTER TABLE ER_DOCUMENT RENAME column ER_DOC_UNIQUE_NUM TO ER_DOC_SERIAL_KEY;
--ALTER TABLE ER_DOCUMENT ADD ER_DOC_STATE VARCHAR2(50) DEFAULT '처리중' NOT null;
--ALTER TABLE ER_DOCUMENT MODIFY er_doc_title varchar2(500);
ALTER TABLE ER_DOCUMENT ADD er_doc_form_key NUMBER;
UPDATE ER_DOCUMENT SET er_doc_form_key = 1;

ALTER TABLE ER_DOCUMENT DROP COLUMN ER_DOC_STOARGE;
ALTER TABLE ER_DOCUMENT DROP COLUMN er_file_key;

--pk
ALTER TABLE ER_DOCUMENT ADD CONSTRAINT PK_ER_DOCUMENT PRIMARY KEY (
	ER_DOC_KEY
);
--참조
ALTER TABLE ER_DOCUMENT ADD CONSTRAINT fk_er_doc_writer 
FOREIGN KEY (er_doc_writer) REFERENCES member(member_key);
ALTER TABLE ER_DOCUMENT ADD CONSTRAINT er_file_key 
FOREIGN KEY (er_file) REFERENCES member(er_file_key);

--문서 시퀀스(자바에서 문자열로 추가할 예정)
DROP sequence SEQ_ER_DOC_KEY;
DROP sequence SEQ_ER_DOC_UNIQUE_NUM;

CREATE SEQUENCE SEQ_ER_DOC_KEY
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
CACHE 20;
COMMIT;
SELECT SEQ_ER_DOC_KEY.nextval FROM DUAL;
CREATE SEQUENCE SEQ_ER_DOC_SERIAL_KEY_DRAFT
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
CACHE 20;
SELECT SEQ_ER_DOC_SERIAL_KEY_.nextval FROM DUAL;
CREATE SEQUENCE SEQ_ER_DOC_SERIAL_KEY
START WITH 1
INCREMENT BY 1
NOMINVALUE
NOMAXVALUE
NOCYCLE
CACHE 20;
COMMIT;
ROLLBACK;
INSERT INTO ER_STORAGE values(SEQ_ER_STORAGE_KEY.nextval, 53, '휴가 신청서', 5, 8, 2);
--INSERT INTO ER_document values(TO_CHAR(SYSDATE, 'YYMMDD') || '-' || 'D2F3' || '-' || to_char(SEQ_ER_FORM.nextval), 3, '문서제목', default, null, 'N', default, null, '보관함명', '문서제목.html');