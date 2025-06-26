-- 현실적인 전체 테이블 더미 데이터 (5~7개씩)
# USE saladdb;
SET FOREIGN_KEY_CHECKS = 0;

-- DEPARTMENT
-- 미배정 부서 (id=1)
INSERT INTO department (name, is_deleted, sup_dept_id)
VALUES ('미배정', FALSE, NULL);

-- 상위 부서 (id=2~10)\
INSERT INTO department (name, is_deleted, sup_dept_id)
VALUES ('인사부', FALSE, NULL),
       ('마케팅부', FALSE, NULL),
       ('재무/회계부', FALSE, NULL),
       ('생산부', FALSE, NULL),
       ('연구개발부', FALSE, NULL),
       ('IT/정보시스템부', FALSE, NULL),
       ('전략기획부', FALSE, NULL),
       ('영업부', FALSE, NULL),
       ('법무부', FALSE, NULL);

-- 하위 부서 (sup_dept_id = 상위 부서 id 반영)
INSERT INTO department (name, is_deleted, sup_dept_id)
VALUES
-- 인사부(2)
('인재채용팀', FALSE, 2),
('인사운영팀', FALSE, 2),
('노무관리팀', FALSE, 2),

-- 마케팅부(3)
('브랜드팀', FALSE, 3),
('콘텐츠팀', FALSE, 3),
('광고팀', FALSE, 3),
('프로모션팀', FALSE, 3),

-- 재무/회계부(4)
('재무팀', FALSE, 4),
('회계팀', FALSE, 4),
('자금팀', FALSE, 4),

-- 생산부(5)
('생산1팀', FALSE, 5),
('생산2팀', FALSE, 5),
('생산기술팀', FALSE, 5),
('품질관리팀', FALSE, 5),

-- 연구개발부(6)
('연구1팀', FALSE, 6),
('연구2팀', FALSE, 6),
('제품개발팀', FALSE, 6),

-- IT/정보시스템부(7)
('IT운영팀', FALSE, 7),
('인프라팀', FALSE, 7),
('개발팀', FALSE, 7),
('보안팀', FALSE, 7),

-- 전략기획부(8)
('전략팀', FALSE, 8),
('기획팀', FALSE, 8),
('사업개발팀', FALSE, 8),

-- 영업부(9)
('영업1팀', FALSE, 9),
('영업2팀', FALSE, 9),
('영업3팀', FALSE, 9),
('영업4팀', FALSE, 9),
('영업5팀', FALSE, 9),

-- 법무부(10)
('법무지원팀', FALSE, 10),
('계약검토팀', FALSE, 10);

-- FILE_UPLOAD
INSERT INTO FILE_UPLOAD (origin_file, rename_file, path, thumbnail_path, created_at, type)
VALUES ('profile.png', 'e637698b-fb33-4e96-9dd9-b5602572c50d_profile.png',
        'https://saladerp-bucket.s3.ap-northeast-2.amazonaws.com/employee/e637698b-fb33-4e96-9dd9-b5602572c50d_profile.png',
        null, '2025-06-22 23:37', 'PROFILE');

-- EMPLOYEE
-- 관리자 더미
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('ADMIN', '$2a$10$eu/cmPGCdI.cJKQHSi12..fq50TgXsJ3UjKg/nB4SC6rvAyK0woWW', '관리자', '01000000000',
        'admin@saladerp.com', '관리자', '1000-01-01', NULL, TRUE, FALSE, '관리자', 1, 1);

-- 사원, 팀장 더미
-- 영업 1팀
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202501001', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '강수지', '01038679572',
        'teamflover_s@naver.com', '사원', '2025-01-01', NULL, FALSE, FALSE, '서울강남', 35, 1),
       ('202501002', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '고성연', '01019990502',
        'teamflover_j@naver.com', '주임', '2025-01-01', NULL, FALSE, FALSE, '서울강남', 35, 1),
       ('202501003', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '고윤석', '01095009870',
        'teamflover_d@naver.com', '대리', '2025-01-01', NULL, FALSE, FALSE, '서울강남', 35, 1),
       ('202501004', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김성민', '01046792202',
        'teamflover_k@naver.com', '과장', '2025-01-01', NULL, FALSE, FALSE, '서울강남', 35, 1),
       ('202501005', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이청민', '01020000101',
        'teamflover_t@naver.com', '팀장', '2025-01-01', NULL, FALSE, FALSE, '서울강남', 35, 1);

-- 영업 2팀
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503993', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최은경', '01000000001',
        '202503993@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울강북', 36, 1),
       ('201811926', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이주은', '01000000002',
        '201811926@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울강북', 36, 1),
       ('201207641', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤수수', '01000000003',
        '201207641@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울강북', 36, 1),
       ('200604639', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최민진', '01000000004',
        '200604639@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울강북', 36, 1),
       ('200001446', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤민하', '01000000005',
        '200001446@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울강북', 36, 1);

