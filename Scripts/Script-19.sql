SELECT * from ER_APROVER  ORDER BY ER_DOC_SERIAL_KEY desc;

SELECT * FROM ER_FILE ORDER BY ER_FILE_UPLOAD_DATE desc;

SELECT * FROM ER_DOCUMENT ed ORDER BY ER_DOC_CREATE_DATE DESC;
SELECT * FROM ER_DOCUMENT ed WHERE ER_DOC_STATE = '처리완료' ORDER BY ER_DOC_CREATE_DATE DESC;