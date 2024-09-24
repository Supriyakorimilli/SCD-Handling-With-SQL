Name: Supriya Korimilli

Question :
Given two tables, type1_student and student_stage, with student_id as the primary key, we will perform the following operations using a MERGE statement:

•	If the same record exists in both type1_student and student_stage without any changes, keep the record the same.
•	If the same record exists in both type1_student and student_stage but with changes, update the changed attributes in type1_student along with the current timestamp.
•	If a new record exists in student_stage that does not exist in type1_student, add the new record to type1_student with the current timestamp.

Table creation of type1_student

CREATE TABLE type1_student (
    STUDENTID INT PRIMARY KEY,
    FIRSTNAME NVARCHAR(50),
    LASTNAME NVARCHAR(50),
    BIRTHDATE DATE,
    ADDRESS NVARCHAR(100),
    INSERTTIMESTAMP DATETIME,
    UPDATETIMESTAMP DATETIME
);

Table creation of STUDENT_STAGE

CREATE TABLE STUDENT_STAGE (
    STUDENTID INT PRIMARY KEY,
    FIRSTNAME NVARCHAR(50),
    LASTNAME NVARCHAR(50),
    BIRTHDATE DATE,
    ADDRESS NVARCHAR(100),
    INSERTTIMESTAMP DATETIME,
    UPDATETIMESTAMP DATETIME
);

Insert data into type1_student table

INSERT INTO type1_student (STUDENTID, FIRSTNAME, LASTNAME, BIRTHDATE, ADDRESS, INSERTTIMESTAMP, UPDATETIMESTAMP)
VALUES 
(1, 'John', 'Carter', '1990-08-16', '108 Lucile Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Tristan', 'Tubon', '2000-01-01', '110 Lucile Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(3, 'Peter', 'Crain', '2002-12-31', '121 Lucile Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(4, 'Chris', 'Gayle', '1984-07-01', '108 Evangeline Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(5, 'Joseph', 'Garten', '1980-05-15', '110 Evangeline Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(6, 'Chris', 'Braun', '1975-01-01', '111 Picard Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


Insert data into STUDENT_STAGE table

INSERT INTO STUDENT_STAGE (STUDENTID, FIRSTNAME, LASTNAME, BIRTHDATE, ADDRESS, INSERTTIMESTAMP, UPDATETIMESTAMP)
VALUES 
(1, 'John', 'Carter', '1990-08-16', '108 Lucile Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(2, 'Tristan', 'Tubon', '2000-01-01', '110 Lucile Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
(7, 'Virat', 'Kohli', '1999-11-30', '121 Lucile Dr', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

Merge:
MERGE INTO TYPE1_STUDENT AS t1
USING STUDENT_STAGE AS t2
ON t1.STUDENTID = t2.STUDENTID
WHEN MATCHED AND (
    t1.FIRSTNAME <> t2.FIRSTNAME OR
    t1.LASTNAME <> t2.LASTNAME OR
    t1.BIRTHDATE <> t2.BIRTHDATE OR
    t1.ADDRESS <> t2.ADDRESS
)
THEN 
UPDATE SET
    t1.FIRSTNAME = t2.FIRSTNAME,
    t1.LASTNAME = t2.LASTNAME,
    t1.BIRTHDATE = t2.BIRTHDATE,
    t1.ADDRESS = t2.ADDRESS,
    t1.UPDATETIMESTAMP = CURRENT_TIMESTAMP
WHEN NOT MATCHED BY TARGET THEN
INSERT (STUDENTID, FIRSTNAME, LASTNAME, BIRTHDATE, ADDRESS, INSERTTIMESTAMP, UPDATETIMESTAMP)
VALUES (t2.STUDENTID, t2.FIRSTNAME, t2.LASTNAME, t2.BIRTHDATE, t2.ADDRESS, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