-- 영업 3팀
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503665', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김슬민', '01000000006',
        '202503665@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '인천부평', 37, 1),
       ('201811852', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이은민', '01000000007',
        '201811852@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '인천부평', 37, 1),
       ('201207899', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정석하', '01000000008',
        '201207899@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '인천부평', 37, 1),
       ('200604962', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한석슬', '01000000009',
        '200604962@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '인천부평', 37, 1),
       ('200001225', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임석경', '01000000010',
        '200001225@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '인천부평', 37, 1);

-- 영업 4팀
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503444', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정하슬', '01000000011',
        '202503444@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '경기성남', 38, 1),
       ('201811566', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이진하', '01000000012',
        '201811566@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '경기성남', 38, 1),
       ('201207130', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '장현우', '01000000013',
        '201207130@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '경기성남', 38, 1),
       ('200604252', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최주호', '01000000014',
        '200604252@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '경기성남', 38, 1),
       ('200001223', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박현주', '01000000015',
        '200001223@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '경기성남', 38, 1);

-- 영업 5팀
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503358', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김은수', '01000000016',
        '202503358@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '부산해운대', 39, 1),
       ('201811460', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한호은', '01000000017',
        '201811460@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '부산해운대', 39, 1),
       ('201207841', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한진경', '01000000018',
        '201207841@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '부산해운대', 39, 1),
       ('200604792', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한슬수', '01000000019',
        '200604792@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '부산해운대', 39, 1),
       ('200001749', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임하진', '01000000020',
        '200001749@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '부산해운대', 39, 1);

-- 인사부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503563', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정현호', '01000000021',
        '202503563@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 11, 1),
       ('201811274', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '장경석', '01000000022',
        '201811274@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 11, 1),
       ('201207741', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박석진', '01000000023',
        '201207741@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 11, 1),
       ('200604370', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤연연', '01000000024',
        '200604370@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 11, 1),
       ('200001565', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조경석', '01000000025',
        '200001565@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 11, 1),
       ('202503352', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이연은', '01000000026',
        '202503352@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 12, 1),
       ('201811428', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조석연', '01000000027',
        '201811428@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 12, 1),
       ('201207208', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '장은슬', '01000000028',
        '201207208@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 12, 1),
       ('200604186', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최주석', '01000000029',
        '200604186@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 12, 1),
       ('200001928', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최민호', '01000000030',
        '200001928@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 12, 1),
       ('202503919', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김수호', '01000000031',
        '202503919@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 13, 1),
       ('201811783', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최진호', '01000000032',
        '201811783@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 13, 1),
       ('201207227', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임석수', '01000000033',
        '201207227@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 13, 1),
       ('200604119', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이석호', '01000000034',
        '200604119@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 13, 1),
       ('200001296', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박아석', '01000000035',
        '200001296@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 13, 1);

-- 마케팅부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503227', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이진연', '01000000036',
        '202503227@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 14, 1),
       ('201811826', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박수연', '01000000037',
        '201811826@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 14, 1),
       ('201207525', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박연호', '01000000038',
        '201207525@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 14, 1),
       ('200604218', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정아은', '01000000039',
        '200604218@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 14, 1),
       ('200001822', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김석주', '01000000040',
        '200001822@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 14, 1),
       ('202503452', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최연민', '01000000041',
        '202503452@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 15, 1),
       ('201811877', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이은아', '01000000042',
        '201811877@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 15, 1),
       ('201207859', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최연진', '01000000043',
        '201207859@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 15, 1),
       ('200604481', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김진슬', '01000000044',
        '200604481@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 15, 1),
       ('200001528', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한진슬', '01000000045',
        '200001528@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 15, 1),
       ('202503854', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한민연', '01000000046',
        '202503854@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 16, 1),
       ('201811215', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김호민', '01000000047',
        '201811215@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 16, 1),
       ('201207260', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한하민', '01000000048',
        '201207260@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 16, 1),
       ('200604527', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이민우', '01000000049',
        '200604527@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 16, 1),
       ('200001403', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박석수', '01000000050',
        '200001403@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 16, 1),
       ('202503460', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조하석', '01000000051',
        '202503460@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 17, 1),
       ('201811542', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤연석', '01000000052',
        '201811542@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 17, 1),
       ('201207984', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박아하', '01000000053',
        '201207984@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 17, 1),
       ('200604909', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤경민', '01000000054',
        '200604909@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 17, 1),
       ('200001581', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최진연', '01000000055',
        '200001581@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 17, 1);

-- 재무/회계부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503924', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이연호', '01000000056',
        '202503924@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 18, 1),
       ('201811108', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤슬진', '01000000057',
        '201811108@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 18, 1),
       ('201207121', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조민하', '01000000058',
        '201207121@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 18, 1),
       ('200604279', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정은경', '01000000059',
        '200604279@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 18, 1),
       ('200001386', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박은수', '01000000060',
        '200001386@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 18, 1),
       ('202503928', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '장우진', '01000000061',
        '202503928@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 19, 1),
       ('201811285', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조아수', '01000000062',
        '201811285@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 19, 1),
       ('201207410', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임우진', '01000000063',
        '201207410@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 19, 1),
       ('200604534', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임주석', '01000000064',
        '200604534@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 19, 1),
       ('200001876', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한하현', '01000000065',
        '200001876@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 19, 1),
       ('202503149', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김은석', '01000000066',
        '202503149@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울본사', 20, 1),
       ('201811564', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조석호', '01000000067',
        '201811564@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울본사', 20, 1),
       ('201207225', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박아은', '01000000068',
        '201207225@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울본사', 20, 1),
       ('200604991', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조아하', '01000000069',
        '200604991@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울본사', 20, 1),
       ('200001585', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한현연', '01000000070',
        '200001585@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울본사', 20, 1);

-- 생산부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503309', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임아수', '01000000071',
        '202503309@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울공장', 21, 1),
       ('201811556', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김현우', '01000000072',
        '201811556@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울공장', 21, 1),
       ('201207131', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한진주', '01000000073',
        '201207131@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울공장', 21, 1),
       ('200604408', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이진은', '01000000074',
        '200604408@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울공장', 21, 1),
       ('200001168', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최경우', '01000000075',
        '200001168@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울공장', 21, 1),
       ('202503720', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최진우', '01000000076',
        '202503720@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울공장', 22, 1),
       ('201811122', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임수진', '01000000077',
        '201811122@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울공장', 22, 1),
       ('201207188', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤수석', '01000000078',
        '201207188@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울공장', 22, 1),
       ('200604663', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정수하', '01000000079',
        '200604663@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울공장', 22, 1),
       ('200001865', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤아하', '01000000080',
        '200001865@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울공장', 22, 1),
       ('202503391', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이진주', '01000000081',
        '202503391@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울공장', 23, 1),
       ('201811114', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조현진', '01000000082',
        '201811114@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울공장', 23, 1),
       ('201207648', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한아수', '01000000083',
        '201207648@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울공장', 23, 1),
       ('200604365', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이슬민', '01000000084',
        '200604365@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울공장', 23, 1),
       ('200001946', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임연호', '01000000085',
        '200001946@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울공장', 23, 1),
       ('202503276', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조수호', '01000000086',
        '202503276@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울공장', 24, 1),
       ('201811117', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤슬연', '01000000087',
        '201811117@saladerp.com', '주임', '2018-11-15', NULL, FALSE, FALSE, '서울공장', 24, 1),
       ('201207379', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한주석', '01000000088',
        '201207379@saladerp.com', '대리', '2012-07-31', NULL, FALSE, FALSE, '서울공장', 24, 1),
       ('200604492', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이연진', '01000000089',
        '200604492@saladerp.com', '과장', '2006-04-16', NULL, FALSE, FALSE, '서울공장', 24, 1),
       ('200001745', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정진슬', '01000000090',
        '200001745@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울공장', 24, 1);

-- 연구개발부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503636', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤호호', '01000000091',
        '202503636@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울연구소', 25, 1),
       ('201411563', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최민주', '01000000092',
        '201411563@saladerp.com', '주임', '2014-11-06', NULL, FALSE, FALSE, '서울연구소', 25, 1),
       ('201311530', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '강수호', '01000000093',
        '201311530@saladerp.com', '대리', '2013-11-07', NULL, FALSE, FALSE, '서울연구소', 25, 1),
       ('201804340', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김호하', '01000000094',
        '201804340@saladerp.com', '과장', '2018-04-25', NULL, FALSE, FALSE, '서울연구소', 25, 1),
       ('200001199', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박수석', '01000000095',
        '200001199@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울연구소', 25, 1),
       ('202503987', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박슬주', '01000000096',
        '202503987@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울연구소', 26, 1),
       ('200305793', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최하진', '01000000097',
        '200305793@saladerp.com', '주임', '2003-05-16', NULL, FALSE, FALSE, '서울연구소', 26, 1),
       ('202303246', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조석슬', '01000000098',
        '202303246@saladerp.com', '대리', '2023-03-13', NULL, FALSE, FALSE, '서울연구소', 26, 1),
       ('201903532', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임수수', '01000000099',
        '201903532@saladerp.com', '과장', '2019-03-13', NULL, FALSE, FALSE, '서울연구소', 26, 1),
       ('200001254', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조석민', '01000000100',
        '200001254@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울연구소', 26, 1),
       ('202503571', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박연수', '01000000101',
        '202503571@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울연구소', 27, 1),
       ('200303937', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한주주', '01000000102',
        '200303937@saladerp.com', '주임', '2003-03-31', NULL, FALSE, FALSE, '서울연구소', 27, 1),
       ('201801108', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정연슬', '01000000103',
        '201801108@saladerp.com', '대리', '2018-01-30', NULL, FALSE, FALSE, '서울연구소', 27, 1),
       ('201611358', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이주연', '01000000104',
        '201611358@saladerp.com', '과장', '2016-11-28', NULL, FALSE, FALSE, '서울연구소', 27, 1),
       ('200001164', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조하슬', '01000000105',
        '200001164@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울연구소', 27, 1);

-- IT/정보시스템부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503540', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박수석', '01000000106',
        '202503540@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '판교IT센터', 28, 1),
       ('201109809', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤진수', '01000000107',
        '201109809@saladerp.com', '주임', '2011-09-01', NULL, FALSE, FALSE, '판교IT센터', 28, 1),
       ('200412486', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤진우', '01000000108',
        '200412486@saladerp.com', '대리', '2004-12-27', NULL, FALSE, FALSE, '판교IT센터', 28, 1),
       ('202106934', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박연진', '01000000109',
        '202106934@saladerp.com', '과장', '2021-06-22', NULL, FALSE, FALSE, '판교IT센터', 28, 1),
       ('200001395', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김주우', '01000000110',
        '200001395@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '판교IT센터', 28, 1),
       ('202503659', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최슬석', '01000000111',
        '202503659@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '판교IT센터', 29, 1),
       ('201501402', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한우석', '01000000112',
        '201501402@saladerp.com', '주임', '2015-01-17', NULL, FALSE, FALSE, '판교IT센터', 29, 1),
       ('200404963', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조슬우', '01000000113',
        '200404963@saladerp.com', '대리', '2004-04-14', NULL, FALSE, FALSE, '판교IT센터', 29, 1),
       ('200504814', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한연주', '01000000114',
        '200504814@saladerp.com', '과장', '2005-04-11', NULL, FALSE, FALSE, '판교IT센터', 29, 1),
       ('200001478', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조주민', '01000000115',
        '200001478@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '판교IT센터', 29, 1),
       ('202503576', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤호연', '01000000116',
        '202503576@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '판교IT센터', 30, 1),
       ('201002530', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조하민', '01000000117',
        '201002530@saladerp.com', '주임', '2010-02-12', NULL, FALSE, FALSE, '판교IT센터', 30, 1),
       ('202203996', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김진슬', '01000000118',
        '202203996@saladerp.com', '대리', '2022-03-20', NULL, FALSE, FALSE, '판교IT센터', 30, 1),
       ('201903383', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박호호', '01000000119',
        '201903383@saladerp.com', '과장', '2019-03-17', NULL, FALSE, FALSE, '판교IT센터', 30, 1),
       ('200001145', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤수하', '01000000120',
        '200001145@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '판교IT센터', 30, 1),
       ('202503458', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임호우', '01000000121',
        '202503458@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '판교IT센터', 31, 1),
       ('202302550', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조주연', '01000000122',
        '202302550@saladerp.com', '주임', '2023-02-13', NULL, FALSE, FALSE, '판교IT센터', 31, 1),
       ('201304601', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '강수연', '01000000123',
        '201304601@saladerp.com', '대리', '2013-04-26', NULL, FALSE, FALSE, '판교IT센터', 31, 1),
       ('201209148', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한석주', '01000000124',
        '201209148@saladerp.com', '과장', '2012-09-30', NULL, FALSE, FALSE, '판교IT센터', 31, 1),
       ('200001560', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이수수', '01000000125',
        '200001560@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '판교IT센터', 31, 1);

-- 전략기획부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503392', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤호주', '01000000126',
        '202503392@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '본사전략부', 32, 1),
       ('201702585', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최수호', '01000000127',
        '201702585@saladerp.com', '주임', '2017-02-03', NULL, FALSE, FALSE, '본사전략부', 32, 1),
       ('201611786', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한연우', '01000000128',
        '201611786@saladerp.com', '대리', '2016-11-28', NULL, FALSE, FALSE, '본사전략부', 32, 1),
       ('201503151', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최민하', '01000000129',
        '201503151@saladerp.com', '과장', '2015-03-08', NULL, FALSE, FALSE, '본사전략부', 32, 1),
       ('200001705', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한슬호', '01000000130',
        '200001705@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '본사전략부', 32, 1),
       ('202503844', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '강주주', '01000000131',
        '202503844@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '본사전략부', 33, 1),
       ('201701733', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한슬주', '01000000132',
        '201701733@saladerp.com', '주임', '2017-01-05', NULL, FALSE, FALSE, '본사전략부', 33, 1),
       ('200408388', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최우수', '01000000133',
        '200408388@saladerp.com', '대리', '2004-08-14', NULL, FALSE, FALSE, '본사전략부', 33, 1),
       ('200706391', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조민주', '01000000134',
        '200706391@saladerp.com', '과장', '2007-06-06', NULL, FALSE, FALSE, '본사전략부', 33, 1),
       ('200001743', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김우하', '01000000135',
        '200001743@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '본사전략부', 33, 1),
       ('202503298', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤연석', '01000000136',
        '202503298@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '본사전략부', 34, 1),
       ('201704544', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임슬우', '01000000137',
        '201704544@saladerp.com', '주임', '2017-04-21', NULL, FALSE, FALSE, '본사전략부', 34, 1),
       ('201305897', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '이민민', '01000000138',
        '201305897@saladerp.com', '대리', '2013-05-08', NULL, FALSE, FALSE, '본사전략부', 34, 1),
       ('200107983', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한주하', '01000000139',
        '200107983@saladerp.com', '과장', '2001-07-16', NULL, FALSE, FALSE, '본사전략부', 34, 1),
       ('200001134', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최석석', '01000000140',
        '200001134@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '본사전략부', 34, 1);

-- 법무부
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503658', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '김슬호', '01000000141',
        '202503658@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울법무실', 40, 1),
       ('202406207', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조진석', '01000000142',
        '202406207@saladerp.com', '주임', '2024-06-11', NULL, FALSE, FALSE, '서울법무실', 40, 1),
       ('200106375', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '조석주', '01000000143',
        '200106375@saladerp.com', '대리', '2001-06-01', NULL, FALSE, FALSE, '서울법무실', 40, 1),
       ('202111355', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박수석', '01000000144',
        '202111355@saladerp.com', '과장', '2021-11-08', NULL, FALSE, FALSE, '서울법무실', 40, 1),
       ('200001475', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '최주주', '01000000145',
        '200001475@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울법무실', 40, 1),
       ('202503143', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '한민석', '01000000146',
        '202503143@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '서울법무실', 41, 1),
       ('202301251', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '정슬우', '01000000147',
        '202301251@saladerp.com', '주임', '2023-01-08', NULL, FALSE, FALSE, '서울법무실', 41, 1),
       ('201912371', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤호민', '01000000148',
        '201912371@saladerp.com', '대리', '2019-12-27', NULL, FALSE, FALSE, '서울법무실', 41, 1),
       ('201405695', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '임슬수', '01000000149',
        '201405695@saladerp.com', '과장', '2014-05-28', NULL, FALSE, FALSE, '서울법무실', 41, 1),
       ('200001216', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '강연호', '01000000150',
        '200001216@saladerp.com', '팀장', '2000-01-01', NULL, FALSE, FALSE, '서울법무실', 41, 1);

-- 미배정
INSERT INTO employee (code, password, name, phone, email, level, hire_date, resign_date, is_admin, is_deleted,
                      work_place, department_id, profile)
VALUES ('202503986', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '윤슬우', '01000000151',
        '202503986@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '미배정', 1, 1),
       ('202503758', '$2a$10$a20vES08g9Y66UpTd5FQDeqC10eBvivO1jmTFGy/txQzFJ9Vywbyq', '박진주', '01000000152',
        '202503758@saladerp.com', '사원', '2025-03-01', NULL, FALSE, FALSE, '미배정', 1, 1);

-- CUSTOMER
INSERT INTO CUSTOMER (name, birthdate, address, phone, email, register_at, is_deleted, type, etc)
VALUES
('유지민', '2000-04-11', '서울 서초구 반포동', '01070103862', 'yoojimin@aespa.com', CURRENT_DATE, false, '고객', ''),
('김민정', '2001-01-01', '서울 송파구 가락동', '01014392523', 'kimminjeong@aespa.com', CURRENT_DATE, false, '고객', ''),
('우에치 아에리', '2000-03-30', '서울 마포구 연남동', '01016792445', 'aeriuechi@aespa.com', CURRENT_DATE, false, '고객', ''),
('닝이줘', '2002-10-23', '서울 강남구 청담동', '01089416646', 'ningning@aespa.com', CURRENT_DATE, false, '고객', ''),
('루카', '2002-03-20', '서울 마포구 연남동', '01057537647', 'ruka@babymonster.com', CURRENT_DATE, false, '리드', ''),
('파리타', '2005-08-26', '서울 용산구 이태원동', '01012916626', 'pharita@babymonster.com', CURRENT_DATE, false, '고객', ''),
('아사', '2006-04-17', '서울 마포구 연남동', '01012789004', 'asa@babymonster.com', CURRENT_DATE, false, '고객', ''),
('라미', '2007-10-17', '서울 강남구 청담동', '01057170889', 'rami@babymonster.com', CURRENT_DATE, false, '고객', ''),
('로라', '2008-08-05', '서울 서초구 반포동', '01017746992', 'roora@babymonster.com', CURRENT_DATE, false, '리드', ''),
('치키타', '2009-02-17', '서울 송파구 가락동', '01028947007', 'chiquita@babymonster.com', CURRENT_DATE, false, '고객', ''),
('이하람', '2007-10-17', '서울 강남구 청담동', '01068060531', 'leeharam@babymonster.com', CURRENT_DATE, false, '고객', ''),
('이새롬', '1997-01-07', '서울 송파구 가락동', '01056899604', 'leeserom@fromis9.com', CURRENT_DATE, false, '리드', ''),
('송하영', '1997-09-29', '서울 강남구 청담동', '01064862518', 'songhayoung@fromis9.com', CURRENT_DATE, false, '리드', ''),
('장규리', '1997-12-27', '서울 강남구 청담동', '01033124017', 'janggyuri@fromis9.com', CURRENT_DATE, false, '고객', ''),
('박지원', '1998-03-20', '서울 강남구 청담동', '01070897790', 'parkjiwon@fromis9.com', CURRENT_DATE, false, '고객', ''),
('노지선', '1998-11-23', '서울 서초구 반포동', '01060868522', 'nohjisun@fromis9.com', CURRENT_DATE, false, '고객', ''),
('이서연', '2000-01-22', '서울 용산구 이태원동', '01043744750', 'leeseoyeon@fromis9.com', CURRENT_DATE, false, '고객', ''),
('이채영', '2000-05-14', '서울 용산구 이태원동', '01030814265', 'leechayeong@fromis9.com', CURRENT_DATE, false, '고객', ''),
('백지헌', '2003-04-17', '서울 송파구 가락동', '01057535108', 'baekjiheon@fromis9.com', CURRENT_DATE, false, '고객', ''),
('최현준', '2000-06-22', '서울 용산구 이태원동', '01070706346', 'doran@t1.com', CURRENT_DATE, false, '리드', ''),
('문현준', '2002-12-24', '서울 서초구 반포동', '01044230133', 'oner@t1.com', CURRENT_DATE, false, '고객', ''),
('이상혁', '1996-05-07', '서울 용산구 이태원동', '01020501594', 'faker@t1.com', CURRENT_DATE, false, '고객', ''),
('이민형', '2002-02-27', '서울 강남구 청담동', '01096717603', 'gumayusi@t1.com', CURRENT_DATE, false, '고객', ''),
('류민석', '2003-10-14', '서울 마포구 연남동', '01053902933', 'keria@t1.com', CURRENT_DATE, false, '고객', ''),
('전시우', '2004-05-07', '서울 송파구 가락동', '01048312217', 'siwoo@dpluskia.com', CURRENT_DATE, false, '고객', ''),
('최용혁', '2005-03-10', '서울 강남구 청담동', '01034858614', 'lucid@dpluskia.com', CURRENT_DATE, false, '리드', ''),
('허수', '2000-07-22', '서울 서초구 반포동', '01063014903', 'showmaker@dpluskia.com', CURRENT_DATE, false, '리드', ''),
('김하람', '2000-09-02', '서울 용산구 이태원동', '01075331122', 'aiming@dpluskia.com', CURRENT_DATE, false, '리드', ''),
('조건희', '1997-04-01', '서울 마포구 연남동', '01072959182', 'beryl@dpluskia.com', CURRENT_DATE, false, '리드', ''),
('나희주', '1998-04-25', '서울 강남구 청담동', '01012345678', 'inonix@danawa.com', CURRENT_DATE, false, '리드', ''),
('박정영', '1994-04-22', '서울 서초구 반포동', '01023456789', 'loki@danawa.com', CURRENT_DATE, false, '리드', ''),
('조기열', '1997-11-11', '서울 송파구 가락동', '01034567890', 'seoul@danawa.com', CURRENT_DATE, false, '고객', ''),
('우제현', '1996-01-15', '서울 용산구 이태원동', '01045678901', 'salute@danawa.com', CURRENT_DATE, false, '고객', ''),
('심규민', '1999-11-05', '서울 서초구 반포동', '01023456789', 'gyumin@dnffreecs.com', CURRENT_DATE, false, '고객', ''),
('김진현', '2001-02-17', '서울 송파구 가락동', '01034567890', 'diel@dnffreecs.com', CURRENT_DATE, false, '고객', ''),
('김태성', '2000-06-10', '서울 용산구 이태원동', '01045678901', 'heaven@dnffreecs.com', CURRENT_DATE, false, '고객', ''),
('노태영', '1999-08-12', '서울 강남구 청담동', '01012341234', 'eend@t1pubg.com', CURRENT_DATE, false, '고객', ''),
('김종명', '2000-01-05', '서울 서초구 반포동', '01023452345', 'rain1ng@t1pubg.com', CURRENT_DATE, false, '고객', ''),
('이진우', '1998-09-10', '서울 송파구 가락동', '01034563456', 'type@t1pubg.com', CURRENT_DATE, false, '리드', ''),
('차지훈', '2002-02-28', '서울 용산구 이태원동', '01045674567', 'heather@t1pubg.com', CURRENT_DATE, false, '고객', ''),
('김석희', '1999-06-18', '서울특별시 성북구 길음동', '01019990618', 'lovesh618@gmail.com', '2024-12-30', FALSE, '리드', NULL),
('최혜민', '1998-04-07', '경기도 성남시 분당구', '01029920911', 'chm0407@gmail.com', '2024-12-30', FALSE, '고객', NULL),
('곽우석', '1999-12-31', '서울특별시 동작구 상도1동', '01019991231', 'dntjr8106@gmail.com', '2024-12-30', FALSE, '리드', NULL),
('이서영', '', '서울특별시 강남구 수서동', '01096221456', 'seoyounglee@hwsystem.com', '2025-05-09', FALSE, '리드', NULL);

-- PRODUCT
INSERT INTO product (category, name, serial_number, product_code, company, origin_cost, rental_cost, description,
                     is_deleted, file_upload_id)
VALUES ('냉장고', '오브제컬렉션', 'S834BB30', 'LG-REF-S834BB30', 'LG', 2300000, 43900, 'LG에서 만든 예쁜 냉장고', FALSE, 1)
     , ('TV', '2024 QLED 4K QDE1 (189 cm) + 3.1 ch 사운드바 B650D', 'KQ75QDE1-B6', 'SAM-TV-KQ75QDE1-B6', '삼성', 3369000,
        67425, '삼성 QLED TV', FALSE, 1)
     , ('세탁기', '비스포크 그랑데 AI 세탁기', 'WF24B7600KW', 'SAM-WASH-WF24B7600KW', '삼성', 1890000, 37900, 'AI 기능을 탑재한 삼성 세탁기',
        FALSE, 2)
     , ('건조기', 'LG 트롬 듀얼 인버터 히트펌프', 'RH18VNA', 'LG-DRY-RH18VNA', 'LG', 1720000, 35500, '에너지 효율이 뛰어난 LG 건조기', FALSE, 2)
     , ('에어컨', '휘센 듀얼 에어컨 2in1', 'FQ18DADWE2', 'LG-AC-FQ18DADWE2', 'LG', 2490000, 46800, '여름 필수품, LG 휘센 에어컨', FALSE, 3)
     , ('청소기', '제트 무선 청소기 VS20A956B', 'VS20A956B', 'SAM-VAC-VS20A956B', '삼성', 1340000, 27900, '강력한 흡입력의 삼성 무선 청소기',
        FALSE, 3)
     , ('오븐', '비스포크 큐커 AI 오븐', 'MC32A7035KT', 'SAM-OVEN-MC32A7035KT', '삼성', 590000, 12500, '다기능 삼성 오븐', FALSE, 4)
     , ('식기세척기', '디오스 식기세척기 스팀', 'DUBJ1G', 'LG-DISH-DUBJ1G', 'LG', 1380000, 28900, '고온 스팀 살균 LG 식기세척기', FALSE, 4)
     , ('냉장고', '비스포크 냉장고 4도어', 'RF85T9111AP', 'SAM-REF-RF85T9111AP', '삼성', 3100000, 58900, '고급형 삼성 냉장고', FALSE, 5)
     , ('TV', 'LG OLED evo C3 65인치', 'OLED65C3KNA', 'LG-TV-OLED65C3KNA', 'LG', 2790000, 55300, '고화질 LG OLED TV', FALSE,
        5)
     , ('세탁기', 'LG 트윈워시 세탁기', 'F21VDP', 'LG-WASH-F21VDP', 'LG', 1980000, 39200, '세탁과 탈수를 동시에 LG 트윈워시', FALSE, 6)
     , ('건조기', '삼성 AI 건조기', 'DV90T8240SH', 'SAM-DRY-DV90T8240SH', '삼성', 1790000, 36500, 'AI 제어 삼성 건조기', FALSE, 6)
     , ('에어컨', '무풍에어컨 클래식', 'AF17A6474TZ', 'SAM-AC-AF17A6474TZ', '삼성', 2650000, 49500, '무풍 냉방 삼성 에어컨', FALSE, 7)
     , ('청소기', '코드제로 A9S', 'A958VA', 'LG-VAC-A958VA', 'LG', 1190000, 24500, 'LG 코드제로 무선 청소기', FALSE, 7)
     , ('오븐', 'LG 광파오븐 MA324B', 'MA324B', 'LG-OVEN-MA324B', 'LG', 540000, 11900, '간편한 요리를 위한 LG 오븐', FALSE, 8)
     , ('식기세척기', '삼성 비스포크 식기세척기', 'DW60A8055UG', 'SAM-DISH-DW60A8055UG', '삼성', 1450000, 29900, '스마트 기능 탑재 식기세척기', FALSE,
        8)
     , ('공기청정기', 'LG 퓨리케어 360° 공기청정기', 'AS351NNFA', 'LG-AP-AS351NNFA', 'LG', 1040000, 20900, '360도 청정 기능 LG 공기청정기',
        FALSE, 9)
     , ('공기청정기', '삼성 블루스카이 5000', 'AX60A5510WDD', 'SAM-AP-AX60A5510WDD', '삼성', 980000, 19900, '초미세먼지 제거 삼성 공기청정기',
        FALSE, 9)
     , ('전자레인지', 'LG 전자레인지 MW25S', 'MW25S', 'LG-MIW-MW25S', 'LG', 210000, 4900, '간단 요리를 위한 전자레인지', FALSE, 10)
     , ('제습기', '삼성 무풍 제습기', 'AY10R5171', 'SAM-DEH-AY10R5171', '삼성', 670000, 13900, '쾌적한 여름을 위한 삼성 제습기', FALSE, 10);

-- NOTICE
INSERT INTO NOTICE (id, title, content, created_at, is_deleted, employee_id)
VALUES
    (1, '출장비 처리 기준 변경', '출장비 청구 기준이 7월부로 일부 변경됩니다. 참고 바랍니다.', '2025-06-03 11:10:00', FALSE, 1),
    (2, '영업팀 주간 회의 시간 변경 공지', '영업팀 주간 회의가 매주 화요일 오전 9시로 변경되었습니다. 일정 관리에 유의해주세요.', '2025-05-27 09:00:00', FALSE, 6),
    (3, 'ERP 시스템 기능 추가 안내', 'ERP 시스템에 신규 기능이 추가되었습니다. 매뉴얼 참고 바랍니다.', '2025-06-17 14:10:00', FALSE, 1),
    (4, '고객정보 보안등급 강화 시행 안내', '고객정보 접근 보안등급이 강화되었습니다. 본인의 등급을 다시 한번 확인해주세요.', '2025-06-08 17:30:00', FALSE, 6),
    (5, 'CRM 시스템 주말 정기점검 실시', '이번 주 토요일 오후 11시부터 일요일 오전 4시까지 CRM 시스템 점검이 있습니다. 이용에 참고 부탁드립니다.', '2025-06-15 21:00:00', FALSE, 6),
    (6, '거래처 계약 갱신 주기 변경 안내', '거래처 계약 갱신 주기가 기존 1년에서 2년으로 연장되었습니다. 계약 관리 시 참고하세요.', '2025-06-01 09:00:00', FALSE, 6),
    (7, '사내 포상 기준 개편', '사내 포상 제도가 개편되었습니다. 포상 대상자 추천은 익월부터 적용됩니다.', '2025-06-05 13:45:00', FALSE, 1),
    (8, '거래처 클레임 대응 프로세스 안내', '거래처 클레임 대응 절차가 개정되었습니다. 변경된 프로세스를 반드시 확인해주세요.', '2025-05-30 10:20:00', FALSE, 6),
    (9, '3분기 영업실적 보고 제출 안내', '2025년 3분기 영업실적 보고서는 9월 30일까지 CRM에 업로드해주시기 바랍니다.', '2025-06-10 10:10:00', FALSE, 6),
    (10, '전사 보안 지침 개편', '사내 전반 보안 지침이 개편되었습니다. 필히 숙지 바랍니다.', '2025-05-23 08:30:00', FALSE, 1),
    (11, '보안 지침 안내', '거래처 방문 시 보안 지침이 강화되었습니다. 보안 교육 이수 필수입니다.', '2025-06-09 16:00:00', FALSE, 6),
    (12, '7월 영업 목표 입력 마감일 안내', '7월 영업 목표 입력은 6월 30일까지 마감입니다. 각 팀별로 CRM에 목표를 정확히 입력해주시기 바랍니다.', '2025-06-12 12:00:00', FALSE, 6),
    (13, '전사 워크숍 일정 공지', '전사 워크숍이 8월 초로 예정되어 있습니다. 일정은 추후 공지됩니다.', '2025-06-04 14:15:00', FALSE, 1),
    (14, '모바일 CRM 앱 활용 교육 일정', '모바일 CRM 앱 활용법 교육이 7월 15일 오후 2시부터 진행됩니다. 영업팀 전원 참석 바랍니다.', '2025-06-06 10:00:00', FALSE, 6),
    (15, 'CRM 서버 점검 일정', 'CRM 시스템 점검이 7월 마지막 주 주말 동안 예정되어 있습니다.', '2025-05-29 10:00:00', FALSE, 1),
    (16, '전자계약서 사용 의무화 공지', '앞으로 모든 계약서는 전자계약서 사용이 필수입니다. 미사용 시 승인 절차가 중지될 수 있습니다.', '2025-05-28 14:00:00', FALSE, 6),
    (17, '영업 정책 교육 안내', '2025년 영업 정책 변경사항을 반영한 교육이 7월 25일에 실시됩니다.', '2025-05-21 15:10:00', FALSE, 1),
    (18, '마케팅 협업 캠페인 참여 요청', '7월 마케팅 협업 캠페인 참여 영업팀을 모집합니다. 희망 팀은 팀장에게 보고 바랍니다.', '2025-06-11 13:40:00', FALSE, 6),
    (19, '재택근무 정책 변경', '8월부터 재택근무 신청 절차가 변경됩니다. HR에 문의 바랍니다.', '2025-06-16 10:30:00', FALSE, 1),
    (20, '견적서 작성 시 할인율 제한 강화 안내', '견적서 작성 시 할인율 적용 기준이 더욱 엄격해졌습니다. 변경 내용을 확인하시기 바랍니다.', '2025-06-07 15:00:00', FALSE, 6),
    (21, 'IT 자산 정기 점검', '7월 말 IT 자산 점검이 있습니다. 사용 기기 정보 갱신 바랍니다.', '2025-06-05 14:20:00', FALSE, 1),
    (22, '하반기 인센티브 지급 기준 안내', '하반기 인센티브 지급 기준이 매출 목표 대비 성과 비율로 변경됩니다. 세부 사항은 팀장에게 문의하세요.', '2025-05-31 08:45:00', FALSE, 6),
    (23, '사내 메신저 영업 대응 매뉴얼 업데이트', '메신저를 통한 영업 대응 매뉴얼이 업데이트되었습니다. 필히 숙지하여 영업활동에 활용 바랍니다.', '2025-06-02 16:10:00', FALSE, 6),
    (24, '우수 영업사원 선발 및 포상 안내', '2025년 하반기 우수 영업사원 선발 기준과 포상 내용이 변경되었습니다. 자세한 사항은 인트라넷을 참고하세요.', '2025-05-26 17:50:00', FALSE, 6),
    (25, '거래처 등급 평가 기준 업데이트', '거래처 평가 기준이 변경되었습니다. 상세 평가 항목은 별도의 안내문을 참고하세요.', '2025-05-20 09:25:00', FALSE, 6),
    (26, '법인카드 사용 지침', '법인카드 사용 시 필수 첨부 서류가 변경되었습니다.', '2025-06-12 13:40:00', FALSE, 1),
    (27, '영업사원 업무 평가 항목 추가 안내', '영업사원 업무 평가 항목에 고객 응대 만족도가 추가되었습니다. 평가에 대비해주세요.', '2025-05-29 11:55:00', FALSE, 6),
    (28, '상반기 업무 평가 기준 안내', '2025 상반기 평가 기준이 신규 반영됩니다. 각 팀은 기준에 따라 준비 바랍니다.', '2025-06-13 12:00:00', FALSE, 1),
    (29, '신입 영업사원 온보딩 교육 일정', '신입사원 대상 온보딩 교육이 7월 20일부터 22일까지 진행됩니다. 해당 직원은 반드시 참석 바랍니다.', '2025-06-06 08:50:00', FALSE, 6),
    (30, '하계 휴가 기간 영업 지원 안내', '하계 휴가 기간 중 영업 지원 인력이 제한됩니다. 휴가 일정을 미리 조율해주세요.', '2025-06-04 18:30:00', FALSE, 6),
    (31, '직무교육 이수 안내', '각 부서별 직무교육 이수율 점검 예정입니다. 교육 자료 확인 바랍니다.', '2025-06-03 15:00:00', FALSE, 1),
    (32, '세일즈 파이프라인 관리 기준 변경 안내', '세일즈 파이프라인 관리 기준이 일부 변경되었습니다. 변경된 기준을 CRM에 반영해주세요.', '2025-05-22 09:10:00', FALSE, 6),
    (33, '신규 거래처 등록 절차 변경 공지', '신규 거래처 등록 시 사업자등록증 사본 첨부가 필수로 변경되었습니다. 빠짐없이 제출 바랍니다.', '2025-06-14 10:20:00', FALSE, 6),
    (34, '출장비 정산 양식 개정 안내', '출장비 정산 양식이 변경되었습니다. 변경된 양식을 사용하여 다음 달부터 제출 바랍니다.', '2025-06-15 15:40:00', FALSE, 6),
    (35, '회의실 예약 시스템 변경', '회의실 예약 방식이 새롭게 변경됩니다. 사내 공지를 확인하세요.', '2025-05-28 11:20:00', FALSE, 1),
    (36, '거래처 방문 시 주의사항 안내', '거래처 방문 시 보안 지침이 강화되었습니다. 사내 보안 교육을 다시 확인하시기 바랍니다.', '2025-06-07 17:45:00', FALSE, 6),
    (37, '거래처 클레임 대응 프로세스 안내', '거래처 클레임 대응 절차가 개선되었습니다. 변경된 절차를 반드시 숙지 바랍니다.', '2025-06-09 16:15:00', FALSE, 6),
    (38, '연차 사용 계획 제출 요청', '7월 내 연차 사용 계획을 각 팀에서 수합하여 제출 바랍니다.', '2025-06-18 10:10:00', FALSE, 1),
    (39, '고객 방문 보고서 양식 변경 안내', '7월부터 고객 방문 보고서 양식이 간소화됩니다. 새로운 양식을 인트라넷에서 다운받아 사용해주세요.', '2025-05-19 14:45:00', FALSE, 6),
    (40, '신입 영업사원 온보딩 교육 일정', '온보딩 교육은 사내 강당에서 진행되며, 부서별 스케줄 확인 바랍니다.', '2025-06-03 11:30:00', FALSE, 6),
    (41, '법인카드 사용 가이드 배포', '법인카드 신규 사용 가이드가 배포되었습니다. 반드시 참조 바랍니다.', '2025-05-27 10:00:00', FALSE, 1),
    (42, '모바일 CRM 앱 활용 교육 일정', '모바일 CRM 앱 활용 교육 일정이 확정되었습니다. 영업팀 전원 참석 바랍니다.', '2025-06-16 13:20:00', FALSE, 6),
    (43, '전자계약서 사용 의무화 공지', '전자계약서 사용이 의무화됩니다. 업무에 혼선이 없도록 미리 준비 바랍니다.', '2025-06-08 08:50:00', FALSE, 6),
    (44, '사내 포상 제도 변경', '포상 기준 및 항목이 일부 조정되었습니다. 관련 문서 참고 바랍니다.', '2025-06-20 17:15:00', FALSE, 1),
    (45, '거래처 등급 평가 기준 업데이트', '평가 기준 변경에 따라 거래처 분류 체계를 갱신 바랍니다.', '2025-06-17 09:00:00', FALSE, 6),
    (46, '영업 활동 일지 제출 안내', '일일 활동 보고를 매일 오후 6시까지 완료해주시기 바랍니다.', '2025-05-25 18:10:00', FALSE, 6),
    (47, '고객정보 보안등급 강화 시행 안내', '보안등급별 권한이 재조정되었습니다. 부서장과 확인 요망.', '2025-06-21 10:40:00', FALSE, 6),
    (48, '하반기 프로모션 정책 변경', '하반기 프로모션 할인율 및 적용 대상이 변경되었습니다. 변경된 내용을 영업 전략에 반영해주세요.', '2025-06-19 14:00:00', FALSE, 6),
    (49, '상반기 업무 결과 제출 안내', '상반기 목표 대비 실적 보고서를 6월 말까지 제출 바랍니다.', '2025-06-10 17:30:00', FALSE, 1),
    (50, '회의실 운영 규칙 재안내', '회의실 이용 시간 및 예약 관련 규칙이 변경되었습니다.', '2025-06-06 15:50:00', FALSE, 1);

-- QNA
INSERT INTO QNA (id, title, content, created_at, answer_status, answer_content, is_deleted, employee_id)
VALUES
    (1, '거래처 정보 수정 권한 문제', '해당 기능을 사용하려면 어떤 권한이 필요한지 알고 싶습니다.', '2025-05-15 09:12:30', '대기', NULL, FALSE, 4),
    (2, '출장비 정산 반려 사유 확인 요청', '출장비가 계속 반려되고 있습니다. 이유를 알려주세요.', '2025-05-20 08:45:46', '완료', '출장 목적 누락 및 영수증 파일이 첨부되지 않았습니다.', FALSE, 7),
    (3, '모바일 CRM 메모 동기화 오류', '모바일에서 작성한 메모가 PC에서 확인되지 않습니다.', '2025-05-23 11:03:21', '대기', NULL, FALSE, 10),
    (4, 'CRM 로그인 세션 유지 문제', '로그인 후 금방 세션이 끊깁니다.', '2025-05-25 14:21:10', '완료', '브라우저 캐시 삭제 후 로그인하면 개선될 수 있습니다.', FALSE, 6),
    (5, '고객 방문 보고서 등록 장애', '보고서에 사진을 첨부하면 등록되지 않습니다.', '2025-05-28 13:42:55', '완료', '파일 크기 또는 형식 제한을 확인해주세요. PNG, JPG, PDF만 지원됩니다.', FALSE, 1),
    (6, '신규 거래처 등록 중 오류 발생', '사업자 번호 입력 시 오류가 납니다.', '2025-06-01 10:18:22', '대기', NULL, FALSE, 7),
    (7, '계약서 최신 양식 요청', '최신 계약서 양식을 어디서 다운받을 수 있나요?', '2025-06-02 16:09:01', '완료', '인트라넷 > 영업지원 > 문서함 > 계약서 폴더에서 확인 가능합니다.', FALSE, 6),
    (8, '영업 실적 집계 기준 문의', '실적은 계약일 기준인가요, 입금일 기준인가요?', '2025-06-03 08:15:47', '완료', '기본적으로 계약 체결일 기준입니다.', FALSE, 4),
    (9, 'CRM 로그인 세션 유지 문제', '자꾸 로그아웃 됩니다. 해결책이 궁금합니다.', '2025-06-05 12:34:18', '완료', '캐시를 삭제하거나 브라우저 업데이트를 권장드립니다.', FALSE, 10),
    (10, '고객 이탈 알림 미작동 문의', '설정해둔 고객 이탈 알림이 작동하지 않습니다.', '2025-06-06 09:41:11', '대기', NULL, FALSE, 1),
    (11, '모바일 CRM 메모 동기화 오류', 'PC에서 작성한 메모가 모바일에서 누락됩니다.', '2025-06-08 11:03:10', '완료', '앱에서 동기화 버튼을 수동으로 눌러주세요.', FALSE, 6),
    (12, '출장비 정산 반려 사유 확인 요청', '출장비가 왜 반려되었는지 이유를 알고 싶습니다.', '2025-06-10 13:20:50', '완료', '출장지 정보가 빠졌고 영수증이 누락되었습니다.', FALSE, 4),
    (13, '계약서 최신 양식 요청', '현재 문서함에 있는 계약서가 구버전입니다.', '2025-06-11 15:44:02', '완료', '최신 양식은 문서함 → 최신 계약서 탭에서 확인 가능합니다.', FALSE, 10),
    (14, '프로모션 할인 코드 미적용 문제', '견적서에 할인 코드가 적용되지 않습니다.', '2025-06-12 17:18:33', '대기', NULL, FALSE, 6),
    (15, 'CRM 로그인 세션 유지 문제', '짧은 시간 후 자동 로그아웃 되는 문제가 있습니다.', '2025-06-13 18:19:45', '완료', '크롬 최신 버전 사용을 권장하며, 자동 로그아웃 설정을 확인해주세요.', FALSE, 1),
    (16, '신규 거래처 등록 중 오류 발생', '등록이 완료되지 않고 오류가 발생합니다.', '2025-06-14 09:50:12', '완료', '입력값에 특수문자가 포함되지 않도록 유의해주세요.', FALSE, 7),
    (17, '거래처 정보 수정 권한 문제', '거래처 이메일 수정 권한이 없다고 나옵니다.', '2025-06-15 11:22:29', '완료', '해당 권한은 팀장 이상에게 요청해야 합니다.', FALSE, 4),
    (18, '영업 실적 집계 기준 문의', '실적 기준일이 명확하지 않아 혼동됩니다.', '2025-06-16 13:01:37', '완료', '실적은 계약일 기준이며, 입금일 기준은 승인 절차 필요.', FALSE, 6),
    (19, '고객 방문 보고서 등록 장애', '첨부파일 업로드 시 오류가 납니다.', '2025-06-17 14:55:24', '대기', NULL, FALSE, 10),
    (20, 'CRM 로그인 세션 유지 문제', '자주 로그아웃되는 현상이 있습니다.', '2025-06-18 10:45:10', '완료', '보안 정책 상 장시간 미사용 시 자동 로그아웃됩니다.', FALSE, 1),
    (21, '신규 거래처 등록 오류', '등록 버튼 클릭 시 아무 반응이 없습니다.', '2025-06-19 09:13:04', '대기', NULL, FALSE, 6),
    (22, '출장비 계산 기준 문의', '출장비 계산 시 거리 기준이 어떻게 되나요?', '2025-06-18 14:50:29', '완료', '출장비는 직선거리 10km 이상부터 정산 가능합니다.', FALSE, 1),
    (23, '고객 이탈 알림 설정 방법', '알림 기준을 설정하는 방법이 궁금합니다.', '2025-06-17 11:32:15', '완료', 'CRM 알림 설정 > 고객 조건 설정에서 가능합니다.', FALSE, 7),
    (24, '모바일 CRM 접속 장애', '로그인이 되지 않고 앱이 종료됩니다.', '2025-06-16 08:23:47', '완료', '앱 업데이트 후 재시도 해보시고, 문제가 지속되면 IT팀에 문의 바랍니다.', FALSE, 4),
    (25, '견적서 작성 시 오류', '특정 항목에서 단가 입력이 불가능합니다.', '2025-06-15 10:15:12', '대기', NULL, FALSE, 10),
    (26, '계약서 양식 관련 문의', '기존 양식과 변경된 양식의 차이를 알고 싶습니다.', '2025-06-14 15:39:31', '완료', '변경된 양식은 계약 조항이 추가되었으며 인트라넷 공지에 상세 설명이 포함되어 있습니다.', FALSE, 1),
    (27, 'CRM 자동 로그아웃 빈도 조정 요청', '너무 자주 로그아웃되어 불편합니다.', '2025-06-13 13:18:00', '대기', NULL, FALSE, 6),
    (28, '거래처 관리 화면 표시 오류', '거래처명이 중복되어 표시됩니다.', '2025-06-12 09:46:50', '완료', '캐시 문제로 중복 표시될 수 있으며 새로고침 후에도 지속되면 IT팀에 문의 바랍니다.', FALSE, 4),
    (29, '사내 메신저 연동 문제', 'CRM에서 메신저로 자동 전송이 되지 않습니다.', '2025-06-11 14:20:45', '완료', '메신저 연동 설정이 꺼져 있을 수 있으니 확인 후 활성화 해주세요.', FALSE, 7),
    (30, '직무 교육 이수 여부 확인 요청', '제가 이수한 교육이 CRM에 반영되지 않았습니다.', '2025-06-10 10:32:18', '완료', '교육 이수 정보는 매주 금요일 반영되며, 누락 시 인사팀에 문의해주세요.', FALSE, 6),
    (31, '고객 등급 자동 변경 문제', '고객 등급이 기준을 충족했는데도 변경되지 않습니다.', '2025-06-09 15:15:50', '대기', NULL, FALSE, 1),
    (32, '마케팅 메일 발송 오류', '메일 발송 버튼 클릭 시 반응이 없습니다.', '2025-06-08 09:03:21', '완료', '메일 서버가 일시 중지된 경우입니다. 현재는 정상화되었습니다.', FALSE, 10),
    (33, '신규 고객 등록 시 자동 알림 설정 여부', '등록된 고객에게 자동 알림을 보내는 기능이 있나요?', '2025-06-07 08:40:59', '완료', '고객 등록 시 자동 알림은 기본 설정되어 있으며, 개인 설정에서 해제 가능합니다.', FALSE, 6),
    (34, '인센티브 정산 기준 문의', '정산 기준이 팀 목표 기준인지 개인 기준인지요?', '2025-06-06 17:10:44', '완료', '인센티브는 기본적으로 팀 목표 기준이며 개인 성과도 일부 반영됩니다.', FALSE, 4),
    (35, '조직도 정보 오류 신고', '조직도에서 팀장 이름이 잘못 표시되어 있습니다.', '2025-06-05 13:56:18', '대기', NULL, FALSE, 7),
    (36, '캘린더 일정 공유 문제', '팀원들과 일정을 공유하려면 어떻게 하나요?', '2025-06-04 12:45:05', '완료', '일정 등록 시 "공유 대상"에 팀원을 추가하면 됩니다.', FALSE, 10),
    (37, '공지사항 알림 수신 누락', '공지사항을 받지 못하는 직원이 있습니다.', '2025-06-03 16:32:41', '완료', '알림 그룹 설정을 확인하고 누락된 인원을 추가해 주세요.', FALSE, 6),
    (38, '전자계약서 서명 오류', '계약서에 서명하려고 하면 오류가 발생합니다.', '2025-06-02 11:41:20', '대기', NULL, FALSE, 1),
    (39, '할인율 자동 적용 기준', 'CRM에서 할인율이 자동 적용되지 않습니다.', '2025-06-01 09:29:48', '완료', '할인율은 고객 등급과 계약 기간을 기반으로 자동 계산됩니다.', FALSE, 4),
    (40, '퇴사자 정보 반영 지연 문의', '이미 퇴사한 직원이 여전히 CRM에 표시됩니다.', '2025-05-31 10:12:17', '완료', '퇴사자 정보는 인사팀 처리 후 24시간 내 반영됩니다.', FALSE, 7);

-- CONTRACT
INSERT INTO CONTRACT (id, code, created_at, start_date, end_date, status, amount, bank_name, bank_account, payment_day,
                      deposit_owner, relationship, payment_email, is_deleted, etc, document_origin_id, customer_id,
                      employee_id)
VALUES (1, 'CNTR2024001', '2025-05-01 13:16:26.385656', '2025-05-26', '2026-05-28', '완료', 1100000, '신한은행',
        '110-001-56789', 11, '예금주1', '본인', 'user1@email.com', False, NULL, 1, 2, 2),
       (2, 'CNTR2024002', '2025-05-05 07:11:14.385684', '2025-05-24', '2026-05-28', '진행중', 1200000, '신한은행',
        '110-002-56789', 12, '예금주2', '본인', 'user2@email.com', False, NULL, 1, 3, 3),
       (3, 'CNTR2024003', '2025-05-08 03:27:11.385696', '2025-05-22', '2026-05-28', '완료', 1300000, '신한은행',
        '110-003-56789', 13, '예금주3', '본인', 'user3@email.com', False, NULL, 1, 4, 4),
       (4, 'CNTR2024004', '2025-05-10 14:09:14.385705', '2025-05-20', '2026-05-28', '진행중', 1400000, '신한은행',
        '110-004-56789', 14, '예금주4', '본인', 'user4@email.com', False, NULL, 1, 5, 5),
       (5, 'CNTR2024005', '2025-05-14 00:26:21.385715', '2025-05-18', '2026-05-28', '완료', 1500000, '신한은행',
        '110-005-56789', 15, '예금주5', '본인', 'user5@email.com', False, NULL, 1, 6, 6),
       (6, 'CNTR2024006', '2025-05-16 02:13:58.385726', '2025-05-16', '2026-05-28', '진행중', 1600000, '신한은행',
        '110-006-56789', 16, '예금주6', '본인', 'user6@email.com', False, NULL, 1, 7, 7),
       (7, 'CNTR2024007', '2025-05-14 02:13:58.385736', '2025-05-14', '2026-05-28', '완료', 1700000, '신한은행',
        '110-007-56789', 17, '예금주7', '본인', 'user7@email.com', False, NULL, 1, 1, 1);

-- CONSULTATION
INSERT INTO CONSULTATION (consult_at, content, is_deleted, etc, feedback_score, employee_id, customer_id)
VALUES
(CURRENT_TIMESTAMP, 'LG 퓨리케어 냉온정수기 렌탈을 고려 중입니다. 설치 공간이 협소한데 미니 타입도 있는지, 월 렌탈료 및 설치 비용이 궁금합니다.', false, '1인 가구', NULL, 1, 1),
(CURRENT_TIMESTAMP, '삼성 그랑데 건조기와 세탁기 패키지 렌탈 상담 요청드립니다. 3년 약정 시 월 렌탈료, 무상 A/S 기간, 설치 일정 포함해서 안내 부탁드립니다.', false, '부모님 명의', NULL, 1, 2),
(CURRENT_TIMESTAMP, '삼성 비스포크 냉장고 대형 모델 렌탈을 희망합니다. 외국인 등록증으로 계약 가능한지, 약정 기간과 계약 조건을 안내받고 싶습니다.', false, '영문 계약 요청', NULL, 3, 3),
(CURRENT_TIMESTAMP, '위닉스 공기청정기와 코웨이 비데 렌탈을 함께 이용하려고 합니다. 결합 할인 혜택과 렌탈 기간별 조건을 상담받고 싶습니다.', false, '자취방 환경', NULL, 5, 4),
(CURRENT_TIMESTAMP, '안마의자 렌탈을 고려 중입니다. 브람스, 바디프랜드 등 브랜드별 렌탈 조건을 비교하고 싶습니다. 고등학생도 렌탈 신청이 가능한지도 궁금합니다.', false, '실사용자 부모님', NULL, 4, 5),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '외국인 등록증 보유', NULL, 1, 5),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '학생', NULL, 2, 5),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '신혼부부', NULL, 5, 28),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '반려동물 있음', NULL, 1, 5),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '신혼부부', NULL, 5, 31),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '부모님 명의', NULL, 4, 29),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '군인 가족', NULL, 2, 29),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '다자녀 가정', NULL, 4, 26),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '부모님 명의', NULL, 5, 30),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '직장인', NULL, 4, 29),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '신혼부부', NULL, 5, 29),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '외국인 등록증 보유', NULL, 5, 13),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '학생', NULL, 2, 30),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '직장인', NULL, 5, 20),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '다자녀 가정', NULL, 3, 13),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '부모님 명의', NULL, 4, 28),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '부모님 명의', NULL, 5, 39),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '학생', NULL, 3, 28),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '다자녀 가정', NULL, 4, 20),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '부모님 명의', NULL, 3, 29),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '다자녀 가정', NULL, 5, 5),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '반려동물 있음', NULL, 4, 30),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '부모님 명의', NULL, 1, 31),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '1인 가구', NULL, 1, 39),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '군인 가족', NULL, 1, 29),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '프리랜서', NULL, 2, 30),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '1인 가구', NULL, 3, 12),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '부모님 명의', NULL, 1, 5),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '프리랜서', NULL, 3, 20),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '다자녀 가정', NULL, 3, 26),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '외국인 등록증 보유', NULL, 1, 27),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '외국인 등록증 보유', NULL, 2, 12),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '신혼부부', NULL, 5, 13),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '프리랜서', NULL, 3, 31),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '반려동물 있음', NULL, 4, 26),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '반려동물 있음', NULL, 4, 12),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '다자녀 가정', NULL, 1, 30),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '외국인 등록증 보유', NULL, 1, 29),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '군인 가족', NULL, 5, 26),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '직장인', NULL, 1, 27),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '외국인 등록증 보유', NULL, 4, 5),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '군인 가족', NULL, 5, 28),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '직장인', NULL, 4, 27),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '다자녀 가정', NULL, 4, 39),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '프리랜서', NULL, 5, 9),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '프리랜서', NULL, 5, 39),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '프리랜서', NULL, 5, 29),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '1인 가구', NULL, 3, 39),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '학생', NULL, 3, 31),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '프리랜서', NULL, 5, 20),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '외국인 등록증 보유', NULL, 3, 5),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '신혼부부', NULL, 2, 20),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '부모님 명의', NULL, 2, 30),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '부모님 명의', NULL, 5, 13),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '프리랜서', NULL, 3, 30),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '군인 가족', NULL, 1, 30),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '프리랜서', NULL, 3, 12),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '프리랜서', NULL, 5, 39),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '군인 가족', NULL, 1, 5),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '반려동물 있음', NULL, 3, 9),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '외국인 등록증 보유', NULL, 3, 29),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '직장인', NULL, 3, 5),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '반려동물 있음', NULL, 1, 9),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '직장인', NULL, 2, 26),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '외국인 등록증 보유', NULL, 4, 26),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '부모님 명의', NULL, 1, 28),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '신혼부부', NULL, 1, 31),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '신혼부부', NULL, 1, 31),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '반려동물 있음', NULL, 3, 31),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '다자녀 가정', NULL, 1, 20),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '외국인 등록증 보유', NULL, 5, 13),
(CURRENT_TIMESTAMP, '외국인 등록증으로 렌탈 가능한 상품이 무엇이 있는지요?', false, '학생', NULL, 5, 31),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '1인 가구', NULL, 3, 9),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '다자녀 가정', NULL, 4, 27),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '반려동물 있음', NULL, 2, 27),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '직장인', NULL, 4, 39),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '외국인 등록증 보유', NULL, 5, 31),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '다자녀 가정', NULL, 2, 26),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '반려동물 있음', NULL, 3, 27),
(CURRENT_TIMESTAMP, '렌탈 기간 연장 시 할인 혜택이 있는지 알고 싶습니다.', false, '직장인', NULL, 3, 13),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '군인 가족', NULL, 5, 30),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '외국인 등록증 보유', NULL, 1, 27),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '학생', NULL, 4, 12),
(CURRENT_TIMESTAMP, '정수기 렌탈 상품에 대해 문의드립니다. 냉온정수기 모델 차이도 설명 부탁드립니다.', false, '프리랜서', NULL, 4, 29),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '외국인 등록증 보유', NULL, 2, 20),
(CURRENT_TIMESTAMP, '안마의자 렌탈 상담 요청드립니다. 고급형 모델 위주로 견적 받고 싶습니다.', false, '군인 가족', NULL, 3, 31),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '학생', NULL, 2, 29),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '군인 가족', NULL, 3, 27),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '부모님 명의', NULL, 4, 12),
(CURRENT_TIMESTAMP, '신혼부부 대상 렌탈 추천 상품과 프로모션을 안내받고 싶습니다.', false, '직장인', NULL, 1, 31),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '군인 가족', NULL, 3, 28),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '신혼부부', NULL, 1, 28),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '직장인', NULL, 1, 31),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '군인 가족', NULL, 2, 12),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '부모님 명의', NULL, 4, 39),
(CURRENT_TIMESTAMP, 'A/S 서비스 기준과 처리 시간 안내 부탁드립니다.', false, '군인 가족', NULL, 4, 13),
(CURRENT_TIMESTAMP, '기존 고객입니다. 계약 갱신 조건과 제품 교체 가능 여부가 궁금합니다.', false, '학생', NULL, 4, 9),
(CURRENT_TIMESTAMP, '세탁기+건조기 패키지 렌탈을 희망합니다. 월 렌탈료와 프로모션 안내 부탁드립니다.', false, '1인 가구', NULL, 5, 28),
(CURRENT_TIMESTAMP, '공기청정기 렌탈 약정 기간별 요금이 궁금합니다. 설치비 포함인지요?', false, '외국인 등록증 보유', NULL, 1, 5),
(CURRENT_TIMESTAMP, '정수기와 비데 결합 렌탈 시 할인 여부 문의드립니다.', false, '군인 가족', NULL, 2, 13);

-- DOCUMENT_TEMPLATE
INSERT INTO DOCUMENT_TEMPLATE (id, name, version, description, created_at, is_deleted, file_upload_id)
VALUES (1, '계약서 템플릿1', 'v1.1', '설명 1', '2025-05-01 23:28:44.466860', False, 1),
       (2, '계약서 템플릿2', 'v1.2', '설명 2', '2025-05-04 17:41:40.466865', False, 2),
       (3, '계약서 템플릿3', 'v1.3', '설명 3', '2025-05-08 01:46:46.466867', False, 3),
       (4, '계약서 템플릿4', 'v1.4', '설명 4', '2025-05-11 05:09:30.466868', False, 4),
       (5, '계약서 템플릿5', 'v1.5', '설명 5', '2025-05-14 06:37:43.466870', False, 5),
       (6, '계약서 템플릿6', 'v1.6', '설명 6', '2025-05-28 02:14:09.466872', False, 6),
       (7, '계약서 템플릿7', 'v1.7', '설명 7', '2025-05-28 02:14:09.466873', False, 7);

-- DOCUMENT_ORIGIN
INSERT INTO DOCUMENT_ORIGIN (id, created_at, is_deleted, document_template_id, file_upload_id)
VALUES (1, '2025-05-02 05:29:54.466978', False, 1, 1),
       (2, '2025-05-05 06:35:25.466979', False, 2, 2),
       (3, '2025-05-07 23:21:51.466979', False, 3, 3),
       (4, '2025-05-11 04:05:03.466980', False, 4, 4),
       (5, '2025-05-13 18:06:55.466980', False, 5, 5),
       (6, '2025-05-28 02:14:09.466981', False, 6, 6),
       (7, '2025-05-28 02:14:09.466981', False, 7, 7);

-- APPROVAL
# INSERT INTO APPROVAL (id, code, title, content, req_date, aprv_date, state, comment, req_id, aprv_id, contract_id)
# VALUES (1, 'APR2024001', '승인 요청 제목1', '승인 요청 내용1', '2025-05-01 23:48:33.467055', '2025-05-01 23:48:33.467056', '반려',
#         '코멘트1', 2, 3, 1),
#        (2, 'APR2024002', '승인 요청 제목2', '승인 요청 내용2', '2025-05-04 18:38:04.467058', '2025-05-04 18:38:04.467059', '승인',
#         '코멘트2', 3, 4, 2),
#        (3, 'APR2024003', '승인 요청 제목3', '승인 요청 내용3', '2025-05-07 20:34:51.467061', '2025-05-07 20:34:51.467061', '반려',
#         '코멘트3', 4, 5, 3),
#        (4, 'APR2024004', '승인 요청 제목4', '승인 요청 내용4', '2025-05-11 00:29:46.467062', '2025-05-11 00:29:46.467063', '승인',
#         '코멘트4', 5, 6, 4),
#        (5, 'APR2024005', '승인 요청 제목5', '승인 요청 내용5', '2025-05-13 21:16:18.467064', '2025-05-13 21:16:18.467065', '반려',
#         '코멘트5', 6, 7, 5),
#        (6, 'APR2024006', '승인 요청 제목6', '승인 요청 내용6', '2025-05-28 02:14:09.467066', '2025-05-28 02:14:09.467067', '승인',
#         '코멘트6', 7, 1, 6),
#        (7, 'APR2024007', '승인 요청 제목7', '승인 요청 내용7', '2025-05-28 02:14:09.467068', '2025-05-28 02:14:09.467068', '반려',
#         '코멘트7', 1, 2, 7);


-- SALES
INSERT INTO SALES (sales_date, department, employee_name, amount, is_deleted, contract_id)
VALUES
-- 영업1팀 (6건)
('2025-01-10', '영업1팀', '강수지', 120000, false, 1),
('2025-01-22', '영업1팀', '고성연', 55000, false, 2),
('2025-02-15', '영업1팀', '고윤석', 190000, false, 3),
('2025-02-27', '영업1팀', '김성민', 75000, false, 4),
('2025-03-12', '영업1팀', '강수지', 135000, false, 5),
('2025-03-29', '영업1팀', '고성연', 99000, false, 6),

-- 영업2팀 (6건)
('2025-01-14', '영업2팀', '최은경', 88000, false, 7),
('2025-01-30', '영업2팀', '이주은', 142000, false, 8),
('2025-02-08', '영업2팀', '윤수수', 157000, false, 9),
('2025-02-24', '영업2팀', '최민진', 103000, false, 10),
('2025-03-05', '영업2팀', '최은경', 189000, false, 11),
('2025-03-20', '영업2팀', '이주은', 67000, false, 12),

-- 영업3팀 (6건)
('2025-01-18', '영업3팀', '김슬민', 54000, false, 13),
('2025-02-02', '영업3팀', '이은민', 176000, false, 14),
('2025-02-19', '영업3팀', '정석하', 112000, false, 15),
('2025-03-08', '영업3팀', '한석슬', 198000, false, 16),
('2025-03-25', '영업3팀', '김슬민', 89000, false, 17),
('2025-04-10', '영업3팀', '이은민', 128000, false, 18),

-- 영업4팀 (6건)
('2025-01-25', '영업4팀', '정하슬', 103000, false, 19),
('2025-02-10', '영업4팀', '이진하', 149000, false, 20),
('2025-02-28', '영업4팀', '장현우', 131000, false, 21),
('2025-03-15', '영업4팀', '최주호', 47000, false, 22),
('2025-04-01', '영업4팀', '정하슬', 156000, false, 23),
('2025-04-18', '영업4팀', '이진하', 98000, false, 24),

-- 영업5팀 (6건)
('2025-01-30', '영업5팀', '김은수', 112000, false, 25),
('2025-02-14', '영업5팀', '한호은', 163000, false, 26),
('2025-03-02', '영업5팀', '한진경', 54000, false, 27),
('2025-03-20', '영업5팀', '한슬수', 199000, false, 28),
('2025-04-05', '영업5팀', '김은수', 73000, false, 29),
('2025-04-22', '영업5팀', '한호은', 128000, false, 30);

INSERT INTO SALES (sales_date, department, employee_name, amount, is_deleted, contract_id)
VALUES
-- 영업1팀
('2025-04-12', '영업1팀', '고윤석', 139000, false, 31),
('2025-04-28', '영업1팀', '김성민', 118000, false, 32),
('2025-05-06', '영업1팀', '강수지', 72000, false, 33),
('2025-05-18', '영업1팀', '이정은', 95000, false, 34),
('2025-06-02', '영업1팀', '고성연', 187000, false, 35),
('2025-06-17', '영업1팀', '박진우', 126000, false, 36),

-- 영업2팀
('2025-04-03', '영업2팀', '한예린', 152000, false, 37),
('2025-04-14', '영업2팀', '오세훈', 87000, false, 38),
('2025-05-01', '영업2팀', '강지수', 165000, false, 39),
('2025-05-20', '영업2팀', '정현우', 131000, false, 40),
('2025-06-04', '영업2팀', '최민진', 105000, false, 41),
('2025-06-21', '영업2팀', '이주은', 119000, false, 42),

-- 영업3팀
('2025-04-08', '영업3팀', '한석슬', 114000, false, 43),
('2025-04-24', '영업3팀', '정석하', 174000, false, 44),
('2025-05-10', '영업3팀', '이은민', 73000, false, 45),
('2025-05-25', '영업3팀', '김슬민', 99000, false, 46),
('2025-06-06', '영업3팀', '송지효', 125000, false, 47),
('2025-06-28', '영업3팀', '김종국', 158000, false, 48),

-- 영업4팀
('2025-04-11', '영업4팀', '최주호', 144000, false, 49),
('2025-04-27', '영업4팀', '장현우', 66000, false, 50),
('2025-05-08', '영업4팀', '이진하', 103000, false, 51),
('2025-05-23', '영업4팀', '정하슬', 84000, false, 52),
('2025-06-10', '영업4팀', '장현우', 155000, false, 53),
('2025-06-25', '영업4팀', '최주호', 134000, false, 54),

-- 영업5팀
('2025-04-06', '영업5팀', '서지혜', 122000, false, 55),
('2025-04-19', '영업5팀', '유아인', 178000, false, 56),
('2025-05-04', '영업5팀', '홍진호', 98000, false, 57),
('2025-05-22', '영업5팀', '이강인', 72000, false, 58),
('2025-06-08', '영업5팀', '한호은', 169000, false, 59),
('2025-06-27', '영업5팀', '한슬수', 110000, false, 60);

-- 25년 3분기
INSERT INTO SALES (sales_date, department, employee_name, amount, is_deleted, contract_id)
VALUES ('2025-07-12', '영업1팀', '고성연', 123995, false, 12),
       ('2025-07-02', '영업1팀', '김성민', 160460, false, 33),
       ('2025-09-25', '영업1팀', '김성민', 152980, false, 25),
       ('2025-09-12', '영업1팀', '강수지', 190187, false, 9),
       ('2025-08-03', '영업1팀', '고성연', 199661, false, 49),
       ('2025-08-10', '영업1팀', '고성연', 165315, false, 44),
       ('2025-08-03', '영업1팀', '고윤석', 215738, false, 40),
       ('2025-09-30', '영업1팀', '고성연', 168836, false, 35),
       ('2025-08-14', '영업1팀', '고윤석', 228566, false, 15),
       ('2025-09-01', '영업1팀', '고윤석', 176352, false, 2),
       ('2025-07-15', '영업1팀', '고윤석', 171333, false, 41),
       ('2025-09-03', '영업1팀', '고성연', 136846, false, 42),
       ('2025-07-15', '영업1팀', '고성연', 185823, false, 28),
       ('2025-08-06', '영업1팀', '김성민', 175742, false, 19),
       ('2025-07-11', '영업1팀', '고윤석', 143952, false, 31),
       ('2025-09-27', '영업1팀', '김성민', 213473, false, 31),
       ('2025-07-03', '영업2팀', '윤수수', 184963, false, 19),
       ('2025-07-03', '영업2팀', '윤수수', 173501, false, 50),
       ('2025-08-03', '영업2팀', '이주은', 65868, false, 23),
       ('2025-09-28', '영업2팀', '최민진', 73055, false, 45),
       ('2025-09-01', '영업2팀', '최민진', 135273, false, 16),
       ('2025-07-31', '영업2팀', '최민진', 135454, false, 40),
       ('2025-09-09', '영업2팀', '이주은', 54659, false, 19),
       ('2025-09-04', '영업2팀', '최민진', 171058, false, 24),
       ('2025-08-20', '영업2팀', '이주은', 76657, false, 26),
       ('2025-08-29', '영업2팀', '최민진', 86699, false, 7),
       ('2025-09-23', '영업3팀', '한석슬', 64402, false, 15),
       ('2025-09-19', '영업3팀', '정석하', 184653, false, 5),
       ('2025-08-12', '영업3팀', '이은민', 150484, false, 10),
       ('2025-08-14', '영업3팀', '정석하', 131331, false, 38),
       ('2025-08-20', '영업3팀', '한석슬', 69025, false, 19),
       ('2025-08-31', '영업3팀', '이은민', 166115, false, 15),
       ('2025-09-14', '영업3팀', '한석슬', 194151, false, 33),
       ('2025-07-20', '영업3팀', '김슬민', 192488, false, 22),
       ('2025-09-15', '영업3팀', '김슬민', 79289, false, 38),
       ('2025-07-26', '영업3팀', '한석슬', 176777, false, 16),
       ('2025-09-06', '영업4팀', '정하슬', 127596, false, 26),
       ('2025-08-14', '영업4팀', '최주호', 65068, false, 11),
       ('2025-08-31', '영업4팀', '정하슬', 198759, false, 24);


INSERT INTO SALES (sales_date, department, employee_name, amount, is_deleted, contract_id)
VALUES ('2024-03-21', '영업1팀', '김성민', 159034, false, 39),
       ('2024-02-24', '영업1팀', '고윤석', 249774, false, 21),
       ('2024-02-12', '영업1팀', '고윤석', 166060, false, 6),
       ('2024-01-22', '영업1팀', '강수지', 209800, false, 33),
       ('2024-03-01', '영업1팀', '고성연', 149885, false, 23),
       ('2024-01-31', '영업1팀', '고성연', 217240, false, 7),
       ('2024-01-30', '영업1팀', '고성연', 124025, false, 16),
       ('2024-03-10', '영업1팀', '고성연', 122320, false, 34),
       ('2024-01-15', '영업1팀', '강수지', 170345, false, 21),
       ('2024-01-18', '영업1팀', '고윤석', 225657, false, 18),
       ('2024-02-25', '영업1팀', '고윤석', 136329, false, 34),
       ('2024-01-28', '영업1팀', '강수지', 204869, false, 23),
       ('2024-01-07', '영업1팀', '김성민', 199467, false, 11),
       ('2024-02-15', '영업1팀', '김성민', 203910, false, 19),
       ('2024-03-02', '영업1팀', '강수지', 226732, false, 46),
       ('2024-03-01', '영업1팀', '고성연', 194971, false, 37),
       ('2024-02-05', '영업2팀', '최은경', 59187, false, 50),
       ('2024-03-12', '영업2팀', '최민진', 114139, false, 37),
       ('2024-02-04', '영업2팀', '이주은', 52590, false, 11),
       ('2024-01-24', '영업2팀', '이주은', 195777, false, 42),
       ('2024-03-05', '영업2팀', '최은경', 64022, false, 30),
       ('2024-01-20', '영업2팀', '최은경', 188684, false, 42),
       ('2024-03-20', '영업2팀', '최민진', 115260, false, 28),
       ('2024-02-17', '영업2팀', '윤수수', 141117, false, 3),
       ('2024-03-05', '영업2팀', '윤수수', 113518, false, 27),
       ('2024-01-01', '영업2팀', '이주은', 170789, false, 45),
       ('2024-01-07', '영업3팀', '정석하', 152505, false, 27),
       ('2024-02-17', '영업3팀', '이은민', 102914, false, 44),
       ('2024-03-29', '영업3팀', '정석하', 194553, false, 36),
       ('2024-03-27', '영업3팀', '한석슬', 188121, false, 7),
       ('2024-03-10', '영업3팀', '이은민', 70232, false, 19),
       ('2024-03-12', '영업3팀', '한석슬', 82730, false, 38),
       ('2024-03-28', '영업3팀', '김슬민', 120242, false, 23),
       ('2024-01-25', '영업3팀', '정석하', 191792, false, 7),
       ('2024-03-16', '영업3팀', '정석하', 190807, false, 2),
       ('2024-01-24', '영업3팀', '김슬민', 130913, false, 10),
       ('2024-01-10', '영업4팀', '최주호', 193886, false, 5),
       ('2024-03-21', '영업4팀', '최주호', 169305, false, 47),
       ('2024-01-23', '영업4팀', '정하슬', 134332, false, 44),
       ('2024-02-26', '영업4팀', '이진하', 157136, false, 29),
       ('2024-02-08', '영업4팀', '장현우', 139442, false, 39),
       ('2024-01-12', '영업4팀', '이진하', 106277, false, 27),
       ('2024-02-13', '영업4팀', '장현우', 170820, false, 1),
       ('2024-03-27', '영업4팀', '정하슬', 134042, false, 25),
       ('2024-02-17', '영업4팀', '최주호', 185173, false, 18),
       ('2024-02-22', '영업4팀', '정하슬', 108370, false, 36),
       ('2024-01-22', '영업5팀', '김은수', 196697, false, 6),
       ('2024-01-01', '영업5팀', '한호은', 165028, false, 16),
       ('2024-02-19', '영업5팀', '김은수', 106238, false, 43),
       ('2024-01-13', '영업5팀', '한호은', 79852, false, 35),
       ('2024-02-25', '영업5팀', '한진경', 190246, false, 9),
       ('2024-01-02', '영업5팀', '한슬수', 170900, false, 25),
       ('2024-03-06', '영업5팀', '한호은', 134511, false, 20),
       ('2024-02-24', '영업5팀', '김은수', 117130, false, 22),
       ('2024-01-05', '영업5팀', '한슬수', 155733, false, 45),
       ('2024-02-09', '영업5팀', '한슬수', 128932, false, 40);

-- 24년 2분기
INSERT INTO SALES (sales_date, department, employee_name, amount, is_deleted, contract_id)
VALUES ('2024-04-11', '영업1팀', '고윤석', 236378, false, 7),
       ('2024-04-12', '영업1팀', '고성연', 126868, false, 40),
       ('2024-04-25', '영업1팀', '고윤석', 198912, false, 33),
       ('2024-06-09', '영업1팀', '고윤석', 135090, false, 50),
       ('2024-06-07', '영업1팀', '김성민', 186543, false, 40),
       ('2024-05-23', '영업1팀', '고윤석', 247835, false, 25),
       ('2024-06-12', '영업1팀', '고성연', 242407, false, 29),
       ('2024-04-12', '영업1팀', '강수지', 157706, false, 28),
       ('2024-05-23', '영업1팀', '강수지', 215075, false, 10),
       ('2024-04-27', '영업1팀', '고윤석', 227201, false, 34),
       ('2024-05-11', '영업1팀', '고윤석', 128536, false, 9),
       ('2024-06-03', '영업1팀', '김성민', 249404, false, 26),
       ('2024-04-25', '영업1팀', '강수지', 135831, false, 26),
       ('2024-05-29', '영업1팀', '강수지', 144443, false, 29),
       ('2024-04-12', '영업1팀', '강수지', 165327, false, 31),
       ('2024-05-24', '영업1팀', '김성민', 244453, false, 14),
       ('2024-05-15', '영업2팀', '윤수수', 56781, false, 39),
       ('2024-05-31', '영업2팀', '이주은', 187465, false, 9),
       ('2024-05-31', '영업2팀', '최은경', 116866, false, 40),
       ('2024-05-16', '영업2팀', '최민진', 61035, false, 21),
       ('2024-04-30', '영업2팀', '윤수수', 164326, false, 32),
       ('2024-06-13', '영업2팀', '최민진', 176328, false, 8),
       ('2024-05-02', '영업2팀', '최은경', 120929, false, 23),
       ('2024-05-11', '영업2팀', '최은경', 120512, false, 27),
       ('2024-04-17', '영업2팀', '최은경', 168814, false, 26),
       ('2024-06-20', '영업2팀', '최민진', 94471, false, 15),
       ('2024-05-05', '영업3팀', '한석슬', 99670, false, 10),
       ('2024-05-29', '영업3팀', '이은민', 183285, false, 18),
       ('2024-06-18', '영업3팀', '김슬민', 62827, false, 41),
       ('2024-06-15', '영업3팀', '한석슬', 87190, false, 5),
       ('2024-06-09', '영업3팀', '정석하', 111295, false, 14),
       ('2024-05-22', '영업3팀', '김슬민', 171895, false, 45),
       ('2024-06-24', '영업3팀', '정석하', 183449, false, 45),
       ('2024-04-13', '영업3팀', '정석하', 71834, false, 23),
       ('2024-05-03', '영업3팀', '이은민', 123816, false, 13),
       ('2024-04-18', '영업3팀', '김슬민', 119427, false, 16),
       ('2024-05-13', '영업4팀', '장현우', 56874, false, 23),
       ('2024-05-08', '영업4팀', '장현우', 129760, false, 21),
       ('2024-06-04', '영업4팀', '정하슬', 170658, false, 48),
       ('2024-06-03', '영업4팀', '정하슬', 149506, false, 16),
       ('2024-04-21', '영업4팀', '이진하', 194250, false, 28),
       ('2024-05-16', '영업4팀', '최주호', 113798, false, 5),
       ('2024-04-11', '영업4팀', '최주호', 141434, false, 33),
       ('2024-04-06', '영업4팀', '이진하', 146914, false, 34),
       ('2024-06-13', '영업4팀', '장현우', 68857, false, 4),
       ('2024-04-04', '영업5팀', '한호은', 171168, false, 14),
       ('2024-04-23', '영업5팀', '한호은', 182774, false, 25),
       ('2024-06-05', '영업5팀', '한슬수', 127367, false, 50),
       ('2024-06-03', '영업5팀', '한슬수', 130781, false, 13),
       ('2024-04-12', '영업5팀', '김은수', 157032, false, 8),
       ('2024-05-19', '영업5팀', '한진경', 137537, false, 36),
       ('2024-06-11', '영업5팀', '김은수', 131942, false, 30),
       ('2024-04-25', '영업5팀', '한슬수', 119671, false, 47),
       ('2024-05-12', '영업5팀', '한진경', 110867, false, 23),
       ('2024-06-12', '영업5팀', '김은수', 80844, false, 32);

-- 24년 3분기
INSERT INTO SALES (sales_date, department, employee_name, amount, is_deleted, contract_id)
VALUES ('2024-07-12', '영업1팀', '고성연', 123995, false, 12),
       ('2024-07-02', '영업1팀', '김성민', 160460, false, 33),
       ('2024-09-25', '영업1팀', '김성민', 152980, false, 25),
       ('2024-09-12', '영업1팀', '강수지', 190187, false, 9),
       ('2024-08-03', '영업1팀', '고성연', 199661, false, 49),
       ('2024-08-10', '영업1팀', '고성연', 165315, false, 44),
       ('2024-08-03', '영업1팀', '고윤석', 215738, false, 40),
       ('2024-09-30', '영업1팀', '고성연', 168836, false, 35),
       ('2024-08-14', '영업1팀', '고윤석', 228566, false, 15),
       ('2024-09-01', '영업1팀', '고윤석', 176352, false, 2),
       ('2024-07-15', '영업1팀', '고윤석', 171333, false, 41),
       ('2024-09-03', '영업1팀', '고성연', 136846, false, 42),
       ('2024-07-15', '영업1팀', '고성연', 185823, false, 28),
       ('2024-08-06', '영업1팀', '김성민', 175742, false, 19),
       ('2024-07-11', '영업1팀', '고윤석', 143952, false, 31),
       ('2024-09-27', '영업1팀', '김성민', 213473, false, 31),
       ('2024-07-03', '영업2팀', '윤수수', 184963, false, 19),
       ('2024-07-03', '영업2팀', '윤수수', 173501, false, 50),
       ('2024-08-03', '영업2팀', '이주은', 65868, false, 23),
       ('2024-09-28', '영업2팀', '최민진', 73055, false, 45),
       ('2024-09-01', '영업2팀', '최민진', 135273, false, 16),
       ('2024-07-31', '영업2팀', '최민진', 135454, false, 40),
       ('2024-09-09', '영업2팀', '이주은', 54659, false, 19),
       ('2024-09-04', '영업2팀', '최민진', 171058, false, 24),
       ('2024-08-20', '영업2팀', '이주은', 76657, false, 26),
       ('2024-08-29', '영업2팀', '최민진', 86699, false, 7),
       ('2024-09-23', '영업3팀', '한석슬', 64402, false, 15),
       ('2024-09-19', '영업3팀', '정석하', 184653, false, 5),
       ('2024-08-12', '영업3팀', '이은민', 150484, false, 10),
       ('2024-08-14', '영업3팀', '정석하', 131331, false, 38),
       ('2024-08-20', '영업3팀', '한석슬', 69025, false, 19),
       ('2024-08-31', '영업3팀', '이은민', 166115, false, 15),
       ('2024-09-14', '영업3팀', '한석슬', 194151, false, 33),
       ('2024-07-20', '영업3팀', '김슬민', 192488, false, 22),
       ('2024-09-15', '영업3팀', '김슬민', 79289, false, 38),
       ('2024-07-26', '영업3팀', '한석슬', 176777, false, 16),
       ('2024-09-06', '영업4팀', '정하슬', 127596, false, 26),
       ('2024-08-14', '영업4팀', '최주호', 65068, false, 11),
       ('2024-08-31', '영업4팀', '정하슬', 198759, false, 24),
       ('2024-08-08', '영업4팀', '이진하', 171277, false, 39),
       ('2024-07-05', '영업4팀', '이진하', 89306, false, 9),
       ('2024-07-30', '영업4팀', '최주호', 111546, false, 24),
       ('2024-09-13', '영업4팀', '이진하', 107943, false, 40),
       ('2024-09-10', '영업4팀', '최주호', 159429, false, 2),
       ('2024-08-13', '영업4팀', '정하슬', 193128, false, 37),
       ('2024-08-05', '영업5팀', '한슬수', 143886, false, 44),
       ('2024-09-10', '영업5팀', '김은수', 163968, false, 1),
       ('2024-07-17', '영업5팀', '김은수', 147036, false, 50),
       ('2024-09-01', '영업5팀', '한호은', 172689, false, 30),
       ('2024-08-19', '영업5팀', '한슬수', 161987, false, 27),
       ('2024-07-10', '영업5팀', '한진경', 179032, false, 5),
       ('2024-09-30', '영업5팀', '한슬수', 132137, false, 18),
       ('2024-08-03', '영업5팀', '한호은', 124628, false, 41),
       ('2024-07-04', '영업5팀', '한호은', 170142, false, 26),
       ('2024-08-10', '영업5팀', '김은수', 180320, false, 28);

-- 24년 4분기

INSERT INTO SALES (sales_date, department, employee_name, amount, is_deleted, contract_id)
VALUES ('2024-10-30', '영업1팀', '강수지', 202403, false, 28),
       ('2024-12-10', '영업1팀', '김성민', 189990, false, 27),
       ('2024-11-29', '영업1팀', '강수지', 158361, false, 30),
       ('2024-10-06', '영업1팀', '고윤석', 234637, false, 44),
       ('2024-10-04', '영업1팀', '고윤석', 248207, false, 50),
       ('2024-11-09', '영업1팀', '강수지', 216002, false, 4),
       ('2024-11-24', '영업1팀', '김성민', 127280, false, 33),
       ('2024-12-22', '영업1팀', '고성연', 149020, false, 11),
       ('2024-11-04', '영업1팀', '고성연', 163415, false, 43),
       ('2024-10-11', '영업1팀', '고윤석', 153877, false, 13),
       ('2024-12-18', '영업1팀', '강수지', 241939, false, 35),
       ('2024-10-07', '영업1팀', '김성민', 241276, false, 22),
       ('2024-11-18', '영업1팀', '강수지', 200087, false, 47),
       ('2024-10-19', '영업1팀', '고성연', 148507, false, 6),
       ('2024-12-10', '영업1팀', '고윤석', 214154, false, 45),
       ('2024-12-09', '영업1팀', '고성연', 130104, false, 46),
       ('2024-10-28', '영업2팀', '최민진', 119389, false, 12),
       ('2024-10-02', '영업2팀', '최민진', 193226, false, 38),
       ('2024-11-14', '영업2팀', '최민진', 159846, false, 30),
       ('2024-10-06', '영업2팀', '이주은', 100447, false, 11),
       ('2024-11-19', '영업2팀', '윤수수', 193889, false, 1),
       ('2024-12-19', '영업2팀', '최민진', 194650, false, 22),
       ('2024-10-04', '영업2팀', '이주은', 187637, false, 15),
       ('2024-10-06', '영업2팀', '이주은', 168455, false, 5),
       ('2024-10-08', '영업2팀', '최은경', 132059, false, 6),
       ('2024-10-12', '영업2팀', '최은경', 121207, false, 32),
       ('2024-10-21', '영업3팀', '정석하', 190601, false, 33),
       ('2024-11-01', '영업3팀', '김슬민', 177564, false, 5),
       ('2024-12-04', '영업3팀', '한석슬', 148676, false, 21),
       ('2024-12-17', '영업3팀', '한석슬', 66509, false, 26),
       ('2024-11-03', '영업3팀', '한석슬', 110307, false, 45),
       ('2024-10-09', '영업3팀', '이은민', 75271, false, 3),
       ('2024-12-03', '영업3팀', '김슬민', 167595, false, 15),
       ('2024-12-25', '영업3팀', '정석하', 163585, false, 19),
       ('2024-12-20', '영업3팀', '이은민', 136896, false, 31),
       ('2024-10-04', '영업3팀', '이은민', 135929, false, 8),
       ('2024-10-08', '영업4팀', '장현우', 150832, false, 6),
       ('2024-12-23', '영업4팀', '정하슬', 168671, false, 7),
       ('2024-12-12', '영업4팀', '이진하', 59865, false, 44),
       ('2024-11-17', '영업4팀', '최주호', 145679, false, 30),
       ('2024-10-18', '영업4팀', '정하슬', 92170, false, 18),
       ('2024-11-27', '영업4팀', '최주호', 157744, false, 40),
       ('2024-12-17', '영업4팀', '이진하', 181911, false, 29),
       ('2024-10-28', '영업4팀', '장현우', 93962, false, 10),
       ('2024-10-06', '영업4팀', '최주호', 153845, false, 13),
       ('2024-10-03', '영업5팀', '한슬수', 134939, false, 13),
       ('2024-11-28', '영업5팀', '김은수', 167446, false, 14),
       ('2024-10-06', '영업5팀', '한호은', 172379, false, 39),
       ('2024-12-21', '영업5팀', '한진경', 129382, false, 32),
       ('2024-11-21', '영업5팀', '한슬수', 188672, false, 9),
       ('2024-10-29', '영업5팀', '한호은', 93360, false, 3),
       ('2024-10-24', '영업5팀', '김은수', 115037, false, 19),
       ('2024-12-12', '영업5팀', '김은수', 85909, false, 15),
       ('2024-12-20', '영업5팀', '한진경', 59889, false, 47),
       ('2024-12-12', '영업5팀', '한호은', 139033, false, 46);

-- CONTRACT_PRODUCT
INSERT INTO CONTRACT_PRODUCT (id, quantity, contract_id, product_id)
VALUES (1, 4, 1, 1),
       (2, 3, 2, 2),
       (3, 5, 3, 3),
       (4, 4, 4, 4),
       (5, 2, 5, 5),
       (6, 1, 6, 6),
       (7, 5, 7, 7);

-- EMPLOYEE_GOAL
# INSERT INTO EMPLOYEE_GOAL (rental_product_count, rental_retention_count, total_rental_count, new_customer_count,
#                            total_rental_amount, customer_feedback_score, customer_feedback_count, target_date,
#                            employee_id)
# VALUES (1, 86, 101, 5, 1200000, 220.0, 51, 202401, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202402, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202403, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202404, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202405, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202406, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202407, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202408, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202409, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202410, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202411, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202412, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202501, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202502, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202503, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202504, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202505, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202506, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202507, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202508, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202509, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202510, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202511, 2),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202512, 2),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202401, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202402, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202403, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202404, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202405, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202406, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202407, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202408, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202409, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202410, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202411, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202412, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202501, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202502, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202503, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202504, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202505, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202506, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202507, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202508, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202509, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202510, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202511, 3),
#        (1, 86, 101, 5, 1200000, 205.0, 51, 202512, 3),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202401, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202402, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202403, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202404, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202405, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202406, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202407, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202408, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202409, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202410, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202411, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202412, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202501, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202502, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202503, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202504, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202505, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202506, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202507, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202508, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202509, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202510, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202511, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202512, 4),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202401, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202402, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202403, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202404, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202405, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202406, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202407, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202408, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202409, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202410, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202411, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202412, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202501, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202502, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202503, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202504, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202505, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202506, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202507, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202508, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202509, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202510, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202511, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202512, 5),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202401, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202402, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202403, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202404, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202405, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202406, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202407, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202408, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202409, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202410, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202411, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202412, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202501, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202502, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202503, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202504, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202505, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202506, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202507, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202508, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202509, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202510, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202511, 6),
#        (1, 86, 101, 5, 1200000, 220.0, 51, 202512, 6);

-- DEFAULT_GOAL
INSERT INTO DEFAULT_GOAL (level, rental_product_count, rental_retention_rate, new_customer_count,
                          total_rental_amount, customer_feedback_score, target_year)
VALUES ('사원', 6, 85, 4, 1250000, 4.3, 2025),
       ('사원', 6, 85, 4, 1250000, 4.3, 2024),
       ('사원', 6, 85, 4, 1250000, 4.3, 2023),
       ('사원', 6, 85, 4, 1250000, 4.3, 2022),
       ('사원', 6, 85, 4, 1250000, 4.3, 2021),
       ('사원', 6, 85, 4, 1250000, 4.3, 2020),
       ('사원', 6, 85, 4, 1250000, 4.3, 2019),
       ('주임', 7, 85, 5, 1300000, 4.0, 2025),
       ('주임', 7, 85, 5, 1300000, 4.0, 2024),
       ('주임', 7, 85, 5, 1300000, 4.0, 2023),
       ('주임', 7, 85, 5, 1300000, 4.0, 2022),
       ('주임', 7, 85, 5, 1300000, 4.0, 2021),
       ('주임', 7, 85, 5, 1300000, 4.0, 2020),
       ('주임', 7, 85, 5, 1300000, 4.0, 2019),
       ('대리', 8, 85, 6, 1350000, 4.3, 2025),
       ('대리', 8, 85, 6, 1350000, 4.3, 2024),
       ('대리', 8, 85, 6, 1350000, 4.3, 2023),
       ('대리', 8, 85, 6, 1350000, 4.3, 2022),
       ('대리', 8, 85, 6, 1350000, 4.3, 2021),
       ('대리', 8, 85, 6, 1350000, 4.3, 2020),
       ('대리', 8, 85, 6, 1350000, 4.3, 2019),
       ('과장', 9, 85, 7, 1400000, 4.0, 2025),
       ('과장', 9, 85, 7, 1400000, 4.0, 2024),
       ('과장', 9, 85, 7, 1400000, 4.0, 2023),
       ('과장', 9, 85, 7, 1400000, 4.0, 2022),
       ('과장', 9, 85, 7, 1400000, 4.0, 2021),
       ('과장', 9, 85, 7, 1400000, 4.0, 2020),
       ('과장', 9, 85, 7, 1400000, 4.0, 2019),
       ('팀장', 10, 85, 8, 1450000, 4.3, 2025),
       ('팀장', 10, 85, 8, 1450000, 4.3, 2024),
       ('팀장', 10, 85, 8, 1450000, 4.3, 2023),
       ('팀장', 10, 85, 8, 1450000, 4.3, 2022),
       ('팀장', 10, 85, 8, 1450000, 4.3, 2021),
       ('팀장', 10, 85, 8, 1450000, 4.3, 2020),
       ('팀장', 10, 85, 8, 1450000, 4.3, 2019);

-- EMPLOYEE_NOTICE
INSERT INTO EMPLOYEE_NOTICE (notice_id, employee_id, is_checked)
VALUES
    (1, 9, FALSE),
    (1, 6, FALSE),
    (1, 90, FALSE),
    (1, 16, FALSE),
    (1, 138, FALSE),
    (1, 13, FALSE),
    (1, 78, FALSE),
    (1, 8, FALSE),
    (1, 10, FALSE),
    (1, 101, FALSE),
    (2, 148, FALSE),
    (2, 9, FALSE),
    (2, 111, FALSE),
    (2, 109, FALSE),
    (2, 53, FALSE),
    (3, 141, FALSE),
    (3, 111, FALSE),
    (3, 6, FALSE),
    (3, 146, FALSE),
    (3, 122, FALSE),
    (3, 67, FALSE),
    (3, 10, FALSE),
    (3, 8, FALSE),
    (3, 20, FALSE),
    (4, 51, FALSE),
    (4, 139, FALSE),
    (4, 7, FALSE),
    (4, 8, FALSE),
    (4, 115, FALSE),
    (4, 6, FALSE),
    (5, 8, FALSE),
    (5, 79, FALSE),
    (5, 6, FALSE),
    (5, 104, FALSE),
    (5, 131, FALSE),
    (5, 135, FALSE),
    (5, 9, FALSE),
    (5, 10, FALSE),
    (5, 89, FALSE),
    (5, 7, FALSE),
    (6, 120, FALSE),
    (6, 139, FALSE),
    (6, 6, FALSE),
    (6, 12, FALSE),
    (6, 33, FALSE),
    (6, 7, FALSE),
    (6, 10, FALSE),
    (6, 68, FALSE),
    (7, 63, FALSE),
    (7, 51, FALSE),
    (7, 147, FALSE),
    (7, 136, FALSE),
    (7, 35, FALSE),
    (7, 100, FALSE),
    (7, 7, FALSE),
    (7, 10, FALSE),
    (8, 112, FALSE),
    (8, 9, FALSE),
    (8, 8, FALSE),
    (8, 134, FALSE),
    (8, 8, FALSE),
    (8, 10, FALSE),
    (8, 6, FALSE),
    (9, 8, FALSE),
    (9, 23, FALSE),
    (9, 34, FALSE),
    (9, 50, FALSE),
    (9, 71, FALSE),
    (9, 32, FALSE),
    (9, 24, FALSE),
    (9, 123, FALSE),
    (9, 103, FALSE),
    (9, 15, FALSE),
    (10, 73, FALSE),
    (10, 59, FALSE),
    (10, 10, FALSE),
    (10, 6, FALSE),
    (10, 96, FALSE),
    (10, 71, FALSE),
    (10, 133, FALSE),
    (10, 9, FALSE),
    (10, 8, FALSE),
    (11, 7, FALSE),
    (11, 115, FALSE),
    (11, 101, FALSE),
    (11, 129, FALSE),
    (11, 105, FALSE),
    (11, 21, FALSE),
    (11, 10, FALSE),
    (11, 94, FALSE),
    (11, 11, FALSE),
    (11, 42, FALSE),
    (12, 8, FALSE),
    (12, 129, FALSE),
    (12, 35, FALSE),
    (12, 59, FALSE),
    (12, 50, FALSE),
    (12, 120, FALSE),
    (12, 10, FALSE),
    (12, 9, FALSE),
    (12, 88, FALSE),
    (12, 7, FALSE),
    (13, 52, FALSE),
    (13, 113, FALSE),
    (13, 7, FALSE),
    (13, 28, FALSE),
    (13, 122, FALSE),
    (13, 93, FALSE),
    (13, 26, FALSE),
    (14, 66, FALSE),
    (14, 7, FALSE),
    (14, 9, FALSE),
    (14, 38, FALSE),
    (14, 61, FALSE),
    (14, 40, FALSE),
    (14, 6, FALSE),
    (14, 34, FALSE),
    (14, 75, FALSE),
    (15, 7, FALSE),
    (15, 90, FALSE),
    (15, 9, FALSE),
    (15, 38, FALSE),
    (15, 22, FALSE),
    (15, 108, FALSE),
    (15, 6, FALSE),
    (16, 6, FALSE),
    (16, 133, FALSE),
    (16, 134, FALSE),
    (16, 44, FALSE),
    (16, 9, FALSE),
    (16, 126, FALSE),
    (17, 63, FALSE),
    (17, 6, FALSE),
    (17, 8, FALSE),
    (17, 12, FALSE),
    (17, 9, FALSE),
    (17, 137, FALSE),
    (18, 58, FALSE),
    (18, 62, FALSE),
    (18, 123, FALSE),
    (18, 25, FALSE),
    (18, 95, FALSE),
    (18, 24, FALSE),
    (18, 9, FALSE),
    (18, 7, FALSE),
    (19, 83, FALSE),
    (19, 144, FALSE),
    (19, 11, FALSE),
    (19, 68, FALSE),
    (19, 7, FALSE),
    (20, 114, FALSE),
    (20, 38, FALSE),
    (20, 6, FALSE),
    (20, 8, FALSE),
    (20, 111, FALSE),
    (21, 9, FALSE),
    (21, 93, FALSE),
    (21, 72, FALSE),
    (21, 7, FALSE),
    (21, 10, FALSE),
    (21, 8, FALSE),
    (21, 20, FALSE),
    (21, 19, FALSE),
    (21, 95, FALSE),
    (21, 49, FALSE),
    (22, 36, FALSE),
    (22, 92, FALSE),
    (22, 61, FALSE),
    (22, 10, FALSE),
    (22, 94, FALSE),
    (23, 9, FALSE),
    (23, 45, FALSE),
    (23, 11, FALSE),
    (23, 6, FALSE),
    (23, 49, FALSE),
    (23, 8, FALSE),
    (23, 136, FALSE),
    (24, 79, FALSE),
    (24, 133, FALSE),
    (24, 22, FALSE),
    (24, 9, FALSE),
    (24, 17, FALSE),
    (24, 7, FALSE),
    (24, 68, FALSE),
    (24, 10, FALSE),
    (24, 141, FALSE),
    (25, 130, FALSE),
    (25, 142, FALSE),
    (25, 106, FALSE),
    (25, 107, FALSE),
    (25, 87, FALSE),
    (25, 9, FALSE),
    (25, 59, FALSE),
    (26, 6, FALSE),
    (26, 88, FALSE),
    (26, 7, FALSE),
    (26, 8, FALSE),
    (26, 85, FALSE),
    (27, 8, FALSE),
    (27, 9, FALSE),
    (27, 27, FALSE),
    (27, 120, FALSE),
    (27, 132, FALSE),
    (27, 6, FALSE),
    (27, 92, FALSE),
    (27, 138, FALSE),
    (27, 124, FALSE),
    (28, 146, FALSE),
    (28, 8, FALSE),
    (28, 96, FALSE),
    (28, 81, FALSE),
    (28, 58, FALSE),
    (28, 43, FALSE),
    (28, 10, FALSE),
    (28, 6, FALSE),
    (28, 7, FALSE),
    (29, 7, FALSE),
    (29, 55, FALSE),
    (29, 145, FALSE),
    (29, 94, FALSE),
    (29, 8, FALSE),
    (29, 9, FALSE),
    (29, 23, FALSE),
    (30, 61, FALSE),
    (30, 6, FALSE),
    (30, 9, FALSE),
    (30, 33, FALSE),
    (30, 150, FALSE),
    (30, 148, FALSE),
    (30, 8, FALSE),
    (31, 9, FALSE),
    (31, 6, FALSE),
    (31, 55, FALSE),
    (31, 75, FALSE),
    (31, 108, FALSE),
    (31, 53, FALSE),
    (31, 81, FALSE),
    (31, 74, FALSE),
    (31, 7, FALSE),
    (31, 23, FALSE),
    (32, 131, FALSE),
    (32, 16, FALSE),
    (32, 12, FALSE),
    (32, 18, FALSE),
    (32, 8, FALSE),
    (32, 23, FALSE),
    (32, 36, FALSE),
    (32, 60, FALSE),
    (32, 50, FALSE),
    (32, 78, FALSE),
    (33, 8, FALSE),
    (33, 41, FALSE),
    (33, 145, FALSE),
    (33, 29, FALSE),
    (33, 27, FALSE),
    (33, 81, FALSE),
    (33, 6, FALSE),
    (34, 148, FALSE),
    (34, 64, FALSE),
    (34, 9, FALSE),
    (34, 100, FALSE),
    (34, 48, FALSE),
    (34, 75, FALSE),
    (34, 139, FALSE),
    (34, 19, FALSE),
    (34, 8, FALSE),
    (34, 7, FALSE),
    (35, 61, FALSE),
    (35, 22, FALSE),
    (35, 134, FALSE),
    (35, 10, FALSE),
    (35, 92, FALSE),
    (35, 9, FALSE),
    (36, 137, FALSE),
    (36, 114, FALSE),
    (36, 74, FALSE),
    (36, 24, FALSE),
    (36, 117, FALSE),
    (36, 15, FALSE),
    (36, 79, FALSE),
    (36, 101, FALSE),
    (36, 129, FALSE),
    (36, 97, FALSE),
    (36, 91, FALSE),
    (36, 104, FALSE),
    (36, 82, FALSE),
    (36, 125, FALSE),
    (36, 48, FALSE),
    (36, 50, FALSE),
    (37, 6, FALSE),
    (37, 62, FALSE),
    (37, 30, FALSE),
    (37, 73, FALSE),
    (37, 43, FALSE),
    (37, 66, FALSE),
    (37, 92, FALSE),
    (37, 65, FALSE),
    (37, 121, FALSE),
    (37, 132, FALSE),
    (37, 78, FALSE),
    (37, 46, FALSE),
    (37, 111, FALSE),
    (37, 95, FALSE),
    (37, 70, FALSE),
    (37, 91, FALSE),
    (38, 39, FALSE),
    (38, 60, FALSE),
    (38, 141, FALSE),
    (38, 94, FALSE),
    (38, 148, FALSE),
    (38, 48, FALSE),
    (38, 139, FALSE),
    (38, 73, FALSE),
    (38, 22, FALSE),
    (38, 9, FALSE),
    (38, 31, FALSE),
    (38, 62, FALSE),
    (38, 82, FALSE),
    (38, 46, FALSE),
    (38, 104, FALSE),
    (38, 79, FALSE),
    (38, 29, FALSE),
    (38, 110, FALSE),
    (38, 125, FALSE),
    (38, 41, FALSE),
    (38, 121, FALSE),
    (39, 140, FALSE),
    (39, 30, FALSE),
    (39, 18, FALSE),
    (39, 113, FALSE),
    (39, 44, FALSE),
    (39, 71, FALSE),
    (39, 47, FALSE),
    (39, 29, FALSE),
    (39, 128, FALSE),
    (39, 6, FALSE),
    (39, 135, FALSE),
    (39, 104, FALSE),
    (39, 37, FALSE),
    (39, 7, FALSE),
    (39, 99, FALSE),
    (39, 49, FALSE),
    (39, 146, FALSE),
    (39, 61, FALSE),
    (40, 15, FALSE),
    (40, 81, FALSE),
    (40, 47, FALSE),
    (40, 20, FALSE),
    (40, 126, FALSE),
    (40, 148, FALSE),
    (40, 106, FALSE),
    (40, 110, FALSE),
    (40, 94, FALSE),
    (40, 25, FALSE),
    (40, 43, FALSE),
    (40, 70, FALSE),
    (40, 14, FALSE),
    (40, 22, FALSE),
    (40, 139, FALSE),
    (40, 51, FALSE),
    (40, 144, FALSE),
    (40, 105, FALSE),
    (40, 93, FALSE),
    (40, 16, FALSE),
    (41, 48, FALSE),
    (41, 70, FALSE),
    (41, 100, FALSE),
    (41, 13, FALSE),
    (41, 35, FALSE),
    (41, 26, FALSE),
    (41, 80, FALSE),
    (41, 127, FALSE),
    (41, 111, FALSE),
    (41, 103, FALSE),
    (41, 139, FALSE),
    (41, 86, FALSE),
    (41, 64, FALSE),
    (41, 123, FALSE),
    (41, 39, FALSE),
    (41, 43, FALSE),
    (41, 46, FALSE),
    (41, 54, FALSE),
    (41, 77, FALSE),
    (41, 83, FALSE),
    (41, 129, FALSE),
    (41, 33, FALSE),
    (41, 28, FALSE),
    (41, 121, FALSE),
    (41, 150, FALSE),
    (42, 100, FALSE),
    (42, 59, FALSE),
    (42, 94, FALSE),
    (42, 35, FALSE),
    (42, 130, FALSE),
    (42, 52, FALSE),
    (42, 103, FALSE),
    (42, 76, FALSE),
    (42, 127, FALSE),
    (42, 145, FALSE),
    (42, 148, FALSE),
    (42, 20, FALSE),
    (42, 63, FALSE),
    (42, 31, FALSE),
    (42, 12, FALSE),
    (43, 85, FALSE),
    (43, 121, FALSE),
    (43, 11, FALSE),
    (43, 96, FALSE),
    (43, 59, FALSE),
    (43, 23, FALSE),
    (43, 88, FALSE),
    (43, 128, FALSE),
    (43, 21, FALSE),
    (43, 53, FALSE),
    (43, 55, FALSE),
    (43, 123, FALSE),
    (43, 66, FALSE),
    (43, 37, FALSE),
    (43, 67, FALSE),
    (43, 135, FALSE),
    (43, 26, FALSE),
    (43, 75, FALSE),
    (43, 61, FALSE),
    (43, 147, FALSE),
    (43, 12, FALSE),
    (44, 121, FALSE),
    (44, 12, FALSE),
    (44, 58, FALSE),
    (44, 118, FALSE),
    (44, 31, FALSE),
    (44, 109, FALSE),
    (44, 112, FALSE),
    (44, 96, FALSE),
    (44, 92, FALSE),
    (44, 62, FALSE),
    (44, 91, FALSE),
    (44, 36, FALSE),
    (44, 144, FALSE),
    (44, 107, FALSE),
    (44, 125, FALSE),
    (44, 67, FALSE),
    (44, 35, FALSE),
    (45, 25, FALSE),
    (45, 40, FALSE),
    (45, 56, FALSE),
    (45, 124, FALSE),
    (45, 144, FALSE),
    (45, 94, FALSE),
    (45, 76, FALSE),
    (45, 117, FALSE),
    (45, 64, FALSE),
    (45, 130, FALSE),
    (45, 53, FALSE),
    (45, 54, FALSE),
    (45, 39, FALSE),
    (45, 104, FALSE),
    (45, 26, FALSE),
    (45, 37, FALSE),
    (45, 143, FALSE),
    (45, 79, FALSE),
    (45, 125, FALSE),
    (45, 102, FALSE),
    (45, 146, FALSE),
    (46, 63, FALSE),
    (46, 123, FALSE),
    (46, 138, FALSE),
    (46, 15, FALSE),
    (46, 23, FALSE),
    (46, 100, FALSE),
    (46, 13, FALSE),
    (46, 120, FALSE),
    (46, 90, FALSE),
    (46, 74, FALSE),
    (46, 107, FALSE),
    (46, 87, FALSE),
    (46, 113, FALSE),
    (46, 96, FALSE),
    (46, 145, FALSE),
    (46, 25, FALSE),
    (46, 104, FALSE),
    (46, 52, FALSE),
    (46, 51, FALSE),
    (46, 143, FALSE),
    (46, 31, FALSE),
    (46, 109, FALSE),
    (46, 86, FALSE),
    (47, 12, FALSE),
    (47, 36, FALSE),
    (47, 91, FALSE),
    (47, 15, FALSE),
    (47, 29, FALSE),
    (47, 93, FALSE),
    (47, 75, FALSE),
    (47, 53, FALSE),
    (47, 143, FALSE),
    (47, 145, FALSE),
    (47, 26, FALSE),
    (47, 56, FALSE),
    (47, 70, FALSE),
    (47, 9, FALSE),
    (47, 148, FALSE),
    (47, 104, FALSE),
    (47, 21, FALSE),
    (48, 105, FALSE),
    (48, 146, FALSE),
    (48, 66, FALSE),
    (48, 145, FALSE),
    (48, 143, FALSE),
    (48, 111, FALSE),
    (48, 110, FALSE),
    (48, 118, FALSE),
    (48, 96, FALSE),
    (48, 29, FALSE),
    (48, 103, FALSE),
    (48, 12, FALSE),
    (48, 77, FALSE),
    (48, 106, FALSE),
    (48, 144, FALSE),
    (48, 45, FALSE),
    (48, 149, FALSE),
    (48, 87, FALSE),
    (48, 140, FALSE),
    (49, 8, FALSE),
    (49, 114, FALSE),
    (49, 145, FALSE),
    (49, 87, FALSE),
    (49, 24, FALSE),
    (49, 16, FALSE),
    (49, 146, FALSE),
    (49, 85, FALSE),
    (49, 69, FALSE),
    (49, 48, FALSE),
    (49, 111, FALSE),
    (49, 147, FALSE),
    (49, 126, FALSE),
    (49, 26, FALSE),
    (49, 100, FALSE),
    (49, 80, FALSE),
    (49, 28, FALSE),
    (49, 90, FALSE),
    (49, 65, FALSE),
    (49, 137, FALSE),
    (49, 47, FALSE),
    (50, 55, FALSE),
    (50, 39, FALSE),
    (50, 111, FALSE),
    (50, 101, FALSE),
    (50, 132, FALSE),
    (50, 110, FALSE),
    (50, 95, FALSE),
    (50, 133, FALSE),
    (50, 53, FALSE),
    (50, 118, FALSE),
    (50, 122, FALSE),
    (50, 91, FALSE),
    (50, 120, FALSE),
    (50, 148, FALSE),
    (50, 69, FALSE),
    (50, 26, FALSE),
    (50, 61, FALSE),
    (50, 136, FALSE),
    (50, 70, FALSE),
    (50, 38, FALSE),
    (50, 47, FALSE);

-- DEPARTMENT_PERFORMANCE
INSERT INTO DEPARTMENT_PERFORMANCE (id, rental_product_count, rental_retention_count, total_rental_count,
                                    new_customer_count,
                                    total_rental_amount, customer_feedback_score, customer_feedback_count, target_date,
                                    department_id)
VALUES (1, 6, 81, 100, 4, 1100000, 4.5, 50, 202405, 1),
       (2, 7, 82, 101, 5, 1200000, 4.0, 51, 202405, 2),
       (3, 8, 83, 102, 6, 1300000, 4.5, 52, 202405, 3),
       (4, 9, 84, 103, 7, 1400000, 4.0, 53, 202405, 4),
       (5, 10, 85, 104, 8, 1500000, 4.5, 54, 202405, 5),
       (6, 11, 86, 105, 9, 1600000, 4.0, 55, 202405, 6),
       (7, 12, 87, 106, 10, 1700000, 4.5, 56, 202405, 7);

-- EMPLOYEE_PERFORMANCE
# INSERT INTO EMPLOYEE_PERFORMANCE (id, rental_product_count, rental_retention_count, total_rental_count,
#                                   new_customer_count,
#                                   total_rental_amount, customer_feedback_score, customer_feedback_count, target_date,
#                                   employee_id)
# VALUES (1, 6, 81, 100, 4, 1100000, 4.5, 50, 202405, 1),
#        (2, 7, 82, 101, 5, 1200000, 4.0, 51, 202405, 2),
#        (3, 8, 83, 102, 6, 1300000, 4.5, 52, 202405, 3),
#        (4, 9, 84, 103, 7, 1400000, 4.0, 53, 202405, 4),
#        (5, 10, 85, 104, 8, 1500000, 4.5, 54, 202405, 5),
#        (6, 11, 86, 105, 9, 1600000, 4.0, 55, 202405, 6),
#        (7, 12, 87, 106, 10, 1700000, 4.5, 56, 202405, 7);

-- 알림 더미 데이터 (결재 알림)
# INSERT INTO NOTIFICATION (type, content, created_at, url, is_read, is_deleted, employee_id)
# VALUES
#     ('APPROVAL', '[결재 요청] A-2506-0001 계약에 대한 승인을 요청했습니다.', NOW(), 'http://www.naver.com', FALSE, FALSE, 1),
#     ('APPROVAL', '[결재 요청] A-2506-0002 계약에 대한 승인을 요청했습니다.', NOW(), 'http://www.naver.com', FALSE, FALSE, 1),
#     ('APPROVAL', '[결재 요청] A-2506-0003 계약에 대한 승인을 요청받았습니다.', NOW(), 'http://www.naver.com', FALSE, FALSE, 5);

-- Inserts for employee_performance
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (12, 76, 62, 3, 759041, 138, 44, 201901, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (59, 80, 72, 4, 729113, 460, 35, 201902, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (21, 15, 92, 40, 319094, 386, 25, 201903, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (75, 32, 25, 1, 487365, 132, 1, 201904, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (24, 18, 100, 32, 638768, 484, 95, 201905, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (11, 68, 67, 40, 622894, 420, 68, 201906, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (0, 62, 65, 9, 554417, 370, 58, 201907, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (21, 21, 25, 2, 774539, 299, 81, 201908, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (88, 5, 26, 27, 528991, 293, 59, 201909, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (91, 51, 84, 24, 885009, 438, 99, 201910, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (29, 48, 54, 7, 374313, 174, 14, 201911, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (43, 5, 28, 31, 780026, 219, 31, 201912, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (76, 22, 51, 49, 832194, 97, 67, 202001, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (46, 26, 4, 28, 456675, 231, 43, 202002, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (15, 38, 62, 5, 344868, 340, 84, 202003, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (46, 80, 39, 30, 532636, 136, 18, 202004, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (17, 23, 19, 7, 167566, 212, 58, 202005, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (76, 32, 6, 47, 246514, 173, 34, 202006, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (12, 51, 78, 29, 99767, 71, 89, 202007, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 0, 76, 3, 540147, 50, 94, 202008, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 74, 55, 48, 174530, 493, 31, 202009, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 7, 98, 15, 669149, 6, 39, 202010, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (85, 0, 8, 18, 50235, 260, 90, 202011, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (47, 65, 62, 35, 610664, 58, 73, 202012, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (16, 71, 14, 46, 131585, 487, 38, 202101, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (0, 21, 10, 15, 729202, 479, 85, 202102, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (68, 38, 75, 21, 123705, 68, 68, 202103, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (58, 77, 45, 0, 960078, 114, 15, 202104, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (9, 25, 53, 37, 571433, 364, 20, 202105, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (88, 15, 79, 43, 712164, 374, 57, 202106, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (24, 11, 11, 47, 631077, 68, 66, 202107, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (89, 12, 69, 13, 265367, 318, 37, 202108, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (96, 63, 34, 20, 556597, 21, 57, 202109, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (54, 56, 98, 36, 586512, 100, 99, 202110, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (13, 28, 17, 32, 210433, 251, 69, 202111, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (35, 18, 23, 17, 676514, 237, 82, 202112, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (82, 41, 54, 37, 652133, 19, 99, 202201, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 27, 9, 49, 58143, 73, 78, 202202, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (60, 63, 67, 4, 11033, 270, 100, 202203, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (8, 18, 79, 35, 648790, 370, 50, 202204, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (31, 76, 72, 17, 313512, 419, 43, 202205, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 62, 77, 36, 775744, 185, 49, 202206, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (8, 17, 48, 31, 598716, 95, 17, 202207, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 42, 80, 23, 846215, 43, 40, 202208, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (60, 58, 93, 2, 284800, 212, 97, 202209, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (99, 17, 66, 19, 596186, 194, 79, 202210, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (46, 58, 73, 38, 745732, 305, 79, 202211, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (11, 40, 28, 24, 758270, 290, 15, 202212, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 36, 32, 38, 148025, 491, 48, 202301, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (13, 20, 51, 23, 908153, 307, 57, 202302, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 34, 20, 50, 154065, 211, 70, 202303, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (28, 45, 96, 29, 359623, 33, 96, 202304, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (85, 75, 55, 15, 92139, 352, 23, 202305, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (58, 14, 93, 29, 305493, 245, 82, 202306, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 6, 74, 18, 169720, 151, 77, 202307, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (9, 58, 72, 14, 246452, 480, 68, 202308, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 20, 94, 11, 360002, 154, 39, 202309, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (19, 79, 98, 50, 298996, 24, 23, 202310, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (50, 41, 89, 27, 762988, 376, 12, 202311, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (93, 77, 13, 39, 528741, 178, 58, 202312, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (76, 47, 48, 50, 855631, 243, 98, 202401, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (31, 45, 29, 36, 970175, 242, 75, 202402, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 73, 64, 18, 591376, 372, 11, 202403, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (98, 44, 8, 12, 915540, 258, 70, 202404, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (66, 74, 60, 39, 62558, 298, 52, 202405, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (22, 26, 7, 6, 224077, 204, 37, 202406, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (79, 34, 48, 19, 467571, 59, 11, 202407, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (83, 22, 74, 14, 407233, 451, 60, 202408, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (66, 47, 41, 4, 282510, 281, 91, 202409, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (38, 35, 67, 9, 185846, 12, 62, 202410, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 40, 43, 24, 18291, 260, 0, 202411, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (94, 11, 32, 42, 212900, 61, 0, 202412, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 38, 82, 36, 976984, 123, 93, 202501, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (1, 39, 77, 11, 978553, 83, 16, 202502, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (93, 39, 92, 50, 860530, 369, 70, 202503, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (61, 66, 58, 28, 649402, 324, 90, 202504, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (97, 78, 13, 19, 806336, 286, 30, 202505, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 33, 67, 19, 306958, 275, 20, 202506, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (59, 66, 54, 25, 418707, 325, 34, 202507, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (26, 65, 95, 10, 653120, 319, 91, 202508, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (76, 68, 72, 35, 143787, 162, 97, 202509, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (18, 2, 33, 14, 719242, 279, 75, 202510, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 38, 3, 32, 9567, 49, 63, 202511, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 58, 51, 34, 612089, 37, 9, 202512, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (13, 39, 90, 22, 691807, 47, 93, 202601, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (31, 42, 50, 20, 651653, 126, 69, 202602, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 68, 34, 4, 923813, 313, 34, 202603, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (24, 23, 74, 21, 592531, 324, 89, 202604, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (80, 62, 12, 40, 749144, 333, 28, 202605, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (7, 11, 49, 2, 910950, 135, 39, 202606, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (51, 23, 68, 38, 38007, 94, 38, 202607, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (30, 78, 2, 10, 211146, 319, 20, 202608, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (10, 27, 90, 46, 585942, 455, 98, 202609, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (60, 52, 19, 32, 601621, 298, 76, 202610, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (86, 74, 48, 6, 682791, 163, 20, 202611, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (31, 66, 68, 12, 153993, 224, 74, 202612, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (66, 33, 66, 43, 68011, 148, 4, 202701, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (52, 56, 19, 12, 402068, 87, 22, 202702, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (38, 80, 6, 40, 516273, 108, 3, 202703, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (9, 59, 40, 38, 465693, 488, 46, 202704, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (17, 24, 73, 50, 929252, 348, 38, 202705, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 32, 53, 13, 287452, 430, 38, 202706, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 7, 57, 3, 669164, 206, 56, 202707, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (51, 74, 42, 23, 652281, 313, 49, 202708, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (74, 57, 71, 8, 742310, 258, 96, 202709, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 71, 55, 13, 518859, 441, 45, 202710, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (22, 46, 94, 45, 534440, 436, 74, 202711, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 62, 41, 27, 305477, 453, 70, 202712, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (14, 75, 91, 43, 753646, 441, 96, 202801, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (41, 57, 63, 44, 859669, 14, 2, 202802, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (69, 48, 96, 50, 252775, 118, 66, 202803, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (52, 60, 85, 45, 737274, 83, 98, 202804, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (66, 55, 31, 13, 949457, 253, 46, 202805, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (15, 64, 43, 29, 267750, 200, 5, 202806, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (31, 54, 10, 12, 383380, 1, 8, 202807, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (49, 79, 73, 10, 465822, 389, 90, 202808, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (43, 29, 61, 26, 313282, 80, 19, 202809, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 10, 30, 46, 64433, 12, 35, 202810, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (54, 51, 96, 2, 213043, 309, 27, 202811, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (32, 67, 81, 18, 621816, 64, 42, 202812, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (57, 9, 42, 18, 55775, 241, 2, 202901, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (60, 16, 64, 7, 7969, 313, 26, 202902, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (70, 41, 0, 33, 589698, 495, 78, 202903, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (91, 67, 1, 37, 296692, 327, 44, 202904, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (46, 1, 52, 47, 24106, 70, 15, 202905, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (37, 14, 60, 37, 596545, 488, 53, 202906, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (39, 72, 39, 38, 738534, 370, 38, 202907, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (27, 4, 41, 28, 943453, 67, 87, 202908, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (39, 72, 3, 50, 882208, 96, 65, 202909, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 15, 19, 0, 105251, 239, 63, 202910, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (43, 54, 11, 35, 330300, 273, 47, 202911, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (29, 27, 43, 23, 644106, 123, 14, 202912, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 59, 99, 7, 520163, 273, 35, 203001, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (41, 71, 11, 19, 502355, 442, 0, 203002, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (18, 60, 76, 31, 976602, 465, 56, 203003, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (24, 56, 98, 24, 758101, 495, 48, 203004, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (40, 12, 64, 36, 863049, 65, 10, 203005, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (5, 24, 90, 2, 166520, 250, 52, 203006, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (34, 66, 57, 6, 624671, 201, 84, 203007, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (57, 63, 17, 3, 330332, 73, 57, 203008, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (86, 13, 89, 50, 979176, 436, 78, 203009, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (35, 52, 17, 40, 532293, 33, 78, 203010, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (34, 23, 38, 15, 639839, 228, 67, 203011, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (16, 69, 51, 2, 875648, 282, 73, 203012, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (71, 55, 59, 33, 565650, 242, 67, 203101, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (20, 69, 87, 11, 270663, 434, 20, 203102, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 2, 15, 8, 745011, 27, 27, 203103, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (17, 37, 44, 28, 193295, 466, 90, 203104, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (32, 46, 45, 44, 248912, 220, 12, 203105, 2);
INSERT INTO employee_performance (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 4, 72, 33, 542308, 182, 72, 203106, 2);

-- Inserts for employee_goal
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (49, 58, 116, 14, 550804, 200, 77, 201901, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (65, 59, 66, 57, 628146, 298, 106, 201902, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (53, 72, 57, 18, 912537, 468, 21, 201903, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (51, 48, 52, 36, 257155, 145, 85, 201904, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 46, 34, 39, 350628, 383, 56, 201905, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (83, 45, 21, 15, 357998, 317, 73, 201906, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (33, 32, 80, 46, 1035764, 408, 107, 201907, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 27, 47, 11, 1017752, 332, 40, 201908, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 71, 108, 25, 1032891, 114, 66, 201909, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 24, 38, 58, 990655, 132, 36, 201910, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (67, 88, 105, 53, 1061674, 473, 19, 201911, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 79, 112, 44, 964444, 292, 80, 201912, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (63, 89, 109, 58, 494710, 161, 78, 202001, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (21, 94, 108, 16, 565714, 520, 40, 202002, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (107, 72, 68, 57, 191842, 219, 37, 202003, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 40, 84, 50, 737053, 445, 62, 202004, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 38, 95, 59, 365349, 383, 39, 202005, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (46, 83, 77, 21, 519607, 419, 14, 202006, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (60, 96, 97, 11, 863502, 174, 48, 202007, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 32, 38, 54, 817753, 529, 101, 202008, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 38, 70, 33, 846621, 65, 69, 202009, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (39, 61, 61, 46, 442943, 183, 44, 202010, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (34, 74, 34, 25, 883569, 239, 61, 202011, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (55, 91, 38, 11, 415882, 281, 67, 202012, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (99, 20, 92, 15, 707595, 499, 46, 202101, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 20, 72, 31, 190248, 544, 42, 202102, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (68, 56, 93, 24, 584542, 455, 14, 202103, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 75, 88, 36, 810556, 371, 10, 202104, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 88, 103, 45, 1099631, 156, 54, 202105, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 44, 83, 42, 1030143, 376, 72, 202106, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (88, 31, 43, 60, 617792, 439, 94, 202107, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (38, 20, 109, 59, 976019, 533, 37, 202108, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (48, 43, 48, 54, 271591, 465, 18, 202109, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 93, 108, 46, 1021003, 177, 86, 202110, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (27, 84, 120, 15, 706307, 344, 102, 202111, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (89, 91, 115, 32, 578142, 362, 45, 202112, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 67, 118, 56, 170209, 113, 35, 202201, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (30, 44, 101, 56, 672808, 479, 69, 202202, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (38, 75, 92, 30, 459582, 158, 21, 202203, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 83, 83, 38, 1088450, 69, 52, 202204, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (47, 26, 30, 28, 430255, 391, 87, 202205, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (106, 49, 60, 51, 411416, 458, 37, 202206, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (93, 54, 33, 48, 121997, 101, 47, 202207, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (101, 78, 85, 59, 260024, 100, 102, 202208, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 28, 66, 20, 228499, 111, 48, 202209, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (62, 94, 26, 38, 663029, 503, 71, 202210, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (66, 95, 36, 16, 180186, 345, 26, 202211, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 99, 20, 20, 858598, 79, 59, 202212, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 25, 118, 18, 977464, 549, 37, 202301, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (104, 90, 92, 38, 892230, 378, 13, 202302, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 98, 64, 14, 957552, 214, 56, 202303, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (62, 29, 52, 34, 784563, 231, 78, 202304, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 47, 37, 36, 477507, 331, 103, 202305, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 71, 54, 20, 304627, 244, 76, 202306, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (78, 59, 119, 53, 121839, 405, 60, 202307, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (50, 42, 104, 14, 366703, 426, 22, 202308, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (104, 59, 40, 32, 253687, 167, 46, 202309, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (48, 81, 31, 52, 970204, 253, 58, 202310, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (53, 85, 43, 26, 891453, 192, 61, 202311, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 77, 92, 29, 449681, 489, 39, 202312, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 89, 92, 34, 1041416, 445, 110, 202401, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 44, 101, 41, 661007, 265, 17, 202402, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (62, 79, 66, 38, 1042826, 100, 19, 202403, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (108, 59, 67, 25, 354836, 513, 38, 202404, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (47, 78, 36, 50, 947390, 261, 82, 202405, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (57, 55, 71, 39, 395897, 209, 97, 202406, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 28, 57, 37, 972061, 393, 33, 202407, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (23, 49, 45, 37, 430256, 218, 47, 202408, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (44, 20, 48, 13, 569294, 149, 32, 202409, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 72, 40, 12, 579632, 72, 64, 202410, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (52, 43, 103, 40, 425484, 195, 40, 202411, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (15, 99, 23, 19, 740830, 480, 70, 202412, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (101, 37, 22, 33, 768963, 435, 109, 202501, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (39, 51, 93, 19, 818104, 157, 50, 202502, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 27, 26, 15, 577319, 235, 43, 202503, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (61, 92, 44, 17, 774384, 391, 12, 202504, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (80, 81, 90, 12, 700448, 244, 66, 202505, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (67, 86, 110, 50, 504024, 416, 80, 202506, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (94, 67, 80, 51, 371861, 324, 58, 202507, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 34, 23, 32, 918112, 347, 12, 202508, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (80, 63, 112, 59, 394909, 308, 79, 202509, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (24, 30, 54, 40, 548273, 395, 82, 202510, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 32, 26, 52, 145414, 88, 70, 202511, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 44, 54, 45, 294818, 290, 96, 202512, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (28, 28, 80, 30, 905166, 388, 10, 202601, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (83, 89, 20, 16, 320825, 496, 63, 202602, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (98, 66, 40, 48, 516267, 295, 102, 202603, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 87, 74, 34, 404608, 514, 31, 202604, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (79, 81, 120, 58, 897538, 437, 72, 202605, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (82, 72, 72, 59, 209293, 545, 11, 202606, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (107, 71, 39, 56, 691685, 135, 56, 202607, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (13, 63, 97, 56, 738316, 106, 102, 202608, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (86, 23, 110, 28, 891143, 314, 46, 202609, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (34, 51, 115, 25, 854983, 412, 109, 202610, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (47, 70, 20, 29, 255177, 83, 54, 202611, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 99, 20, 30, 578369, 121, 24, 202612, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (27, 40, 75, 23, 694567, 461, 41, 202701, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (101, 74, 94, 24, 549586, 62, 90, 202702, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 39, 118, 56, 490468, 322, 46, 202703, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 91, 97, 16, 189776, 318, 18, 202704, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 47, 90, 11, 326498, 497, 17, 202705, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (69, 28, 52, 34, 947782, 243, 62, 202706, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (58, 46, 20, 38, 798635, 524, 92, 202707, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (41, 40, 71, 56, 365413, 409, 32, 202708, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (108, 88, 58, 27, 537919, 372, 20, 202709, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 98, 22, 52, 906112, 217, 110, 202710, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (70, 70, 97, 31, 930919, 197, 89, 202711, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (58, 85, 65, 21, 661942, 216, 74, 202712, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (26, 56, 56, 58, 760143, 56, 79, 202801, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (23, 67, 64, 25, 518579, 220, 27, 202802, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (26, 96, 67, 38, 613411, 208, 81, 202803, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (12, 36, 90, 18, 749039, 399, 30, 202804, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 71, 73, 40, 443682, 346, 84, 202805, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (98, 23, 45, 11, 610214, 212, 27, 202806, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 56, 87, 45, 828688, 341, 43, 202807, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 98, 60, 24, 167700, 50, 110, 202808, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (44, 33, 120, 54, 156231, 308, 10, 202809, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 99, 79, 21, 1083309, 501, 92, 202810, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (104, 83, 114, 23, 672563, 165, 110, 202811, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 29, 43, 46, 798227, 228, 13, 202812, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (74, 61, 49, 22, 1041584, 393, 20, 202901, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (12, 75, 37, 51, 976888, 80, 22, 202902, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 99, 59, 14, 306617, 413, 97, 202903, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (13, 32, 51, 57, 274456, 157, 51, 202904, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (55, 32, 53, 23, 285545, 335, 39, 202905, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (42, 78, 71, 48, 407691, 519, 25, 202906, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (83, 77, 111, 59, 454485, 321, 26, 202907, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (110, 79, 66, 44, 495148, 381, 47, 202908, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (30, 89, 63, 41, 710849, 535, 29, 202909, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (43, 56, 111, 27, 554442, 368, 92, 202910, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (68, 66, 48, 40, 755124, 248, 25, 202911, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 31, 107, 46, 269853, 117, 10, 202912, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 44, 79, 14, 217617, 538, 58, 203001, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 28, 65, 36, 652570, 289, 82, 203002, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (10, 69, 90, 16, 866680, 484, 43, 203003, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 57, 21, 54, 956849, 544, 62, 203004, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (96, 97, 96, 26, 581970, 378, 102, 203005, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (23, 38, 44, 60, 222891, 391, 23, 203006, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (21, 42, 36, 47, 925897, 131, 74, 203007, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 100, 110, 27, 849200, 350, 43, 203008, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (93, 59, 57, 38, 602428, 235, 105, 203009, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 20, 86, 59, 997466, 85, 35, 203010, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (94, 52, 36, 33, 673245, 285, 101, 203011, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (59, 76, 35, 52, 1004404, 270, 64, 203012, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 82, 38, 30, 922484, 170, 11, 203101, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (10, 64, 44, 53, 296928, 495, 36, 203102, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (40, 59, 101, 40, 320055, 283, 26, 203103, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (75, 65, 84, 43, 1086071, 354, 26, 203104, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 63, 92, 35, 508615, 321, 42, 203105, 2);
INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (51, 48, 116, 36, 773754, 269, 44, 203106, 2);

COMMIT;
