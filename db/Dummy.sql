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
INSERT INTO FILE_UPLOAD (id, origin_file, rename_file, path, thumbnail_path, created_at, type)
VALUES (1, 'profile.png', 'e637698b-fb33-4e96-9dd9-b5602572c50d_profile.png',
        'https://saladerp-bucket.s3.ap-northeast-2.amazonaws.com/employee/e637698b-fb33-4e96-9dd9-b5602572c50d_profile.png',
        null, '2025-06-22 23:37', 'PROFILE'),
       (2, 'free-icon-electric-appliance-7290460.png',
        '57a4dba9-b4ce-425d-87fa-6410de334236_free-icon-electric-appliance-7290460.png',
        'https://saladerp-bucket.s3.ap-northeast-2.amazonaws.com/product/57a4dba9-b4ce-425d-87fa-6410de334236_free-icon-electric-appliance-7290460.png',
        null, '2025-06-25 11:48:37', 'PRODUCT');

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
VALUES ('냉장고', '오브제컬렉션', 'S834BB30', 'LG-REF-S834BB30', 'LG', 2300000, 43900, 'LG에서 만든 예쁜 냉장고', FALSE, 2)
     , ('TV', '2024 QLED 4K QDE1 (189 cm) + 3.1 ch 사운드바 B650D', 'KQ75QDE1-B6', 'SAM-TV-KQ75QDE1-B6', '삼성', 3369000, 67425, '삼성 QLED TV', FALSE, 2)
     , ('세탁기', '비스포크 그랑데 AI 세탁기', 'WF24B7600KW', 'SAM-WASH-WF24B7600KW', '삼성', 1890000, 37900, 'AI 기능을 탑재한 삼성 세탁기', FALSE, 2)
     , ('건조기', 'LG 트롬 듀얼 인버터 히트펌프', 'RH18VNA', 'LG-DRY-RH18VNA', 'LG', 1720000, 35500, '에너지 효율이 뛰어난 LG 건조기', FALSE, 2)
     , ('에어컨', '휘센 듀얼 에어컨 2in1', 'FQ18DADWE2', 'LG-AC-FQ18DADWE2', 'LG', 2490000, 46800, '여름 필수품, LG 휘센 에어컨', FALSE, 2)
     , ('청소기', '제트 무선 청소기 VS20A956B', 'VS20A956B', 'SAM-VAC-VS20A956B', '삼성', 1340000, 27900, '강력한 흡입력의 삼성 무선 청소기', FALSE, 2)
     , ('오븐', '비스포크 큐커 AI 오븐', 'MC32A7035KT', 'SAM-OVEN-MC32A7035KT', '삼성', 590000, 12500, '다기능 삼성 오븐', FALSE, 2)
     , ('식기세척기', '디오스 식기세척기 스팀', 'DUBJ1G', 'LG-DISH-DUBJ1G', 'LG', 1380000, 28900, '고온 스팀 살균 LG 식기세척기', FALSE, 2)
     , ('냉장고', '비스포크 냉장고 4도어', 'RF85T9111AP', 'SAM-REF-RF85T9111AP', '삼성', 3100000, 58900, '고급형 삼성 냉장고', FALSE, 2)
     , ('TV', 'LG OLED evo C3 65인치', 'OLED65C3KNA', 'LG-TV-OLED65C3KNA', 'LG', 2790000, 55300, '고화질 LG OLED TV', FALSE, 2)
     , ('세탁기', 'LG 트윈워시 세탁기', 'F21VDP', 'LG-WASH-F21VDP', 'LG', 1980000, 39200, '세탁과 탈수를 동시에 LG 트윈워시', FALSE, 2)
     , ('건조기', '삼성 AI 건조기', 'DV90T8240SH', 'SAM-DRY-DV90T8240SH', '삼성', 1790000, 36500, 'AI 제어 삼성 건조기', FALSE, 2)
     , ('에어컨', '무풍에어컨 클래식', 'AF17A6474TZ', 'SAM-AC-AF17A6474TZ', '삼성', 2650000, 49500, '무풍 냉방 삼성 에어컨', FALSE, 2)
     , ('청소기', '코드제로 A9S', 'A958VA', 'LG-VAC-A958VA', 'LG', 1190000, 24500, 'LG 코드제로 무선 청소기', FALSE, 2)
     , ('오븐', 'LG 광파오븐 MA324B', 'MA324B', 'LG-OVEN-MA324B', 'LG', 540000, 11900, '간편한 요리를 위한 LG 오븐', FALSE, 2)
     , ('식기세척기', '삼성 비스포크 식기세척기', 'DW60A8055UG', 'SAM-DISH-DW60A8055UG', '삼성', 1450000, 29900, '스마트 기능 탑재 식기세척기', FALSE, 2)
     , ('공기청정기', 'LG 퓨리케어 360° 공기청정기', 'AS351NNFA', 'LG-AP-AS351NNFA', 'LG', 1040000, 20900, '360도 청정 기능 LG 공기청정기', FALSE, 2)
     , ('공기청정기', '삼성 블루스카이 5000', 'AX60A5510WDD', 'SAM-AP-AX60A5510WDD', '삼성', 980000, 19900, '초미세먼지 제거 삼성 공기청정기', FALSE, 2)
     , ('전자레인지', 'LG 전자레인지 MW25S', 'MW25S', 'LG-MIW-MW25S', 'LG', 210000, 4900, '간단 요리를 위한 전자레인지', FALSE, 2)
     , ('제습기', '삼성 무풍 제습기', 'AY10R5171', 'SAM-DEH-AY10R5171', '삼성', 670000, 13900, '쾌적한 여름을 위한 삼성 제습기', FALSE, 2);

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

INSERT INTO APPROVAL (code, title, content, req_date, aprv_date, state, comment, req_id, aprv_id, contract_id)
VALUES
    ('A-2401-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-27 17:33:09', '2024-01-22 12:43:44', '승인', NULL, 4, 8, 1),
    ('A-2401-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-10 15:35:00', '2024-01-15 11:56:51', '승인', NULL, 4, 8, 2),
    ('A-2401-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-25 16:44:24', '2024-01-27 11:22:33', '승인', NULL, 4, 8, 3),
    ('A-2401-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-08 17:52:49', '2024-01-23 10:01:07', '반려', '반려 사유입니다.', 4, 8, 4),
    ('A-2401-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-08 17:52:49', '2024-01-22 10:36:31', '승인', NULL, 4, 8, 4),
    ('A-2401-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-22 11:41:25', '2024-01-06 16:25:56', '반려', '반려 사유입니다.', 4, 8, 5),
    ('A-2401-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-22 11:41:25', '2024-01-06 10:26:21', '승인', NULL, 4, 8, 5),
    ('A-2401-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-22 12:40:34', '2024-01-01 12:39:45', '승인', NULL, 4, 8, 6),
    ('A-2401-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-31 15:56:29', '2024-01-23 13:49:37', '승인', NULL, 4, 8, 7),
    ('A-2401-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-05 10:41:27', '2024-01-21 14:09:57', '반려', '반려 사유입니다.', 4, 8, 8),
    ('A-2401-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-05 10:41:27', '2024-01-06 15:04:06', '승인', NULL, 4, 8, 8),
    ('A-2401-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-03 17:17:38', '2024-01-10 12:03:46', '반려', '반려 사유입니다.', 4, 8, 9),
    ('A-2401-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-03 17:17:38', '2024-01-02 11:32:37', '승인', NULL, 4, 8, 9),
    ('A-2401-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-11 14:07:33', '2024-01-04 10:08:44', '반려', '반려 사유입니다.', 4, 8, 10),
    ('A-2401-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-11 14:07:33', '2024-01-06 15:46:58', '승인', NULL, 4, 8, 10),
    ('A-2401-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-13 11:19:53', '2024-01-23 13:21:26', '반려', '반려 사유입니다.', 4, 8, 11),
    ('A-2401-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-13 11:19:53', '2024-01-11 09:44:51', '승인', NULL, 4, 8, 11),
    ('A-2401-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-04 09:45:40', '2024-01-21 14:00:51', '승인', NULL, 4, 8, 12),
    ('A-2401-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-07 15:33:52', '2024-01-14 12:02:25', '승인', NULL, 4, 8, 13),
    ('A-2401-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 10:16:40', '2024-01-29 09:56:42', '반려', '반려 사유입니다.', 4, 8, 14),
    ('A-2401-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 10:16:40', '2024-01-17 17:37:19', '승인', NULL, 4, 8, 14),
    ('A-2401-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-23 13:32:38', '2024-01-10 09:04:12', '승인', NULL, 4, 8, 15),
    ('A-2401-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 16:11:47', '2024-01-22 09:28:53', '승인', NULL, 4, 8, 16),
    ('A-2401-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 14:59:46', '2024-01-21 13:02:44', '반려', '반려 사유입니다.', 4, 8, 17),
    ('A-2401-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 14:59:46', '2024-01-03 09:12:31', '승인', NULL, 4, 8, 17),
    ('A-2401-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 14:19:34', '2024-01-01 17:19:27', '반려', '반려 사유입니다.', 4, 8, 18),
    ('A-2401-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 14:19:34', '2024-01-05 15:44:02', '승인', NULL, 4, 8, 18),
    ('A-2401-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-06 16:20:10', '2024-01-01 12:26:17', '승인', NULL, 4, 8, 19),
    ('A-2401-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-18 15:22:59', '2024-01-08 11:20:08', '승인', NULL, 4, 8, 20),

    ('A-2401-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 13:52:38', '2024-01-21 13:52:38', '승인', NULL, 9, 13, 369),
    ('A-2401-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-17 12:34:24', '2024-01-24 12:34:24', '승인', NULL, 9, 13, 370),
    ('A-2401-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-21 10:59:46', '2024-01-27 10:59:46', '승인', NULL, 9, 13, 371),
    ('A-2401-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-15 15:44:29', '2024-01-15 15:44:29', '승인', NULL, 9, 13, 372),
    ('A-2401-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-15 15:12:01', '2024-01-16 15:12:01', '승인', NULL, 9, 13, 373),
    ('A-2401-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-02 13:01:15', '2024-01-03 13:01:15', '승인', NULL, 9, 13, 374),
    ('A-2401-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-27 15:29:11', '2024-02-03 15:29:11', '승인', NULL, 9, 13, 375),
    ('A-2401-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-10 09:05:16', '2024-01-17 09:05:16', '승인', NULL, 9, 13, 376),
    ('A-2401-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-04 16:47:59', '2024-01-05 16:47:59', '승인', NULL, 9, 13, 377),
    ('A-2401-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-26 16:11:42', '2024-01-27 16:11:42', '승인', NULL, 9, 13, 378),
    ('A-2401-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-20 09:35:10', '2024-01-25 09:35:10', '승인', NULL, 9, 13, 379),
    ('A-2401-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-12 15:17:32', '2024-01-14 15:17:32', '승인', NULL, 9, 13, 380),
    ('A-2401-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-01 14:14:10', '2024-01-04 14:14:10', '승인', NULL, 9, 13, 381),
    ('A-2401-0043', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-12 14:15:17', '2024-01-14 14:15:17', '승인', NULL, 9, 13, 382),
    ('A-2401-0044', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-16 14:39:39', '2024-01-22 14:39:39', '승인', NULL, 9, 13, 383),
    ('A-2401-0045', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-01 09:01:42', '2024-01-08 09:01:42', '승인', NULL, 9, 13, 384),
    ('A-2401-0046', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-25 15:51:20', '2024-01-26 15:51:20', '승인', NULL, 9, 13, 385),
    ('A-2401-0047', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-06 15:30:32', '2024-01-13 15:30:32', '승인', NULL, 9, 13, 386),
    ('A-2401-0048', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-28 15:42:01', '2024-01-28 15:42:01', '승인', NULL, 9, 13, 387),
    ('A-2401-0049', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-01-12 16:21:15', '2024-01-12 16:21:15', '승인', NULL, 9, 13, 388),

    ('A-2402-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-24 10:32:44', '2024-02-18 15:16:42', '승인', NULL, 4, 8, 21),
    ('A-2402-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-04 11:20:53', '2024-02-01 13:22:08', '승인', NULL, 4, 8, 22),
    ('A-2402-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-01 16:33:55', '2024-02-09 15:21:06', '반려', '반려 사유입니다.', 4, 8, 23),
    ('A-2402-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-01 16:33:55', '2024-02-15 14:19:35', '승인', NULL, 4, 8, 23),
    ('A-2402-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-16 11:23:57', '2024-02-11 17:52:33', '승인', NULL, 4, 8, 24),
    ('A-2402-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-24 13:00:42', '2024-02-09 12:20:17', '반려', '반려 사유입니다.', 4, 8, 25),
    ('A-2402-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-24 13:00:42', '2024-02-13 17:43:00', '승인', NULL, 4, 8, 25),
    ('A-2402-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-21 16:35:21', '2024-02-22 12:02:40', '반려', '반려 사유입니다.', 4, 8, 26),
    ('A-2402-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-21 16:35:21', '2024-02-08 09:01:51', '승인', NULL, 4, 8, 26),
    ('A-2402-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-13 10:30:26', '2024-02-18 13:34:36', '승인', NULL, 4, 8, 27),
    ('A-2402-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-12 12:42:08', '2024-02-20 11:58:37', '반려', '반려 사유입니다.', 4, 8, 28),
    ('A-2402-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-12 12:42:08', '2024-02-16 15:14:10', '승인', NULL, 4, 8, 28),
    ('A-2402-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-12 12:47:44', '2024-02-28 10:00:17', '승인', NULL, 4, 8, 29),
    ('A-2402-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-21 11:06:43', '2024-02-28 12:59:28', '승인', NULL, 4, 8, 30),
    ('A-2402-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-02 09:32:06', '2024-02-29 16:55:49', '반려', '반려 사유입니다.', 4, 8, 31),
    ('A-2402-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-02 09:32:06', '2024-02-10 15:26:05', '승인', NULL, 4, 8, 31),
    ('A-2402-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-03 17:26:12', '2024-02-21 09:58:55', '반려', '반려 사유입니다.', 4, 8, 32),
    ('A-2402-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-03 17:26:12', '2024-02-21 11:16:55', '승인', NULL, 4, 8, 32),
    ('A-2402-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-24 13:05:45', '2024-02-17 12:39:51', '승인', NULL, 4, 8, 33),
    ('A-2402-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-21 12:52:31', '2024-02-04 16:36:35', '승인', NULL, 4, 8, 34),
    ('A-2402-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-24 11:05:29', '2024-02-19 10:52:16', '반려', '반려 사유입니다.', 4, 8, 35),
    ('A-2402-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-24 11:05:29', '2024-02-29 12:58:17', '승인', NULL, 4, 8, 35),
    ('A-2402-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-18 09:46:09', '2024-02-28 14:10:03', '반려', '반려 사유입니다.', 4, 8, 36),
    ('A-2402-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-18 09:46:09', '2024-02-18 10:03:05', '승인', NULL, 4, 8, 36),
    ('A-2402-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-24 16:02:03', '2024-02-17 13:14:19', '승인', NULL, 4, 8, 37),
    ('A-2402-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-18 12:57:38', '2024-02-25 09:44:47', '반려', '반려 사유입니다.', 4, 8, 38),
    ('A-2402-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-18 12:57:38', '2024-02-22 17:04:06', '승인', NULL, 4, 8, 38),
    ('A-2402-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-21 17:03:46', '2024-02-27 09:03:53', '반려', '반려 사유입니다.', 4, 8, 39),
    ('A-2402-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-21 17:03:46', '2024-02-25 14:49:27', '승인', NULL, 4, 8, 39),
    ('A-2402-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-06 11:59:51', '2024-02-11 15:18:37', '반려', '반려 사유입니다.', 4, 8, 40),
    ('A-2402-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-06 11:59:51', '2024-02-01 12:53:42', '승인', NULL, 4, 8, 40),

    ('A-2402-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-15 09:58:51', '2024-02-21 09:58:51', '승인', NULL, 9, 13, 389),
    ('A-2402-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-16 17:04:38', '2024-02-19 17:04:38', '승인', NULL, 9, 13, 390),
    ('A-2402-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-16 12:46:54', '2024-02-21 12:46:54', '승인', NULL, 9, 13, 391),
    ('A-2402-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-03 11:15:15', '2024-02-10 11:15:15', '승인', NULL, 9, 13, 392),
    ('A-2402-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-11 09:30:17', '2024-02-12 09:30:17', '승인', NULL, 9, 13, 393),
    ('A-2402-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-16 14:45:02', '2024-02-17 14:45:02', '승인', NULL, 9, 13, 394),
    ('A-2402-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-14 12:36:04', '2024-02-14 12:36:04', '승인', NULL, 9, 13, 395),
    ('A-2402-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-18 11:12:01', '2024-02-24 11:12:01', '승인', NULL, 9, 13, 396),
    ('A-2402-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-11 16:04:46', '2024-02-15 16:04:46', '승인', NULL, 9, 13, 397),
    ('A-2402-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-08 09:16:52', '2024-02-13 09:16:52', '승인', NULL, 9, 13, 398),
    ('A-2402-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-23 15:44:52', '2024-02-27 15:44:52', '승인', NULL, 9, 13, 399),
    ('A-2402-0043', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-02 16:05:26', '2024-02-04 16:05:26', '승인', NULL, 9, 13, 400),
    ('A-2402-0044', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-25 16:28:18', '2024-03-02 16:28:18', '승인', NULL, 9, 13, 401),
    ('A-2402-0045', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-06 16:52:11', '2024-02-12 16:52:11', '승인', NULL, 9, 13, 402),
    ('A-2402-0046', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-25 11:07:06', '2024-03-01 11:07:06', '승인', NULL, 9, 13, 403),
    ('A-2402-0047', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-16 13:41:47', '2024-02-18 13:41:47', '승인', NULL, 9, 13, 404),
    ('A-2402-0048', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-08 11:44:34', '2024-02-10 11:44:34', '승인', NULL, 9, 13, 405),
    ('A-2402-0049', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-25 17:22:12', '2024-02-28 17:22:12', '승인', NULL, 9, 13, 406),
    ('A-2402-0050', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-27 11:52:01', '2024-03-02 11:52:01', '승인', NULL, 9, 13, 407),
    ('A-2402-0051', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-02-05 10:30:06', '2024-02-10 10:30:06', '승인', NULL, 9, 13, 408),

    ('A-2403-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 10:21:03', '2024-03-05 12:16:07', '반려', '반려 사유입니다.', 4, 8, 41),
    ('A-2403-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 10:21:03', '2024-03-26 14:43:04', '승인', NULL, 4, 8, 41),
    ('A-2403-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-15 15:35:32', '2024-03-03 16:12:47', '반려', '반려 사유입니다.', 4, 8, 42),
    ('A-2403-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-15 15:35:32', '2024-03-29 16:35:24', '승인', NULL, 4, 8, 42),
    ('A-2403-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-17 16:44:11', '2024-03-24 14:59:05', '반려', '반려 사유입니다.', 4, 8, 43),
    ('A-2403-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-17 16:44:11', '2024-03-17 16:07:08', '승인', NULL, 4, 8, 43),
    ('A-2403-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-22 15:20:11', '2024-03-22 10:09:58', '승인', NULL, 4, 8, 44),
    ('A-2403-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-29 09:26:39', '2024-03-19 15:38:23', '반려', '반려 사유입니다.', 4, 8, 45),
    ('A-2403-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-29 09:26:39', '2024-03-10 15:27:48', '승인', NULL, 4, 8, 45),
    ('A-2403-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-10 14:24:37', '2024-03-30 17:42:14', '승인', NULL, 4, 8, 46),
    ('A-2403-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-28 16:38:27', '2024-03-30 17:19:11', '승인', NULL, 4, 8, 47),
    ('A-2403-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 12:58:30', '2024-03-03 17:52:13', '반려', '반려 사유입니다.', 4, 8, 48),
    ('A-2403-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 12:58:30', '2024-03-18 14:04:15', '승인', NULL, 4, 8, 48),
    ('A-2403-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-27 17:42:10', '2024-03-14 13:52:44', '반려', '반려 사유입니다.', 4, 8, 49),
    ('A-2403-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-27 17:42:10', '2024-03-11 16:39:28', '승인', NULL, 4, 8, 49),
    ('A-2403-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-23 10:21:44', '2024-03-03 17:09:13', '승인', NULL, 4, 8, 50),
    ('A-2403-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-26 14:18:15', '2024-03-04 14:04:24', '승인', NULL, 4, 8, 51),
    ('A-2403-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-27 13:22:31', '2024-03-23 10:07:51', '승인', NULL, 4, 8, 52),
    ('A-2403-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-13 11:59:28', '2024-03-09 11:59:59', '반려', '반려 사유입니다.', 4, 8, 53),
    ('A-2403-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-13 11:59:28', '2024-03-15 17:38:45', '승인', NULL, 4, 8, 53),
    ('A-2403-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-18 17:38:29', '2024-03-29 17:33:29', '반려', '반려 사유입니다.', 4, 8, 54),
    ('A-2403-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-18 17:38:29', '2024-03-30 13:25:17', '승인', NULL, 4, 8, 54),
    ('A-2403-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-12 17:39:18', '2024-03-08 09:52:28', '승인', NULL, 4, 8, 55),
    ('A-2403-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-22 14:36:51', '2024-03-11 15:00:17', '반려', '반려 사유입니다.', 4, 8, 56),
    ('A-2403-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-22 14:36:51', '2024-03-21 13:18:20', '승인', NULL, 4, 8, 56),
    ('A-2403-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-02 09:45:11', '2024-03-18 11:58:15', '반려', '반려 사유입니다.', 4, 8, 57),
    ('A-2403-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-02 09:45:11', '2024-03-23 11:18:06', '승인', NULL, 4, 8, 57),
    ('A-2403-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-03 12:45:54', '2024-03-29 11:32:37', '승인', NULL, 4, 8, 58),
    ('A-2403-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-31 16:30:38', '2024-03-14 13:18:12', '승인', NULL, 4, 8, 59),
    ('A-2403-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-09 11:36:57', '2024-03-13 13:25:58', '반려', '반려 사유입니다.', 4, 8, 60),
    ('A-2403-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-09 11:36:57', '2024-03-14 16:55:07', '승인', NULL, 4, 8, 60),
    ('A-2403-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-24 10:58:40', '2024-03-26 10:58:40', '승인', NULL, 9, 13, 408),
    ('A-2403-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-06 10:54:00', '2024-03-10 10:54:00', '승인', NULL, 9, 13, 409),
    ('A-2403-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-26 12:14:34', '2024-03-29 12:14:34', '승인', NULL, 9, 13, 410),
    ('A-2403-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-07 17:01:41', '2024-03-11 17:01:41', '승인', NULL, 9, 13, 411),
    ('A-2403-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-18 13:10:39', '2024-03-22 13:10:39', '승인', NULL, 9, 13, 412),
    ('A-2403-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-15 14:42:00', '2024-03-19 14:42:00', '승인', NULL, 9, 13, 413),
    ('A-2403-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-28 09:36:37', '2024-04-02 09:36:37', '승인', NULL, 9, 13, 414),
    ('A-2403-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-04 12:04:31', '2024-03-07 12:04:31', '승인', NULL, 9, 13, 415),
    ('A-2403-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-14 16:50:33', '2024-03-14 16:50:33', '승인', NULL, 9, 13, 416),
    ('A-2403-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 13:01:51', '2024-03-20 13:01:51', '승인', NULL, 9, 13, 417),
    ('A-2403-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-24 11:18:22', '2024-03-30 11:18:22', '승인', NULL, 9, 13, 418),
    ('A-2403-0043', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-07 14:22:05', '2024-03-13 14:22:05', '승인', NULL, 9, 13, 419),
    ('A-2403-0044', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-22 14:36:33', '2024-03-24 14:36:33', '승인', NULL, 9, 13, 420),
    ('A-2403-0045', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-04 09:04:40', '2024-03-07 09:04:40', '승인', NULL, 9, 13, 421),
    ('A-2403-0046', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-22 11:50:35', '2024-03-23 11:50:35', '승인', NULL, 9, 13, 422),
    ('A-2403-0047', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-28 13:04:23', '2024-03-29 13:04:23', '승인', NULL, 9, 13, 423),
    ('A-2403-0048', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-07 11:53:33', '2024-03-07 11:53:33', '승인', NULL, 9, 13, 424),
    ('A-2403-0049', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 13:20:18', '2024-03-23 13:20:18', '승인', NULL, 9, 13, 425),
    ('A-2403-0050', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-02 16:42:00', '2024-03-03 16:42:00', '승인', NULL, 9, 13, 426),
    ('A-2403-0051', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-27 14:44:18', '2024-04-01 14:44:18', '승인', NULL, 9, 13, 427),

    ('A-2404-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-03 10:48:39', '2024-04-07 13:48:39', '승인', NULL, 4, 8, 61),
    ('A-2404-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-11 17:38:52', '2024-04-16 17:38:52', '승인', NULL, 4, 8, 62),
    ('A-2404-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-19 11:37:10', '2024-04-22 14:37:10', '승인', NULL, 4, 8, 63),
    ('A-2404-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-24 13:34:13', '2024-04-30 14:34:13', '승인', NULL, 4, 8, 64),
    ('A-2404-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-28 11:14:33', '2024-04-30 14:14:33', '승인', NULL, 4, 8, 65),
    ('A-2404-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-08 15:18:30', '2024-04-14 17:18:30', '승인', NULL, 4, 8, 66),
    ('A-2404-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-02 09:58:21', '2024-04-02 10:58:21', '승인', NULL, 4, 8, 67),
    ('A-2404-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-02 09:53:52', '2024-04-06 12:53:52', '승인', NULL, 4, 8, 68),
    ('A-2404-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-24 13:05:11', '2024-04-28 13:05:11', '반려', '반려 사유입니다.', 4, 8, 69),
    ('A-2404-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-29 16:42:27', '2024-05-01 16:42:27', '승인', NULL, 4, 8, 70),
    ('A-2404-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-27 10:26:31', '2024-04-29 11:26:31', '승인', NULL, 4, 8, 71),
    ('A-2404-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-23 11:14:05', '2024-04-26 13:14:05', '승인', NULL, 4, 8, 72),
    ('A-2404-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-21 16:03:27', '2024-04-27 17:03:27', '승인', NULL, 4, 8, 73),
    ('A-2404-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-24 09:26:43', '2024-04-27 12:26:43', '승인', NULL, 4, 8, 74),
    ('A-2404-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-01 13:59:01', '2024-04-02 15:59:01', '승인', NULL, 4, 8, 75),
    ('A-2404-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-06 17:56:25', '2024-04-10 17:56:25', '승인', NULL, 4, 8, 76),
    ('A-2404-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-19 15:09:16', '2024-04-25 17:09:16', '승인', NULL, 4, 8, 77),
    ('A-2404-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-22 17:55:47', '2024-04-25 17:55:47', '승인', NULL, 4, 8, 78),
    ('A-2404-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-03 13:32:08', '2024-04-05 16:32:08', '승인', NULL, 4, 8, 79),
    ('A-2404-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-11 15:40:47', '2024-04-16 17:40:47', '반려', '반려 사유입니다.', 4, 8, 80),
    ('A-2404-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-17 11:08:15', '2024-04-18 11:08:15', '승인', NULL, 4, 8, 81),
    ('A-2404-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-04-24 11:19:05', '2024-04-24 12:19:05', '승인', NULL, 4, 8, 82),
    ('A-2403-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-24 10:58:40', '2024-03-26 10:58:40', '승인', NULL, 9, 13, 428),
    ('A-2403-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-06 10:54:00', '2024-03-10 10:54:00', '승인', NULL, 9, 13, 429),
    ('A-2403-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-26 12:14:34', '2024-03-29 12:14:34', '승인', NULL, 9, 13, 430),
    ('A-2403-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-07 17:01:41', '2024-03-11 17:01:41', '승인', NULL, 9, 13, 431),
    ('A-2403-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-18 13:10:39', '2024-03-22 13:10:39', '승인', NULL, 9, 13, 432),
    ('A-2403-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-15 14:42:00', '2024-03-19 14:42:00', '승인', NULL, 9, 13, 433),
    ('A-2403-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-28 09:36:37', '2024-04-02 09:36:37', '승인', NULL, 9, 13, 434),
    ('A-2403-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-04 12:04:31', '2024-03-07 12:04:31', '승인', NULL, 9, 13, 435),
    ('A-2403-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-14 16:50:33', '2024-03-14 16:50:33', '승인', NULL, 9, 13, 436),
    ('A-2403-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 13:01:51', '2024-03-20 13:01:51', '승인', NULL, 9, 13, 437),
    ('A-2403-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-24 11:18:22', '2024-03-30 11:18:22', '승인', NULL, 9, 13, 438),
    ('A-2403-0043', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-07 14:22:05', '2024-03-13 14:22:05', '승인', NULL, 9, 13, 439),
    ('A-2403-0044', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-22 14:36:33', '2024-03-24 14:36:33', '승인', NULL, 9, 13, 440),
    ('A-2403-0045', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-04 09:04:40', '2024-03-07 09:04:40', '승인', NULL, 9, 13, 441),
    ('A-2403-0046', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-22 11:50:35', '2024-03-23 11:50:35', '승인', NULL, 9, 13, 442),
    ('A-2403-0047', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-28 13:04:23', '2024-03-29 13:04:23', '승인', NULL, 9, 13, 443),
    ('A-2403-0048', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-07 11:53:33', '2024-03-07 11:53:33', '승인', NULL, 9, 13, 444),
    ('A-2403-0049', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-16 13:20:18', '2024-03-23 13:20:18', '승인', NULL, 9, 13, 445),
    ('A-2403-0050', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-02 16:42:00', '2024-03-03 16:42:00', '승인', NULL, 9, 13, 446),
    ('A-2403-0051', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-03-27 14:44:18', '2024-04-01 14:44:18', '승인', NULL, 9, 13, 447),

    ('A-2405-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-27 16:34:48', '2024-05-30 16:34:48', '승인', NULL, 4, 8, 83),
    ('A-2405-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-11 16:59:45', '2024-05-11 17:59:45', '승인', NULL, 4, 8, 84),
    ('A-2405-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-13 10:30:04', '2024-05-15 10:30:04', '승인', NULL, 4, 8, 85),
    ('A-2405-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-02 17:25:00', '2024-05-08 17:25:00', '승인', NULL, 4, 8, 86),
    ('A-2405-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-22 12:13:39', '2024-05-29 15:13:39', '승인', NULL, 4, 8, 87),
    ('A-2405-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-23 17:30:44', '2024-05-29 17:30:44', '승인', NULL, 4, 8, 88),
    ('A-2405-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-03 10:33:55', '2024-05-06 13:33:55', '승인', NULL, 4, 8, 89),
    ('A-2405-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-05 10:46:09', '2024-05-05 10:46:09', '승인', NULL, 4, 8, 90),
    ('A-2405-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-23 17:58:40', '2024-05-27 17:58:40', '반려', '반려 사유입니다.', 4, 8, 91),
    ('A-2405-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-28 15:08:37', '2024-05-29 15:08:37', '승인', NULL, 4, 8, 92),
    ('A-2405-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-23 17:14:40', '2024-05-28 17:14:40', '승인', NULL, 4, 8, 93),
    ('A-2405-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-24 13:30:50', '2024-05-30 16:30:50', '승인', NULL, 4, 8, 94),
    ('A-2405-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-13 10:04:37', '2024-05-16 12:04:37', '승인', NULL, 4, 8, 95),
    ('A-2405-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-03 09:31:34', '2024-05-05 10:31:34', '승인', NULL, 4, 8, 96),
    ('A-2405-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-27 11:23:13', '2024-06-01 12:23:13', '승인', NULL, 4, 8, 97),
    ('A-2405-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-14 10:48:26', '2024-05-19 10:48:26', '승인', NULL, 4, 8, 98),
    ('A-2405-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-28 10:26:46', '2024-05-28 11:26:46', '승인', NULL, 4, 8, 99),
    ('A-2405-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-27 10:26:51', '2024-06-01 12:26:51', '승인', NULL, 4, 8, 100),
    ('A-2405-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-11 10:32:06', '2024-05-15 10:32:06', '승인', NULL, 4, 8, 101),
    ('A-2405-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-25 09:16:10', '2024-05-29 09:16:10', '반려', '반려 사유입니다.', 4, 8, 102),
    ('A-2405-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-30 12:44:19', '2024-05-30 12:44:19', '승인', NULL, 4, 8, 103),
    ('A-2405-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-05-04 15:15:42', '2024-05-07 17:15:42', '승인', NULL, 4, 8, 104),

    ('A-2404-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-06 16:54:57', '2024-04-13 16:54:57', '승인', NULL, 9, 13, 448),
    ('A-2404-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-22 10:26:19', '2024-04-25 10:26:19', '승인', NULL, 9, 13, 449),
    ('A-2404-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-03 11:51:42', '2024-04-04 11:51:42', '승인', NULL, 9, 13, 450),
    ('A-2404-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-02 17:11:45', '2024-04-07 17:11:45', '승인', NULL, 9, 13, 451),
    ('A-2404-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-23 13:03:22', '2024-04-25 13:03:22', '승인', NULL, 9, 13, 452),
    ('A-2404-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-21 09:53:22', '2024-04-26 09:53:22', '승인', NULL, 9, 13, 453),
    ('A-2404-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-10 16:04:52', '2024-04-11 16:04:52', '승인', NULL, 9, 13, 454),
    ('A-2404-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-08 17:42:31', '2024-04-14 17:42:31', '승인', NULL, 9, 13, 455),
    ('A-2404-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-18 13:14:32', '2024-04-20 13:14:32', '승인', NULL, 9, 13, 456),
    ('A-2404-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-13 13:45:32', '2024-04-18 13:45:32', '승인', NULL, 9, 13, 457),
    ('A-2404-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-03 09:32:51', '2024-04-03 09:32:51', '승인', NULL, 9, 13, 458),
    ('A-2404-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-21 11:15:23', '2024-04-22 11:15:23', '승인', NULL, 9, 13, 459),
    ('A-2404-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-27 09:57:05', '2024-04-30 09:57:05', '승인', NULL, 9, 13, 460),
    ('A-2404-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-07 13:36:28', '2024-04-10 13:36:28', '승인', NULL, 9, 13, 461),
    ('A-2404-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-08 14:14:31', '2024-04-09 14:14:31', '승인', NULL, 9, 13, 462),
    ('A-2404-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-16 14:04:41', '2024-04-23 14:04:41', '승인', NULL, 9, 13, 463),
    ('A-2404-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-08 13:58:22', '2024-04-09 13:58:22', '승인', NULL, 9, 13, 464),
    ('A-2404-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-16 11:23:05', '2024-04-22 11:23:05', '승인', NULL, 9, 13, 465),
    ('A-2404-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-19 11:56:10', '2024-04-19 11:56:10', '승인', NULL, 9, 13, 466),
    ('A-2404-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-04-09 15:26:32', '2024-04-11 15:26:32', '승인', NULL, 9, 13, 467),


    ('A-2406-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-27 09:04:42', '2024-06-28 09:04:42', '승인', NULL, 4, 8, 105),
    ('A-2406-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-04 15:42:27', '2024-06-10 16:42:27', '승인', NULL, 4, 8, 106),
    ('A-2406-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-14 13:04:45', '2024-06-14 13:04:45', '승인', NULL, 4, 8, 107),
    ('A-2406-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-01 17:28:47', '2024-06-04 17:28:47', '승인', NULL, 4, 8, 108),
    ('A-2406-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-06 13:59:27', '2024-06-13 14:59:27', '승인', NULL, 4, 8, 109),
    ('A-2406-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-12 13:29:02', '2024-06-12 16:29:02', '승인', NULL, 4, 8, 110),
    ('A-2406-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-09 14:10:43', '2024-06-10 14:10:43', '승인', NULL, 4, 8, 111),
    ('A-2406-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-08 14:54:43', '2024-06-10 15:54:43', '승인', NULL, 4, 8, 112),
    ('A-2406-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-09 10:29:38', '2024-06-11 12:29:38', '반려', '반려 사유입니다.', 4, 8, 113),
    ('A-2406-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-12 14:12:41', '2024-06-13 14:12:41', '승인', NULL, 4, 8, 114),
    ('A-2406-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-01 15:41:13', '2024-06-02 16:41:13', '승인', NULL, 4, 8, 115),
    ('A-2406-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-15 13:16:45', '2024-06-16 16:16:45', '승인', NULL, 4, 8, 116),
    ('A-2406-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-22 15:18:34', '2024-06-24 17:18:34', '승인', NULL, 4, 8, 117),
    ('A-2406-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-01 17:57:15', '2024-06-07 17:57:15', '승인', NULL, 4, 8, 118),
    ('A-2406-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-11 14:59:13', '2024-06-17 14:59:13', '승인', NULL, 4, 8, 119),
    ('A-2406-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-14 14:01:08', '2024-06-21 17:01:08', '승인', NULL, 4, 8, 120),
    ('A-2406-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-21 09:14:36', '2024-06-23 12:14:36', '승인', NULL, 4, 8, 121),
    ('A-2406-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-28 17:34:58', '2024-07-02 17:34:58', '승인', NULL, 4, 8, 122),
    ('A-2406-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-02 15:32:01', '2024-06-07 17:32:01', '승인', NULL, 4, 8, 123),
    ('A-2406-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-24 12:10:54', '2024-07-01 12:10:54', '반려', '반려 사유입니다.', 4, 8, 124),
    ('A-2406-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-02 13:07:39', '2024-07-03 13:07:39', '승인', NULL, 4, 8, 125),
    ('A-2406-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-06-14 14:38:00', '2024-06-20 14:38:00', '승인', NULL, 4, 8, 126),

    ('A-2405-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-03 15:17:56', '2024-05-09 15:17:56', '승인', NULL, 9, 13, 468),
    ('A-2405-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-08 17:11:41', '2024-05-11 17:11:41', '승인', NULL, 9, 13, 469),
    ('A-2405-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-05 16:09:55', '2024-05-12 16:09:55', '승인', NULL, 9, 13, 470),
    ('A-2405-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-14 14:00:39', '2024-05-18 14:00:39', '승인', NULL, 9, 13, 471),
    ('A-2405-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-26 14:28:58', '2024-06-01 14:28:58', '승인', NULL, 9, 13, 472),
    ('A-2405-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-19 11:29:03', '2024-05-20 11:29:03', '승인', NULL, 9, 13, 473),
    ('A-2405-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-28 17:17:35', '2024-05-29 17:17:35', '승인', NULL, 9, 13, 474),
    ('A-2405-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-04 13:07:14', '2024-05-09 13:07:14', '승인', NULL, 9, 13, 475),
    ('A-2405-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-09 17:55:37', '2024-05-13 17:55:37', '승인', NULL, 9, 13, 476),
    ('A-2405-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-01 16:47:28', '2024-05-01 16:47:28', '승인', NULL, 9, 13, 477),
    ('A-2405-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-03 13:04:33', '2024-05-09 13:04:33', '승인', NULL, 9, 13, 478),
    ('A-2405-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-09 17:21:19', '2024-05-11 17:21:19', '승인', NULL, 9, 13, 479),
    ('A-2405-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-25 11:59:08', '2024-05-26 11:59:08', '승인', NULL, 9, 13, 480),
    ('A-2405-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-19 12:50:42', '2024-05-25 12:50:42', '승인', NULL, 9, 13, 481),
    ('A-2405-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-08 14:49:56', '2024-05-12 14:49:56', '승인', NULL, 9, 13, 482),
    ('A-2405-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-13 12:56:55', '2024-05-20 12:56:55', '승인', NULL, 9, 13, 483),
    ('A-2405-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-21 09:53:34', '2024-05-25 09:53:34', '승인', NULL, 9, 13, 484),
    ('A-2405-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-13 11:14:38', '2024-05-17 11:14:38', '승인', NULL, 9, 13, 485),
    ('A-2405-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-10 11:07:32', '2024-05-16 11:07:32', '승인', NULL, 9, 13, 486),
    ('A-2405-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-05-10 13:25:09', '2024-05-11 13:25:09', '승인', NULL, 9, 13, 487),

    ('A-2407-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-11 13:08:05', '2024-07-18 15:08:05', '승인', NULL, 4, 8, 127),
    ('A-2407-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-07 15:17:23', '2024-07-10 17:17:23', '승인', NULL, 4, 8, 128),
    ('A-2407-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-03 14:46:24', '2024-07-04 14:46:24', '승인', NULL, 4, 8, 129),
    ('A-2407-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-10 13:15:11', '2024-07-10 14:15:11', '승인', NULL, 4, 8, 130),
    ('A-2407-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-12 15:11:54', '2024-07-12 15:11:54', '승인', NULL, 4, 8, 131),
    ('A-2407-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-26 15:39:08', '2024-07-30 17:39:08', '승인', NULL, 4, 8, 132),
    ('A-2407-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-27 10:15:22', '2024-07-30 13:15:22', '승인', NULL, 4, 8, 133),
    ('A-2407-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-03 17:57:46', '2024-07-08 17:57:46', '승인', NULL, 4, 8, 134),
    ('A-2407-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-27 13:56:24', '2024-07-27 13:56:24', '반려', '반려 사유입니다.', 4, 8, 135),
    ('A-2407-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-28 11:34:57', '2024-07-29 11:34:57', '승인', NULL, 4, 8, 136),
    ('A-2407-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-21 10:14:31', '2024-07-25 10:14:31', '승인', NULL, 4, 8, 137),
    ('A-2407-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-16 11:51:31', '2024-07-16 12:51:31', '승인', NULL, 4, 8, 138),
    ('A-2407-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-02 15:06:37', '2024-07-04 17:06:37', '승인', NULL, 4, 8, 139),
    ('A-2407-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-22 15:40:42', '2024-07-24 17:40:42', '승인', NULL, 4, 8, 140),
    ('A-2407-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-05 13:03:20', '2024-07-10 15:03:20', '승인', NULL, 4, 8, 141),
    ('A-2407-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-23 12:36:43', '2024-07-27 14:36:43', '승인', NULL, 4, 8, 142),
    ('A-2407-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-16 11:46:55', '2024-07-19 13:46:55', '승인', NULL, 4, 8, 143),
    ('A-2407-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-07 13:28:49', '2024-07-07 15:28:49', '승인', NULL, 4, 8, 144),
    ('A-2407-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-18 13:39:44', '2024-07-22 14:39:44', '승인', NULL, 4, 8, 145),
    ('A-2407-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-17 17:15:54', '2024-07-18 17:15:54', '반려', '반려 사유입니다.', 4, 8, 146),
    ('A-2407-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-19 15:21:54', '2024-07-21 15:21:54', '승인', NULL, 4, 8, 147),
    ('A-2407-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-07-17 17:32:08', '2024-07-20 17:32:08', '승인', NULL, 4, 8, 148),
    ('A-2406-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-28 15:27:52', '2024-07-01 15:27:52', '승인', NULL, 9, 13, 488),
    ('A-2406-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-21 16:25:42', '2024-06-25 16:25:42', '승인', NULL, 9, 13, 489),
    ('A-2406-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-26 14:59:30', '2024-07-01 14:59:30', '승인', NULL, 9, 13, 490),
    ('A-2406-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-16 14:52:38', '2024-06-23 14:52:38', '승인', NULL, 9, 13, 491),
    ('A-2406-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-10 16:46:05', '2024-06-13 16:46:05', '승인', NULL, 9, 13, 492),
    ('A-2406-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-05 16:02:04', '2024-06-10 16:02:04', '승인', NULL, 9, 13, 493),
    ('A-2406-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-19 10:01:28', '2024-06-22 10:01:28', '승인', NULL, 9, 13, 494),
    ('A-2406-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-12 14:15:04', '2024-06-14 14:15:04', '승인', NULL, 9, 13, 495),
    ('A-2406-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-12 13:11:20', '2024-06-13 13:11:20', '승인', NULL, 9, 13, 496),
    ('A-2406-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-03 17:06:29', '2024-06-05 17:06:29', '승인', NULL, 9, 13, 497),
    ('A-2406-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-12 14:25:12', '2024-06-12 14:25:12', '승인', NULL, 9, 13, 498),
    ('A-2406-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-08 09:26:46', '2024-06-12 09:26:46', '승인', NULL, 9, 13, 499),
    ('A-2406-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-05 12:06:50', '2024-06-08 12:06:50', '승인', NULL, 9, 13, 500),
    ('A-2406-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-22 17:41:57', '2024-06-27 17:41:57', '승인', NULL, 9, 13, 501),
    ('A-2406-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-23 17:09:13', '2024-06-29 17:09:13', '승인', NULL, 9, 13, 502),
    ('A-2406-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-17 16:00:05', '2024-06-18 16:00:05', '승인', NULL, 9, 13, 503),
    ('A-2406-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-06 14:39:19', '2024-06-08 14:39:19', '승인', NULL, 9, 13, 504),
    ('A-2406-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-05 15:17:26', '2024-06-09 15:17:26', '승인', NULL, 9, 13, 505),
    ('A-2406-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-22 17:57:37', '2024-06-29 17:57:37', '승인', NULL, 9, 13, 506),
    ('A-2406-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-06-26 13:29:13', '2024-06-29 13:29:13', '승인', NULL, 9, 13, 507),


    ('A-2408-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-08 09:38:49', '2024-08-14 09:38:49', '승인', NULL, 4, 8, 149),
    ('A-2408-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-15 15:33:36', '2024-08-20 17:33:36', '승인', NULL, 4, 8, 150),
    ('A-2408-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-03 16:10:49', '2024-08-08 17:10:49', '승인', NULL, 4, 8, 151),
    ('A-2408-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-06 14:10:24', '2024-08-13 14:10:24', '승인', NULL, 4, 8, 152),
    ('A-2408-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-24 12:25:20', '2024-08-29 14:25:20', '승인', NULL, 4, 8, 153),
    ('A-2408-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-01 10:06:17', '2024-08-02 10:06:17', '승인', NULL, 4, 8, 154),
    ('A-2408-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-28 10:30:01', '2024-09-01 13:30:01', '승인', NULL, 4, 8, 155),
    ('A-2408-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-10 10:28:50', '2024-08-17 11:28:50', '승인', NULL, 4, 8, 156),
    ('A-2408-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-08 13:54:27', '2024-08-08 15:54:27', '반려', '반려 사유입니다.', 4, 8, 157),
    ('A-2408-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-09 10:41:39', '2024-08-10 10:41:39', '승인', NULL, 4, 8, 158),
    ('A-2408-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-06 13:11:53', '2024-08-06 16:11:53', '승인', NULL, 4, 8, 159),
    ('A-2408-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-25 10:04:09', '2024-08-29 12:04:09', '승인', NULL, 4, 8, 160),
    ('A-2408-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-01 09:46:09', '2024-08-07 09:46:09', '승인', NULL, 4, 8, 161),
    ('A-2408-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-12 09:32:38', '2024-08-14 10:32:38', '승인', NULL, 4, 8, 162),
    ('A-2408-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-07 15:57:34', '2024-08-10 17:57:34', '승인', NULL, 4, 8, 163),
    ('A-2408-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-09 13:36:42', '2024-08-10 15:36:42', '승인', NULL, 4, 8, 164),
    ('A-2408-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-18 10:30:33', '2024-08-18 12:30:33', '승인', NULL, 4, 8, 165),
    ('A-2408-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-15 12:37:22', '2024-08-17 15:37:22', '승인', NULL, 4, 8, 166),
    ('A-2408-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-10 16:25:36', '2024-08-17 16:25:36', '승인', NULL, 4, 8, 167),
    ('A-2408-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-07 10:54:04', '2024-08-11 12:54:04', '반려', '반려 사유입니다.', 4, 8, 168),
    ('A-2408-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-12 14:59:58', '2024-08-12 14:59:58', '승인', NULL, 4, 8, 169),
    ('A-2408-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-08-22 15:20:05', '2024-08-24 15:20:05', '승인', NULL, 4, 8, 170),
    ('A-2407-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-28 13:13:08', '2024-08-02 13:13:08', '승인', NULL, 9, 13, 508),
    ('A-2407-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-11 17:22:26', '2024-07-17 17:22:26', '승인', NULL, 9, 13, 509),
    ('A-2407-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-06 14:55:14', '2024-07-10 14:55:14', '승인', NULL, 9, 13, 510),
    ('A-2407-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-17 14:13:57', '2024-07-23 14:13:57', '승인', NULL, 9, 13, 511),
    ('A-2407-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-09 09:50:29', '2024-07-15 09:50:29', '승인', NULL, 9, 13, 512),
    ('A-2407-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-21 10:35:03', '2024-07-28 10:35:03', '승인', NULL, 9, 13, 513),
    ('A-2407-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-22 12:10:26', '2024-07-24 12:10:26', '승인', NULL, 9, 13, 514),
    ('A-2407-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-25 15:06:33', '2024-07-27 15:06:33', '승인', NULL, 9, 13, 515),
    ('A-2407-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-06 13:33:58', '2024-07-10 13:33:58', '승인', NULL, 9, 13, 516),
    ('A-2407-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-26 11:57:39', '2024-07-28 11:57:39', '승인', NULL, 9, 13, 517),
    ('A-2407-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-15 14:41:50', '2024-07-19 14:41:50', '승인', NULL, 9, 13, 518),
    ('A-2407-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-19 09:44:20', '2024-07-25 09:44:20', '승인', NULL, 9, 13, 519),
    ('A-2407-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-16 17:33:53', '2024-07-16 17:33:53', '승인', NULL, 9, 13, 520),
    ('A-2407-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-24 16:12:02', '2024-07-27 16:12:02', '승인', NULL, 9, 13, 521),
    ('A-2407-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-06 17:16:05', '2024-07-13 17:16:05', '승인', NULL, 9, 13, 522),
    ('A-2407-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-25 14:22:36', '2024-07-25 14:22:36', '승인', NULL, 9, 13, 523),
    ('A-2407-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-19 14:21:11', '2024-07-26 14:21:11', '승인', NULL, 9, 13, 524),
    ('A-2407-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-01 10:16:22', '2024-07-07 10:16:22', '승인', NULL, 9, 13, 525),
    ('A-2407-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-21 13:36:21', '2024-07-23 13:36:21', '승인', NULL, 9, 13, 526),
    ('A-2407-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-07-01 12:25:54', '2024-07-05 12:25:54', '승인', NULL, 9, 13, 527),

    ('A-2409-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-25 13:15:32', '2024-09-29 16:15:32', '승인', NULL, 4, 8, 171),
    ('A-2409-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-16 11:13:56', '2024-09-17 12:13:56', '승인', NULL, 4, 8, 172),
    ('A-2409-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-09 11:17:37', '2024-09-15 14:17:37', '승인', NULL, 4, 8, 173),
    ('A-2409-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-22 13:58:00', '2024-09-26 13:58:00', '승인', NULL, 4, 8, 174),
    ('A-2409-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-06 12:07:42', '2024-09-08 14:07:42', '승인', NULL, 4, 8, 175),
    ('A-2409-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-08 17:38:23', '2024-09-14 17:38:23', '승인', NULL, 4, 8, 176),
    ('A-2409-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-19 09:51:15', '2024-09-24 09:51:15', '승인', NULL, 4, 8, 177),
    ('A-2409-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-26 14:35:39', '2024-10-01 15:35:39', '승인', NULL, 4, 8, 178),
    ('A-2409-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-08 17:00:57', '2024-09-10 17:00:57', '반려', '반려 사유입니다.', 4, 8, 179),
    ('A-2409-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-11 16:57:09', '2024-09-11 16:57:09', '승인', NULL, 4, 8, 180),
    ('A-2409-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-12 10:04:05', '2024-09-14 13:04:05', '승인', NULL, 4, 8, 181),
    ('A-2409-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-24 10:21:12', '2024-10-01 10:21:12', '승인', NULL, 4, 8, 182),
    ('A-2409-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-21 14:12:38', '2024-09-23 17:12:38', '승인', NULL, 4, 8, 183),
    ('A-2409-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-11 12:14:14', '2024-09-13 14:14:14', '승인', NULL, 4, 8, 184),
    ('A-2409-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-08 10:47:58', '2024-09-10 10:47:58', '승인', NULL, 4, 8, 185),
    ('A-2409-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-13 10:19:37', '2024-09-19 13:19:37', '승인', NULL, 4, 8, 186),
    ('A-2409-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-09 11:37:26', '2024-09-14 14:37:26', '승인', NULL, 4, 8, 187),
    ('A-2409-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-18 10:45:13', '2024-09-21 12:45:13', '승인', NULL, 4, 8, 188),
    ('A-2409-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-22 12:11:11', '2024-09-29 14:11:11', '승인', NULL, 4, 8, 189),
    ('A-2409-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-24 11:29:43', '2024-09-28 14:29:43', '반려', '반려 사유입니다.', 4, 8, 190),
    ('A-2409-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-29 17:05:38', '2024-10-01 17:05:38', '승인', NULL, 4, 8, 191),
    ('A-2409-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-09-07 10:34:35', '2024-09-09 10:34:35', '승인', NULL, 4, 8, 192),

('A-2408-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-08 17:05:26', '2024-08-13 17:05:26', '승인', NULL, 9, 13, 528),
('A-2408-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-18 17:41:08', '2024-08-21 17:41:08', '승인', NULL, 9, 13, 529),
('A-2408-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-12 15:57:29', '2024-08-16 15:57:29', '승인', NULL, 9, 13, 530),
('A-2408-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-18 09:24:26', '2024-08-23 09:24:26', '승인', NULL, 9, 13, 531),
('A-2408-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-24 15:51:01', '2024-08-26 15:51:01', '승인', NULL, 9, 13, 532),
('A-2408-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-21 15:09:15', '2024-08-27 15:09:15', '승인', NULL, 9, 13, 533),
('A-2408-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-02 15:58:34', '2024-08-07 15:58:34', '승인', NULL, 9, 13, 534),
('A-2408-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-09 17:52:07', '2024-08-12 17:52:07', '승인', NULL, 9, 13, 535),
('A-2408-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-27 12:06:17', '2024-08-30 12:06:17', '승인', NULL, 9, 13, 536),
('A-2408-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-26 11:16:59', '2024-08-28 11:16:59', '승인', NULL, 9, 13, 537),
('A-2408-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-21 14:30:51', '2024-08-24 14:30:51', '승인', NULL, 9, 13, 538),
('A-2408-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-28 10:25:49', '2024-08-28 10:25:49', '승인', NULL, 9, 13, 539),
('A-2408-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-22 14:30:31', '2024-08-27 14:30:31', '승인', NULL, 9, 13, 540),
('A-2408-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-21 15:38:56', '2024-08-28 15:38:56', '승인', NULL, 9, 13, 541),
('A-2408-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-04 10:15:10', '2024-08-11 10:15:10', '승인', NULL, 9, 13, 542),
('A-2408-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-17 14:53:09', '2024-08-21 14:53:09', '승인', NULL, 9, 13, 543),
('A-2408-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-04 14:10:50', '2024-08-09 14:10:50', '승인', NULL, 9, 13, 544),
('A-2408-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-05 17:08:09', '2024-08-12 17:08:09', '승인', NULL, 9, 13, 545),
('A-2408-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-07 17:26:37', '2024-08-09 17:26:37', '승인', NULL, 9, 13, 546),
('A-2408-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-08-04 13:31:28', '2024-08-11 13:31:28', '승인', NULL, 9, 13, 547),


    ('A-2410-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-01 10:00:09', '2024-10-01 12:00:09', '승인', NULL, 4, 8, 193),
    ('A-2410-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-25 12:30:05', '2024-10-27 12:30:05', '승인', NULL, 4, 8, 194),
    ('A-2410-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-27 15:10:44', '2024-11-02 17:10:44', '승인', NULL, 4, 8, 195),
    ('A-2410-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-24 15:20:49', '2024-10-30 17:20:49', '승인', NULL, 4, 8, 196),
    ('A-2410-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-04 11:45:38', '2024-10-10 14:45:38', '승인', NULL, 4, 8, 197),
    ('A-2410-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-14 16:10:41', '2024-10-16 16:10:41', '승인', NULL, 4, 8, 198),
    ('A-2410-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-12 10:13:26', '2024-10-14 12:13:26', '승인', NULL, 4, 8, 199),
    ('A-2410-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-04 16:58:29', '2024-10-06 17:58:29', '승인', NULL, 4, 8, 200),
    ('A-2410-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-04 12:18:22', '2024-10-11 12:18:22', '반려', '반려 사유입니다.', 4, 8, 201),
    ('A-2410-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-12 13:44:52', '2024-10-13 13:44:52', '승인', NULL, 4, 8, 202),
    ('A-2410-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-24 10:27:23', '2024-10-24 10:27:23', '승인', NULL, 4, 8, 203),
    ('A-2410-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-07 16:23:46', '2024-10-07 17:23:46', '승인', NULL, 4, 8, 204),
    ('A-2410-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-20 12:55:42', '2024-10-21 13:55:42', '승인', NULL, 4, 8, 205),
    ('A-2410-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-06 12:33:40', '2024-10-13 13:33:40', '승인', NULL, 4, 8, 206),
    ('A-2410-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-22 17:47:20', '2024-10-22 17:47:20', '승인', NULL, 4, 8, 207),
    ('A-2410-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-13 15:12:17', '2024-10-17 16:12:17', '승인', NULL, 4, 8, 208),
    ('A-2410-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-24 11:33:05', '2024-10-30 13:33:05', '승인', NULL, 4, 8, 209),
    ('A-2410-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-04 17:29:30', '2024-10-09 17:29:30', '승인', NULL, 4, 8, 210),
    ('A-2410-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-15 16:11:19', '2024-10-16 17:11:19', '승인', NULL, 4, 8, 211),
    ('A-2410-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-04 16:17:03', '2024-10-06 16:17:03', '반려', '반려 사유입니다.', 4, 8, 212),
    ('A-2410-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-07 10:33:05', '2024-10-08 10:33:05', '승인', NULL, 4, 8, 213),
    ('A-2410-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-10-23 17:17:46', '2024-10-30 17:17:46', '승인', NULL, 4, 8, 214),

('A-2409-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-12 10:22:02', '2024-09-18 10:22:02', '승인', NULL, 9, 13, 548),
('A-2409-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-28 13:55:21', '2024-09-30 13:55:21', '승인', NULL, 9, 13, 549),
('A-2409-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-13 11:09:21', '2024-09-15 11:09:21', '승인', NULL, 9, 13, 550),
('A-2409-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-04 09:52:40', '2024-09-11 09:52:40', '승인', NULL, 9, 13, 551),
('A-2409-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-01 11:42:33', '2024-09-04 11:42:33', '승인', NULL, 9, 13, 552),
('A-2409-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-21 17:07:09', '2024-09-26 17:07:09', '승인', NULL, 9, 13, 553),
('A-2409-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-28 14:03:12', '2024-10-05 14:03:12', '승인', NULL, 9, 13, 554),
('A-2409-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-28 12:50:29', '2024-10-05 12:50:29', '승인', NULL, 9, 13, 555),
('A-2409-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-08 13:41:29', '2024-09-13 13:41:29', '승인', NULL, 9, 13, 556),
('A-2409-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-19 12:52:31', '2024-09-24 12:52:31', '승인', NULL, 9, 13, 557),
('A-2409-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-21 17:46:26', '2024-09-26 17:46:26', '승인', NULL, 9, 13, 558),
('A-2409-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-07 10:14:52', '2024-09-08 10:14:52', '승인', NULL, 9, 13, 559),
('A-2409-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-03 15:29:34', '2024-09-08 15:29:34', '승인', NULL, 9, 13, 560),
('A-2409-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-11 13:21:52', '2024-09-11 13:21:52', '승인', NULL, 9, 13, 561),
('A-2409-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-20 12:13:57', '2024-09-20 12:13:57', '승인', NULL, 9, 13, 562),
('A-2409-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-06 10:13:36', '2024-09-12 10:13:36', '승인', NULL, 9, 13, 563),
('A-2409-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-16 10:02:47', '2024-09-21 10:02:47', '승인', NULL, 9, 13, 564),
('A-2409-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-16 13:51:07', '2024-09-22 13:51:07', '승인', NULL, 9, 13, 565),
('A-2409-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-15 09:59:21', '2024-09-16 09:59:21', '승인', NULL, 9, 13, 566),
('A-2409-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-09-04 11:10:54', '2024-09-04 11:10:54', '승인', NULL, 9, 13, 567),

    ('A-2411-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-16 10:49:00', '2024-11-20 10:49:00', '승인', NULL, 4, 8, 215),
    ('A-2411-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-25 15:54:23', '2024-11-30 16:54:23', '승인', NULL, 4, 8, 216),
    ('A-2411-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-24 09:17:57', '2024-12-01 11:17:57', '승인', NULL, 4, 8, 217),
    ('A-2411-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-09 09:42:18', '2024-11-10 09:42:18', '승인', NULL, 4, 8, 218),
    ('A-2411-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-12 11:49:20', '2024-11-17 11:49:20', '승인', NULL, 4, 8, 219),
    ('A-2411-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-10 17:30:51', '2024-11-14 17:30:51', '승인', NULL, 4, 8, 220),
    ('A-2411-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-17 11:46:22', '2024-11-22 14:46:22', '승인', NULL, 4, 8, 221),
    ('A-2411-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-28 15:29:09', '2024-12-03 17:29:09', '승인', NULL, 4, 8, 222),
    ('A-2411-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-14 10:25:59', '2024-11-16 12:25:59', '반려', '반려 사유입니다.', 4, 8, 223),
    ('A-2411-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-17 15:42:38', '2024-11-19 15:42:38', '승인', NULL, 4, 8, 224),
    ('A-2411-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-25 16:22:45', '2024-11-25 17:22:45', '승인', NULL, 4, 8, 225),
    ('A-2411-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-12 16:54:48', '2024-11-14 17:54:48', '승인', NULL, 4, 8, 226),
    ('A-2411-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-15 13:55:12', '2024-11-17 15:55:12', '승인', NULL, 4, 8, 227),
    ('A-2411-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-03 11:40:05', '2024-11-06 14:40:05', '승인', NULL, 4, 8, 228),
    ('A-2411-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-13 12:03:02', '2024-11-20 14:03:02', '승인', NULL, 4, 8, 229),
    ('A-2411-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-08 12:48:13', '2024-11-09 14:48:13', '승인', NULL, 4, 8, 230),
    ('A-2411-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-05 12:39:19', '2024-11-10 14:39:19', '승인', NULL, 4, 8, 231),
    ('A-2411-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-12 11:00:45', '2024-11-16 13:00:45', '승인', NULL, 4, 8, 232),
    ('A-2411-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-08 12:53:53', '2024-11-09 13:53:53', '승인', NULL, 4, 8, 233),
    ('A-2411-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-01 12:56:56', '2024-11-04 12:56:56', '반려', '반려 사유입니다.', 4, 8, 234),
    ('A-2411-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-05 12:52:34', '2024-11-05 12:52:34', '승인', NULL, 4, 8, 235),
    ('A-2411-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-11-11 10:56:30', '2024-11-11 13:56:30', '승인', NULL, 4, 8, 236),

('A-2410-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-19 10:53:29', '2024-10-22 10:53:29', '승인', NULL, 9, 13, 568),
('A-2410-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-11 14:33:25', '2024-10-15 14:33:25', '승인', NULL, 9, 13, 569),
('A-2410-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-10 15:49:35', '2024-10-12 15:49:35', '승인', NULL, 9, 13, 570),
('A-2410-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-17 10:29:51', '2024-10-17 10:29:51', '승인', NULL, 9, 13, 571),
('A-2410-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-06 16:43:54', '2024-10-13 16:43:54', '승인', NULL, 9, 13, 572),
('A-2410-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-10 16:32:21', '2024-10-17 16:32:21', '승인', NULL, 9, 13, 573),
('A-2410-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-24 09:12:49', '2024-10-30 09:12:49', '승인', NULL, 9, 13, 574),
('A-2410-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-17 10:53:27', '2024-10-20 10:53:27', '승인', NULL, 9, 13, 575),
('A-2410-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-22 13:06:20', '2024-10-25 13:06:20', '승인', NULL, 9, 13, 576),
('A-2410-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-04 15:05:39', '2024-10-04 15:05:39', '승인', NULL, 9, 13, 577),
('A-2410-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-08 17:35:41', '2024-10-13 17:35:41', '승인', NULL, 9, 13, 578),
('A-2410-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-04 14:51:45', '2024-10-04 14:51:45', '승인', NULL, 9, 13, 579),
('A-2410-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-25 15:18:15', '2024-11-01 15:18:15', '승인', NULL, 9, 13, 580),
('A-2410-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-01 15:58:38', '2024-10-03 15:58:38', '승인', NULL, 9, 13, 581),
('A-2410-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-14 13:47:46', '2024-10-15 13:47:46', '승인', NULL, 9, 13, 582),
('A-2410-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-13 12:37:23', '2024-10-13 12:37:23', '승인', NULL, 9, 13, 583),
('A-2410-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-25 16:38:41', '2024-11-01 16:38:41', '승인', NULL, 9, 13, 584),
('A-2410-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-08 10:52:37', '2024-10-15 10:52:37', '승인', NULL, 9, 13, 585),
('A-2410-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-21 13:49:10', '2024-10-21 13:49:10', '승인', NULL, 9, 13, 586),
('A-2410-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-10-08 10:33:22', '2024-10-09 10:33:22', '승인', NULL, 9, 13, 587),



    ('A-2412-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-19 11:13:52', '2024-12-21 14:13:52', '승인', NULL, 4, 8, 237),
    ('A-2412-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-15 15:38:20', '2024-12-21 15:38:20', '승인', NULL, 4, 8, 238),
    ('A-2412-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-18 15:40:14', '2024-12-22 15:40:14', '승인', NULL, 4, 8, 239),
    ('A-2412-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-27 11:19:40', '2025-01-03 13:19:40', '승인', NULL, 4, 8, 240),
    ('A-2412-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-12 15:49:32', '2024-12-14 17:49:32', '승인', NULL, 4, 8, 241),
    ('A-2412-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-23 09:38:08', '2024-12-25 09:38:08', '승인', NULL, 4, 8, 242),
    ('A-2412-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-26 11:03:42', '2024-12-29 12:03:42', '승인', NULL, 4, 8, 243),
    ('A-2412-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-04 15:03:27', '2024-12-09 17:03:27', '승인', NULL, 4, 8, 244),
    ('A-2412-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-20 14:01:17', '2024-12-24 15:01:17', '반려', '반려 사유입니다.', 4, 8, 245),
    ('A-2412-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-25 12:40:06', '2024-12-27 12:40:06', '승인', NULL, 4, 8, 246),
    ('A-2412-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-09 14:50:11', '2024-12-09 16:50:11', '승인', NULL, 4, 8, 247),
    ('A-2412-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-05 16:19:47', '2024-12-10 17:19:47', '승인', NULL, 4, 8, 248),
    ('A-2412-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-26 16:07:34', '2024-12-27 16:07:34', '승인', NULL, 4, 8, 249),
    ('A-2412-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-06 16:53:36', '2024-12-09 17:53:36', '승인', NULL, 4, 8, 250),
    ('A-2412-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-27 16:35:34', '2025-01-02 17:35:34', '승인', NULL, 4, 8, 251),
    ('A-2412-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-14 11:38:13', '2024-12-15 13:38:13', '승인', NULL, 4, 8, 252),
    ('A-2412-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-17 12:25:20', '2024-12-20 12:25:20', '승인', NULL, 4, 8, 253),
    ('A-2412-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-16 12:44:06', '2024-12-16 14:44:06', '승인', NULL, 4, 8, 254),
    ('A-2412-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-05 10:46:16', '2024-12-07 10:46:16', '승인', NULL, 4, 8, 255),
    ('A-2412-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-22 09:51:11', '2024-12-24 12:51:11', '반려', '반려 사유입니다.', 4, 8, 256),
    ('A-2412-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-25 09:11:26', '2024-12-27 09:11:26', '승인', NULL, 4, 8, 257),
    ('A-2412-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2024-12-07 15:20:33', '2024-12-14 17:20:33', '승인', NULL, 4, 8, 258),
('A-2412-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-16 11:25:20', '2024-12-22 11:25:20', '승인', NULL, 9, 13, 588),
('A-2412-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-28 15:15:43', '2024-12-31 15:15:43', '승인', NULL, 9, 13, 589),
('A-2412-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-15 15:14:45', '2024-12-21 15:14:45', '승인', NULL, 9, 13, 590),
('A-2412-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-07 11:52:55', '2024-12-08 11:52:55', '승인', NULL, 9, 13, 591),
('A-2412-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-25 16:29:45', '2024-12-27 16:29:45', '승인', NULL, 9, 13, 592),
('A-2412-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-22 11:35:27', '2024-12-24 11:35:27', '승인', NULL, 9, 13, 593),
('A-2412-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-27 16:47:04', '2025-01-02 16:47:04', '승인', NULL, 9, 13, 594),
('A-2412-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-15 11:42:05', '2024-12-19 11:42:05', '승인', NULL, 9, 13, 595),
('A-2412-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-23 15:32:10', '2024-12-24 15:32:10', '승인', NULL, 9, 13, 596),
('A-2412-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-28 14:13:53', '2024-12-30 14:13:53', '승인', NULL, 9, 13, 597),
('A-2412-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-22 09:22:52', '2024-12-29 09:22:52', '승인', NULL, 9, 13, 598),
('A-2412-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-21 09:27:29', '2024-12-25 09:27:29', '승인', NULL, 9, 13, 599),
('A-2412-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-15 17:02:48', '2024-12-17 17:02:48', '승인', NULL, 9, 13, 600),
('A-2412-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-27 17:31:53', '2024-12-28 17:31:53', '승인', NULL, 9, 13, 601),
('A-2412-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-11 10:16:00', '2024-12-12 10:16:00', '승인', NULL, 9, 13, 602),
('A-2412-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-04 17:11:05', '2024-12-11 17:11:05', '승인', NULL, 9, 13, 603),
('A-2412-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-09 14:03:50', '2024-12-10 14:03:50', '승인', NULL, 9, 13, 604),
('A-2412-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-05 16:40:30', '2024-12-08 16:40:30', '승인', NULL, 9, 13, 605),
('A-2412-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-22 12:10:24', '2024-12-27 12:10:24', '승인', NULL, 9, 13, 606),
('A-2412-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2024-12-13 13:14:53', '2024-12-13 13:14:53', '승인', NULL, 9, 13, 607),

    ('A-2501-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-19 09:51:33', '2025-01-21 09:51:33', '승인', NULL, 4, 8, 259),
    ('A-2501-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-17 15:04:12', '2025-01-22 17:04:12', '승인', NULL, 4, 8, 260),
    ('A-2501-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-21 16:24:39', '2025-01-25 17:24:39', '승인', NULL, 4, 8, 261),
    ('A-2501-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-10 15:03:55', '2025-01-11 17:03:55', '승인', NULL, 4, 8, 262),
    ('A-2501-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-26 17:33:33', '2025-01-26 17:33:33', '승인', NULL, 4, 8, 263),
    ('A-2501-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-27 12:11:47', '2025-01-29 13:11:47', '승인', NULL, 4, 8, 264),
    ('A-2501-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-22 16:01:50', '2025-01-23 17:01:50', '승인', NULL, 4, 8, 265),
    ('A-2501-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-21 09:47:42', '2025-01-26 10:47:42', '승인', NULL, 4, 8, 266),
    ('A-2501-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-23 11:56:00', '2025-01-27 12:56:00', '반려', '반려 사유입니다.', 4, 8, 267),
    ('A-2501-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-28 14:28:21', '2025-01-30 14:28:21', '승인', NULL, 4, 8, 268),
    ('A-2501-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-04 15:48:08', '2025-01-11 17:48:08', '승인', NULL, 4, 8, 269),
    ('A-2501-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-17 10:01:15', '2025-01-22 12:01:15', '승인', NULL, 4, 8, 270),
    ('A-2501-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-10 09:13:00', '2025-01-17 11:13:00', '승인', NULL, 4, 8, 271),
    ('A-2501-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-14 15:18:11', '2025-01-16 17:18:11', '승인', NULL, 4, 8, 272),
    ('A-2501-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-10 11:09:10', '2025-01-17 14:09:10', '승인', NULL, 4, 8, 273),
    ('A-2501-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-22 14:08:12', '2025-01-26 16:08:12', '승인', NULL, 4, 8, 274),
    ('A-2501-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-13 15:18:41', '2025-01-13 15:18:41', '승인', NULL, 4, 8, 275),
    ('A-2501-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-01 09:24:30', '2025-01-08 09:24:30', '승인', NULL, 4, 8, 276),
    ('A-2501-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-13 17:56:48', '2025-01-13 17:56:48', '승인', NULL, 4, 8, 277),
    ('A-2501-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-21 10:43:15', '2025-01-27 11:43:15', '반려', '반려 사유입니다.', 4, 8, 278),
    ('A-2501-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-28 15:48:25', '2025-01-28 15:48:25', '승인', NULL, 4, 8, 279),
    ('A-2501-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-01-06 11:20:37', '2025-01-07 12:20:37', '승인', NULL, 4, 8, 280),

    ('A-2501-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-01 17:03:38', '2025-01-04 17:03:38', '승인', NULL, 9, 13, 608),
    ('A-2501-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-19 09:08:09', '2025-01-19 09:08:09', '승인', NULL, 9, 13, 609),
    ('A-2501-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-23 09:32:29', '2025-01-29 09:32:29', '승인', NULL, 9, 13, 610),
    ('A-2501-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-05 16:35:29', '2025-01-12 16:35:29', '승인', NULL, 9, 13, 611),
    ('A-2501-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-03 10:47:09', '2025-01-06 10:47:09', '승인', NULL, 9, 13, 612),
    ('A-2501-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-08 16:01:25', '2025-01-14 16:01:25', '승인', NULL, 9, 13, 613),
    ('A-2501-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-14 09:07:42', '2025-01-21 09:07:42', '승인', NULL, 9, 13, 614),
    ('A-2501-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-04 16:23:28', '2025-01-11 16:23:28', '승인', NULL, 9, 13, 615),
    ('A-2501-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-12 09:07:03', '2025-01-16 09:07:03', '승인', NULL, 9, 13, 616),
    ('A-2501-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-07 17:06:45', '2025-01-10 17:06:45', '승인', NULL, 9, 13, 617),
    ('A-2501-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-28 17:30:59', '2025-01-31 17:30:59', '승인', NULL, 9, 13, 618),
    ('A-2501-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-01 10:56:22', '2025-01-01 10:56:22', '승인', NULL, 9, 13, 619),
    ('A-2501-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-21 15:26:05', '2025-01-28 15:26:05', '승인', NULL, 9, 13, 620),
    ('A-2501-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-12 11:24:15', '2025-01-14 11:24:15', '승인', NULL, 9, 13, 621),
    ('A-2501-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-27 13:00:48', '2025-02-02 13:00:48', '승인', NULL, 9, 13, 622),
    ('A-2501-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-08 09:58:44', '2025-01-09 09:58:44', '승인', NULL, 9, 13, 623),
    ('A-2501-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-15 15:39:38', '2025-01-22 15:39:38', '승인', NULL, 9, 13, 624),
    ('A-2501-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-12 09:51:39', '2025-01-17 09:51:39', '승인', NULL, 9, 13, 625),
    ('A-2501-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-21 16:54:24', '2025-01-26 16:54:24', '승인', NULL, 9, 13, 626),
    ('A-2501-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-01-12 17:10:47', '2025-01-12 17:10:47', '승인', NULL, 9, 13, 627),
    ('A-2502-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-10 09:44:36', '2025-02-16 10:44:36', '승인', NULL, 4, 8, 281),
    ('A-2502-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-15 14:07:27', '2025-02-15 14:07:27', '승인', NULL, 4, 8, 282),
    ('A-2502-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-07 17:03:44', '2025-02-09 17:03:44', '승인', NULL, 4, 8, 283),
    ('A-2502-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-15 16:58:37', '2025-02-16 17:58:37', '승인', NULL, 4, 8, 284),
    ('A-2502-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-25 11:53:42', '2025-02-28 14:53:42', '승인', NULL, 4, 8, 285),
    ('A-2502-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-19 14:43:57', '2025-02-24 17:43:57', '승인', NULL, 4, 8, 286),
    ('A-2502-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-15 09:18:40', '2025-02-16 12:18:40', '승인', NULL, 4, 8, 287),
    ('A-2502-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-27 12:32:51', '2025-02-27 13:32:51', '승인', NULL, 4, 8, 288),
    ('A-2502-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-21 12:46:40', '2025-02-22 15:46:40', '반려', '반려 사유입니다.', 4, 8, 289),
    ('A-2502-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-23 14:55:07', '2025-02-25 14:55:07', '승인', NULL, 4, 8, 290),
    ('A-2502-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-05 11:02:34', '2025-02-10 14:02:34', '승인', NULL, 4, 8, 291),
    ('A-2502-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-27 12:11:44', '2025-02-27 14:11:44', '승인', NULL, 4, 8, 292),
    ('A-2502-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-08 12:55:50', '2025-02-08 14:55:50', '승인', NULL, 4, 8, 293),
    ('A-2502-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-16 15:54:18', '2025-02-20 15:54:18', '승인', NULL, 4, 8, 294),
    ('A-2502-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-09 14:03:36', '2025-02-16 14:03:36', '승인', NULL, 4, 8, 295),
    ('A-2502-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-27 10:30:11', '2025-03-06 10:30:11', '승인', NULL, 4, 8, 296),
    ('A-2502-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-06 17:34:24', '2025-02-07 17:34:24', '승인', NULL, 4, 8, 297),
    ('A-2502-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-12 12:30:01', '2025-02-17 14:30:01', '승인', NULL, 4, 8, 298),
    ('A-2502-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-15 14:24:15', '2025-02-18 16:24:15', '승인', NULL, 4, 8, 299),
    ('A-2502-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-09 15:47:11', '2025-02-15 17:47:11', '반려', '반려 사유입니다.', 4, 8, 300),
    ('A-2502-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-16 16:32:46', '2025-02-16 16:32:46', '승인', NULL, 4, 8, 301),
    ('A-2502-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-02-27 11:13:03', '2025-02-27 14:13:03', '승인', NULL, 4, 8, 302),
    ('A-2502-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-06 10:16:18', '2025-02-08 10:16:18', '승인', NULL, 9, 13, 628),
    ('A-2502-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-18 17:49:26', '2025-02-18 17:49:26', '승인', NULL, 9, 13, 629),
    ('A-2502-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-05 13:28:28', '2025-02-06 13:28:28', '승인', NULL, 9, 13, 630),
    ('A-2502-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-12 09:55:59', '2025-02-14 09:55:59', '승인', NULL, 9, 13, 631),
    ('A-2502-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-05 12:18:04', '2025-02-12 12:18:04', '승인', NULL, 9, 13, 632),
    ('A-2502-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-18 17:10:48', '2025-02-19 17:10:48', '승인', NULL, 9, 13, 633),
    ('A-2502-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-20 15:22:37', '2025-02-22 15:22:37', '승인', NULL, 9, 13, 634),
    ('A-2502-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-05 10:35:45', '2025-02-10 10:35:45', '승인', NULL, 9, 13, 635),
    ('A-2502-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-26 15:31:09', '2025-02-28 15:31:09', '승인', NULL, 9, 13, 636),
    ('A-2502-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-11 15:00:23', '2025-02-18 15:00:23', '승인', NULL, 9, 13, 637),
    ('A-2502-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-08 11:45:11', '2025-02-13 11:45:11', '승인', NULL, 9, 13, 638),
    ('A-2502-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-13 14:11:57', '2025-02-18 14:11:57', '승인', NULL, 9, 13, 639),
    ('A-2502-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-28 10:42:08', '2025-03-05 10:42:08', '승인', NULL, 9, 13, 640),
    ('A-2502-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-07 14:50:14', '2025-02-14 14:50:14', '승인', NULL, 9, 13, 641),
    ('A-2502-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-05 12:40:12', '2025-02-05 12:40:12', '승인', NULL, 9, 13, 642),
    ('A-2502-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-01 10:14:18', '2025-02-03 10:14:18', '승인', NULL, 9, 13, 643),
    ('A-2502-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-13 15:13:36', '2025-02-16 15:13:36', '승인', NULL, 9, 13, 644),
    ('A-2502-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-09 13:43:45', '2025-02-12 13:43:45', '승인', NULL, 9, 13, 645),
    ('A-2502-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-14 09:14:23', '2025-02-21 09:14:23', '승인', NULL, 9, 13, 646),
    ('A-2502-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-02-15 15:15:00', '2025-02-18 15:15:00', '승인', NULL, 9, 13, 647),

    ('A-2503-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-02 14:13:17', '2025-03-05 15:13:17', '승인', NULL, 4, 8, 303),
    ('A-2503-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-24 17:34:01', '2025-03-30 17:34:01', '승인', NULL, 4, 8, 304),
    ('A-2503-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-05 17:54:24', '2025-03-11 17:54:24', '승인', NULL, 4, 8, 305),
    ('A-2503-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-18 15:24:00', '2025-03-24 17:24:00', '승인', NULL, 4, 8, 306),
    ('A-2503-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-26 16:32:09', '2025-03-31 17:32:09', '승인', NULL, 4, 8, 307),
    ('A-2503-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-21 10:16:02', '2025-03-22 10:16:02', '승인', NULL, 4, 8, 308),
    ('A-2503-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-16 14:35:10', '2025-03-19 17:35:10', '승인', NULL, 4, 8, 309),
    ('A-2503-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-18 14:37:25', '2025-03-24 17:37:25', '승인', NULL, 4, 8, 310),
    ('A-2503-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-20 14:17:53', '2025-03-23 14:17:53', '반려', '반려 사유입니다.', 4, 8, 311),
    ('A-2503-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-24 10:13:04', '2025-03-24 10:13:04', '승인', NULL, 4, 8, 312),
    ('A-2503-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-10 15:14:51', '2025-03-11 17:14:51', '승인', NULL, 4, 8, 313),
    ('A-2503-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-19 17:28:39', '2025-03-21 17:28:39', '승인', NULL, 4, 8, 314),
    ('A-2503-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-06 14:17:12', '2025-03-07 14:17:12', '승인', NULL, 4, 8, 315),
    ('A-2503-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-04 09:54:19', '2025-03-09 12:54:19', '승인', NULL, 4, 8, 316),
    ('A-2503-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-27 17:07:15', '2025-04-03 17:07:15', '승인', NULL, 4, 8, 317),
    ('A-2503-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-24 16:44:58', '2025-03-27 17:44:58', '승인', NULL, 4, 8, 318),
    ('A-2503-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-17 13:30:33', '2025-03-21 13:30:33', '승인', NULL, 4, 8, 319),
    ('A-2503-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-01 16:54:05', '2025-03-03 17:54:05', '승인', NULL, 4, 8, 320),
    ('A-2503-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-21 17:16:42', '2025-03-25 17:16:42', '승인', NULL, 4, 8, 321),
    ('A-2503-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-10 15:49:46', '2025-03-12 17:49:46', '반려', '반려 사유입니다.', 4, 8, 322),
    ('A-2503-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-13 10:36:57', '2025-03-15 10:36:57', '승인', NULL, 4, 8, 323),
    ('A-2503-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-03-16 17:22:23', '2025-03-16 17:22:23', '승인', NULL, 4, 8, 324),
    ('A-2503-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-09 15:50:31', '2025-03-09 15:50:31', '승인', NULL, 9, 13, 648),
    ('A-2503-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-05 13:07:46', '2025-03-07 13:07:46', '승인', NULL, 9, 13, 649),
    ('A-2503-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-27 12:13:51', '2025-03-28 12:13:51', '승인', NULL, 9, 13, 650),
    ('A-2503-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-06 12:40:07', '2025-03-09 12:40:07', '승인', NULL, 9, 13, 651),
    ('A-2503-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-11 14:46:34', '2025-03-15 14:46:34', '승인', NULL, 9, 13, 652),
    ('A-2503-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-21 15:22:37', '2025-03-26 15:22:37', '승인', NULL, 9, 13, 653),
    ('A-2503-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-27 13:45:21', '2025-03-29 13:45:21', '승인', NULL, 9, 13, 654),
    ('A-2503-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-14 17:29:43', '2025-03-19 17:29:43', '승인', NULL, 9, 13, 655),
    ('A-2503-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-18 14:25:25', '2025-03-24 14:25:25', '승인', NULL, 9, 13, 656),
    ('A-2503-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-04 11:32:12', '2025-03-04 11:32:12', '승인', NULL, 9, 13, 657),
    ('A-2503-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-13 10:42:57', '2025-03-18 10:42:57', '승인', NULL, 9, 13, 658),
    ('A-2503-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-28 09:52:12', '2025-03-29 09:52:12', '승인', NULL, 9, 13, 659),
    ('A-2503-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-07 09:12:59', '2025-03-08 09:12:59', '승인', NULL, 9, 13, 660),
    ('A-2503-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-01 12:37:36', '2025-03-01 12:37:36', '승인', NULL, 9, 13, 661),
    ('A-2503-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-25 17:50:54', '2025-04-01 17:50:54', '승인', NULL, 9, 13, 662),
    ('A-2503-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-28 12:40:51', '2025-03-31 12:40:51', '승인', NULL, 9, 13, 663),
    ('A-2503-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-25 16:01:02', '2025-03-25 16:01:02', '승인', NULL, 9, 13, 664),
    ('A-2503-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-18 14:42:58', '2025-03-19 14:42:58', '승인', NULL, 9, 13, 665),
    ('A-2503-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-25 11:17:29', '2025-03-28 11:17:29', '승인', NULL, 9, 13, 666),
    ('A-2503-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-03-08 15:26:49', '2025-03-13 15:26:49', '승인', NULL, 9, 13, 667),


    ('A-2504-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-18 14:51:57', '2025-04-23 14:51:57', '승인', NULL, 4, 8, 325),
    ('A-2504-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-23 13:50:30', '2025-04-27 14:50:30', '승인', NULL, 4, 8, 326),
    ('A-2504-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-26 13:17:25', '2025-04-30 14:17:25', '승인', NULL, 4, 8, 327),
    ('A-2504-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-04 13:39:30', '2025-04-09 13:39:30', '승인', NULL, 4, 8, 328),
    ('A-2504-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-14 11:44:01', '2025-04-19 12:44:01', '승인', NULL, 4, 8, 329),
    ('A-2504-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-01 09:21:01', '2025-04-01 09:21:01', '승인', NULL, 4, 8, 330),
    ('A-2504-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-01 15:01:07', '2025-04-04 17:01:07', '승인', NULL, 4, 8, 331),
    ('A-2504-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-04 13:57:57', '2025-04-06 13:57:57', '승인', NULL, 4, 8, 332),
    ('A-2504-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-22 16:16:24', '2025-04-26 17:16:24', '반려', '반려 사유입니다.', 4, 8, 333),
    ('A-2504-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-27 12:01:46', '2025-04-29 12:01:46', '승인', NULL, 4, 8, 334),
    ('A-2504-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-17 11:08:26', '2025-04-18 13:08:26', '승인', NULL, 4, 8, 335),
    ('A-2504-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-08 09:49:48', '2025-04-08 10:49:48', '승인', NULL, 4, 8, 336),
    ('A-2504-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-06 10:20:12', '2025-04-13 12:20:12', '승인', NULL, 4, 8, 337),
    ('A-2504-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-05 11:40:51', '2025-04-09 11:40:51', '승인', NULL, 4, 8, 338),
    ('A-2504-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-15 15:05:34', '2025-04-18 17:05:34', '승인', NULL, 4, 8, 339),
    ('A-2504-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-25 17:28:43', '2025-04-25 17:28:43', '승인', NULL, 4, 8, 340),
    ('A-2504-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-14 12:51:16', '2025-04-20 12:51:16', '승인', NULL, 4, 8, 341),
    ('A-2504-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-14 12:52:17', '2025-04-18 12:52:17', '승인', NULL, 4, 8, 342),
    ('A-2504-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-15 11:11:27', '2025-04-20 13:11:27', '승인', NULL, 4, 8, 343),
    ('A-2504-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-14 17:41:16', '2025-04-20 17:41:16', '반려', '반려 사유입니다.', 4, 8, 344),
    ('A-2504-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-21 10:16:02', '2025-04-23 10:16:02', '승인', NULL, 4, 8, 345),
    ('A-2504-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-04-17 16:06:04', '2025-04-21 17:06:04', '승인', NULL, 4, 8, 346),
    ('A-2504-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-27 17:14:40', '2025-04-30 17:14:40', '승인', NULL, 9, 13, 668),
    ('A-2504-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-10 15:52:03', '2025-04-11 15:52:03', '승인', NULL, 9, 13, 669),
    ('A-2504-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-14 11:24:26', '2025-04-20 11:24:26', '승인', NULL, 9, 13, 670),
    ('A-2504-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-13 09:13:00', '2025-04-16 09:13:00', '승인', NULL, 9, 13, 671),
    ('A-2504-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-23 15:43:47', '2025-04-29 15:43:47', '승인', NULL, 9, 13, 672),
    ('A-2504-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-24 13:22:49', '2025-04-29 13:22:49', '승인', NULL, 9, 13, 673),
    ('A-2504-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-14 13:16:02', '2025-04-15 13:16:02', '승인', NULL, 9, 13, 674),
    ('A-2504-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-17 12:04:27', '2025-04-17 12:04:27', '승인', NULL, 9, 13, 675),
    ('A-2504-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-24 10:44:03', '2025-04-28 10:44:03', '승인', NULL, 9, 13, 676),
    ('A-2504-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-04 09:10:28', '2025-04-06 09:10:28', '승인', NULL, 9, 13, 677),
    ('A-2504-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-04 14:29:09', '2025-04-10 14:29:09', '승인', NULL, 9, 13, 678),
    ('A-2504-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-12 10:10:20', '2025-04-13 10:10:20', '승인', NULL, 9, 13, 679),
    ('A-2504-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-17 16:03:03', '2025-04-20 16:03:03', '승인', NULL, 9, 13, 680),
    ('A-2504-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-15 12:28:25', '2025-04-21 12:28:25', '승인', NULL, 9, 13, 681),
    ('A-2504-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-03 10:25:28', '2025-04-07 10:25:28', '승인', NULL, 9, 13, 682),
    ('A-2504-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-24 09:19:56', '2025-04-25 09:19:56', '승인', NULL, 9, 13, 683),
    ('A-2504-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-28 16:18:00', '2025-05-04 16:18:00', '승인', NULL, 9, 13, 684),
    ('A-2504-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-06 16:21:38', '2025-04-12 16:21:38', '승인', NULL, 9, 13, 685),
    ('A-2504-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-05 13:03:24', '2025-04-05 13:03:24', '승인', NULL, 9, 13, 686),
    ('A-2504-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-04-23 13:07:02', '2025-04-29 13:07:02', '승인', NULL, 9, 13, 687),


    ('A-2505-0001', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-01 14:03:40', '2025-05-04 15:03:40', '승인', NULL, 4, 8, 347),
    ('A-2505-0002', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-17 10:28:04', '2025-05-22 13:28:04', '승인', NULL, 4, 8, 348),
    ('A-2505-0003', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-15 15:12:37', '2025-05-17 17:12:37', '승인', NULL, 4, 8, 349),
    ('A-2505-0004', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-17 13:25:13', '2025-05-17 15:25:13', '승인', NULL, 4, 8, 350),
    ('A-2505-0005', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-24 13:25:02', '2025-05-29 16:25:02', '승인', NULL, 4, 8, 351),
    ('A-2505-0006', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-10 09:13:05', '2025-05-12 11:13:05', '승인', NULL, 4, 8, 352),
    ('A-2505-0007', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-08 13:20:59', '2025-05-09 14:20:59', '승인', NULL, 4, 8, 353),
    ('A-2505-0008', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-19 16:35:35', '2025-05-24 17:35:35', '승인', NULL, 4, 8, 354),
    ('A-2505-0009', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-28 16:16:34', '2025-05-28 17:16:34', '반려', '반려 사유입니다.', 4, 8, 355),
    ('A-2505-0010', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-29 17:28:19', '2025-05-29 17:28:19', '승인', NULL, 4, 8, 356),
    ('A-2505-0011', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-17 13:42:10', '2025-05-24 13:42:10', '승인', NULL, 4, 8, 357),
    ('A-2505-0012', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-03 17:45:44', '2025-05-03 17:45:44', '승인', NULL, 4, 8, 358),
    ('A-2505-0013', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-28 16:34:31', '2025-06-04 17:34:31', '승인', NULL, 4, 8, 359),
    ('A-2505-0014', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-13 11:18:16', '2025-05-13 11:18:16', '승인', NULL, 4, 8, 360),
    ('A-2505-0015', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-05 17:38:13', '2025-05-07 17:38:13', '승인', NULL, 4, 8, 361),
    ('A-2505-0016', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-27 16:01:54', '2025-05-27 17:01:54', '승인', NULL, 4, 8, 362),
    ('A-2505-0017', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-12 16:36:04', '2025-05-15 17:36:04', '승인', NULL, 4, 8, 363),
    ('A-2505-0018', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-21 10:08:17', '2025-05-24 12:08:17', '승인', NULL, 4, 8, 364),
    ('A-2505-0019', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-21 14:47:12', '2025-05-26 17:47:12', '승인', NULL, 4, 8, 365),
    ('A-2505-0020', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-14 09:26:12', '2025-05-14 11:26:12', '반려', '반려 사유입니다.', 4, 8, 366),
    ('A-2505-0021', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-15 14:24:57', '2025-05-15 14:24:57', '승인', NULL, 4, 8, 367),
    ('A-2505-0022', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.
첨부된 파일 : 계약서 PDF, 견적서', '2025-05-21 15:06:06', '2025-05-28 15:06:06', '승인', NULL, 4, 8, 368),
    ('A-2505-0023', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-05 09:14:16', '2025-05-10 09:14:16', '승인', NULL, 9, 13, 688),
    ('A-2505-0024', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-22 11:10:51', '2025-05-29 11:10:51', '승인', NULL, 9, 13, 689),
    ('A-2505-0025', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-25 12:55:38', '2025-05-30 12:55:38', '승인', NULL, 9, 13, 690),
    ('A-2505-0026', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-03 16:09:47', '2025-05-09 16:09:47', '승인', NULL, 9, 13, 691),
    ('A-2505-0027', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-06 17:06:41', '2025-05-13 17:06:41', '승인', NULL, 9, 13, 692),
    ('A-2505-0028', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-21 17:05:08', '2025-05-25 17:05:08', '승인', NULL, 9, 13, 693),
    ('A-2505-0029', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-09 13:28:50', '2025-05-16 13:28:50', '승인', NULL, 9, 13, 694),
    ('A-2505-0030', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-15 15:51:03', '2025-05-22 15:51:03', '승인', NULL, 9, 13, 695),
    ('A-2505-0031', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-23 09:12:43', '2025-05-26 09:12:43', '승인', NULL, 9, 13, 696),
    ('A-2505-0032', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-21 15:25:20', '2025-05-26 15:25:20', '승인', NULL, 9, 13, 697),
    ('A-2505-0033', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-10 17:23:51', '2025-05-13 17:23:51', '승인', NULL, 9, 13, 698),
    ('A-2505-0034', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-14 12:53:54', '2025-05-17 12:53:54', '승인', NULL, 9, 13, 699),
    ('A-2505-0035', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-26 15:50:38', '2025-05-30 15:50:38', '승인', NULL, 9, 13, 700),
    ('A-2505-0036', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-05 17:00:25', '2025-05-10 17:00:25', '승인', NULL, 9, 13, 701),
    ('A-2505-0037', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-18 13:27:50', '2025-05-25 13:27:50', '승인', NULL, 9, 13, 702),
    ('A-2505-0038', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-06 15:07:25', '2025-05-10 15:07:25', '승인', NULL, 9, 13, 703),
    ('A-2505-0039', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-27 14:33:43', '2025-06-03 14:33:43', '승인', NULL, 9, 13, 704),
    ('A-2505-0040', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-20 11:00:15', '2025-05-27 11:00:15', '승인', NULL, 9, 13, 705),
    ('A-2505-0041', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-07 16:54:31', '2025-05-11 16:54:31', '승인', NULL, 9, 13, 706),
    ('A-2505-0042', '결재 요청드립니다.', '신규 계약 건 결재 부탁드립니다.\n첨부된 파일 : 계약서 PDF, 견적서', '2025-05-01 10:09:37', '2025-05-08 10:09:37', '승인', NULL, 9, 13, 707);
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
INSERT INTO EMPLOYEE_GOAL (rental_product_count, rental_retention_count, total_rental_count, new_customer_count,
                           total_rental_amount, customer_feedback_score, customer_feedback_count, target_date,
                           employee_id)
VALUES (1, 381, 401, 4, 2024010, 24.2, 6, 202401, 2),
       (2, 382, 402, 5, 2024020, 28.6, 7, 202402, 2),
       (3, 383, 403, 6, 2024030, 37.3, 9, 202403, 2),
       (4, 384, 404, 7, 2024040, 41.9, 10, 202404, 2),
       (5, 385, 405, 8, 2024050, 50.9, 12, 202405, 2),
       (6, 386, 406, 9, 2024060, 55.8, 13, 202406, 2),
       (7, 387, 407, 10, 2024070, 65.1, 15, 202407, 2),
       (8, 388, 408, 11, 2024080, 70.2, 16, 202408, 2),
       (9, 389, 409, 12, 2024090, 79.9, 18, 202409, 2),
       (10, 390, 410, 13, 2024100, 85.3, 19, 202410, 2),
       (11, 391, 411, 14, 2024110, 95.3, 21, 202411, 2),
       (12, 392, 412, 15, 2024120, 101.0, 22, 202412, 2),
       (1, 481, 501, 4, 2025010, 24.2, 6, 202501, 2),
       (2, 482, 502, 5, 2025020, 28.6, 7, 202502, 2),
       (3, 483, 503, 6, 2025030, 37.3, 9, 202503, 2),
       (4, 484, 504, 7, 2025040, 41.9, 10, 202504, 2),
       (5, 485, 505, 8, 2025050, 50.9, 12, 202505, 2),
       (6, 486, 506, 9, 2025060, 55.8, 13, 202506, 2),
       (7, 487, 507, 10, 2025070, 65.1, 15, 202507, 2),
       (8, 488, 508, 11, 2025080, 70.2, 16, 202508, 2),
       (9, 489, 509, 12, 2025090, 79.9, 18, 202509, 2),
       (10, 490, 510, 13, 2025100, 85.3, 19, 202510, 2),
       (11, 491, 511, 14, 2025110, 95.3, 21, 202511, 2),
       (12, 492, 512, 15, 2025120, 101.0, 22, 202512, 2),
       (1, 381, 401, 4, 2024010, 24.2, 6, 202401, 3),
       (2, 382, 402, 5, 2024020, 28.6, 7, 202402, 3),
       (3, 383, 403, 6, 2024030, 37.3, 9, 202403, 3),
       (4, 384, 404, 7, 2024040, 41.9, 10, 202404, 3),
       (5, 385, 405, 8, 2024050, 50.9, 12, 202405, 3),
       (6, 386, 406, 9, 2024060, 55.8, 13, 202406, 3),
       (7, 387, 407, 10, 2024070, 65.1, 15, 202407, 3),
       (8, 388, 408, 11, 2024080, 70.2, 16, 202408, 3),
       (9, 389, 409, 12, 2024090, 79.9, 18, 202409, 3),
       (10, 390, 410, 13, 2024100, 85.3, 19, 202410, 3),
       (11, 391, 411, 14, 2024110, 95.3, 21, 202411, 3),
       (12, 392, 412, 15, 2024120, 101.0, 22, 202412, 3),
       (1, 481, 501, 4, 2025010, 24.2, 6, 202501, 3),
       (2, 482, 502, 5, 2025020, 28.6, 7, 202502, 3),
       (3, 483, 503, 6, 2025030, 37.3, 9, 202503, 3),
       (4, 484, 504, 7, 2025040, 41.9, 10, 202504, 3),
       (5, 485, 505, 8, 2025050, 50.9, 12, 202505, 3),
       (6, 486, 506, 9, 2025060, 55.8, 13, 202506, 3),
       (7, 487, 507, 10, 2025070, 65.1, 15, 202507, 3),
       (8, 488, 508, 11, 2025080, 70.2, 16, 202508, 3),
       (9, 489, 509, 12, 2025090, 79.9, 18, 202509, 3),
       (10, 490, 510, 13, 2025100, 85.3, 19, 202510, 3),
       (11, 491, 511, 14, 2025110, 95.3, 21, 202511, 3),
       (12, 492, 512, 15, 2025120, 101.0, 22, 202512, 3),
       (1, 381, 401, 4, 2024010, 24.2, 6, 202401, 4),
       (2, 382, 402, 5, 2024020, 28.6, 7, 202402, 4),
       (3, 383, 403, 6, 2024030, 37.3, 9, 202403, 4),
       (4, 384, 404, 7, 2024040, 41.9, 10, 202404, 4),
       (5, 385, 405, 8, 2024050, 50.9, 12, 202405, 4),
       (6, 386, 406, 9, 2024060, 55.8, 13, 202406, 4),
       (7, 387, 407, 10, 2024070, 65.1, 15, 202407, 4),
       (8, 388, 408, 11, 2024080, 70.2, 16, 202408, 4),
       (9, 389, 409, 12, 2024090, 79.9, 18, 202409, 4),
       (10, 390, 410, 13, 2024100, 85.3, 19, 202410, 4),
       (11, 391, 411, 14, 2024110, 95.3, 21, 202411, 4),
       (12, 392, 412, 15, 2024120, 101.0, 22, 202412, 4),
       (1, 481, 501, 4, 2025010, 24.2, 6, 202501, 4),
       (2, 482, 502, 5, 2025020, 28.6, 7, 202502, 4),
       (3, 483, 503, 6, 2025030, 37.3, 9, 202503, 4),
       (4, 484, 504, 7, 2025040, 41.9, 10, 202504, 4),
       (5, 485, 505, 8, 2025050, 50.9, 12, 202505, 4),
       (6, 486, 506, 9, 2025060, 55.8, 13, 202506, 4),
       (7, 487, 507, 10, 2025070, 65.1, 15, 202507, 4),
       (8, 488, 508, 11, 2025080, 70.2, 16, 202508, 4),
       (9, 489, 509, 12, 2025090, 79.9, 18, 202509, 4),
       (10, 490, 510, 13, 2025100, 85.3, 19, 202510, 4),
       (11, 491, 511, 14, 2025110, 95.3, 21, 202511, 4),
       (12, 492, 512, 15, 2025120, 101.0, 22, 202512, 4),
       (1, 381, 401, 4, 2024010, 24.2, 6, 202401, 5),
       (2, 382, 402, 5, 2024020, 28.6, 7, 202402, 5),
       (3, 383, 403, 6, 2024030, 37.3, 9, 202403, 5),
       (4, 384, 404, 7, 2024040, 41.9, 10, 202404, 5),
       (5, 385, 405, 8, 2024050, 50.9, 12, 202405, 5),
       (6, 386, 406, 9, 2024060, 55.8, 13, 202406, 5),
       (7, 387, 407, 10, 2024070, 65.1, 15, 202407, 5),
       (8, 388, 408, 11, 2024080, 70.2, 16, 202408, 5),
       (9, 389, 409, 12, 2024090, 79.9, 18, 202409, 5),
       (10, 390, 410, 13, 2024100, 85.3, 19, 202410, 5),
       (11, 391, 411, 14, 2024110, 95.3, 21, 202411, 5),
       (12, 392, 412, 15, 2024120, 101.0, 22, 202412, 5),
       (1, 481, 501, 4, 2025010, 24.2, 6, 202501, 5),
       (2, 482, 502, 5, 2025020, 28.6, 7, 202502, 5),
       (3, 483, 503, 6, 2025030, 37.3, 9, 202503, 5),
       (4, 484, 504, 7, 2025040, 41.9, 10, 202504, 5),
       (5, 485, 505, 8, 2025050, 50.9, 12, 202505, 5),
       (6, 486, 506, 9, 2025060, 55.8, 13, 202506, 5),
       (7, 487, 507, 10, 2025070, 65.1, 15, 202507, 5),
       (8, 488, 508, 11, 2025080, 70.2, 16, 202508, 5),
       (9, 489, 509, 12, 2025090, 79.9, 18, 202509, 5),
       (10, 490, 510, 13, 2025100, 85.3, 19, 202510, 5),
       (11, 491, 511, 14, 2025110, 95.3, 21, 202511, 5),
       (12, 492, 512, 15, 2025120, 101.0, 22, 202512, 5),
       (1, 381, 401, 4, 2024010, 24.2, 6, 202401, 6),
       (2, 382, 402, 5, 2024020, 28.6, 7, 202402, 6),
       (3, 383, 403, 6, 2024030, 37.3, 9, 202403, 6),
       (4, 384, 404, 7, 2024040, 41.9, 10, 202404, 6),
       (5, 385, 405, 8, 2024050, 50.9, 12, 202405, 6),
       (6, 386, 406, 9, 2024060, 55.8, 13, 202406, 6),
       (7, 387, 407, 10, 2024070, 65.1, 15, 202407, 6),
       (8, 388, 408, 11, 2024080, 70.2, 16, 202408, 6),
       (9, 389, 409, 12, 2024090, 79.9, 18, 202409, 6),
       (10, 390, 410, 13, 2024100, 85.3, 19, 202410, 6),
       (11, 391, 411, 14, 2024110, 95.3, 21, 202411, 6),
       (12, 392, 412, 15, 2024120, 101.0, 22, 202412, 6),
       (1, 481, 501, 4, 2025010, 24.2, 6, 202501, 6),
       (2, 482, 502, 5, 2025020, 28.6, 7, 202502, 6),
       (3, 483, 503, 6, 2025030, 37.3, 9, 202503, 6),
       (4, 484, 504, 7, 2025040, 41.9, 10, 202504, 6),
       (5, 485, 505, 8, 2025050, 50.9, 12, 202505, 6),
       (6, 486, 506, 9, 2025060, 55.8, 13, 202506, 6),
       (7, 487, 507, 10, 2025070, 65.1, 15, 202507, 6),
       (8, 488, 508, 11, 2025080, 70.2, 16, 202508, 6),
       (9, 489, 509, 12, 2025090, 79.9, 18, 202509, 6),
       (10, 490, 510, 13, 2025100, 85.3, 19, 202510, 6),
       (11, 491, 511, 14, 2025110, 95.3, 21, 202511, 6),
       (12, 492, 512, 15, 2025120, 101.0, 22, 202512, 6);

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
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (49, 58, 116, 14, 550804, 200, 77, 201901, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (65, 59, 66, 57, 628146, 298, 106, 201902, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (53, 72, 57, 18, 912537, 468, 21, 201903, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (51, 48, 52, 36, 257155, 145, 85, 201904, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 46, 34, 39, 350628, 383, 56, 201905, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (83, 45, 21, 15, 357998, 317, 73, 201906, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (33, 32, 80, 46, 1035764, 408, 107, 201907, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 27, 47, 11, 1017752, 332, 40, 201908, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 71, 108, 25, 1032891, 114, 66, 201909, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 24, 38, 58, 990655, 132, 36, 201910, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (67, 88, 105, 53, 1061674, 473, 19, 201911, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 79, 112, 44, 964444, 292, 80, 201912, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (63, 89, 109, 58, 494710, 161, 78, 202001, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (21, 94, 108, 16, 565714, 520, 40, 202002, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (107, 72, 68, 57, 191842, 219, 37, 202003, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 40, 84, 50, 737053, 445, 62, 202004, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 38, 95, 59, 365349, 383, 39, 202005, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (46, 83, 77, 21, 519607, 419, 14, 202006, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (60, 96, 97, 11, 863502, 174, 48, 202007, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 32, 38, 54, 817753, 529, 101, 202008, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 38, 70, 33, 846621, 65, 69, 202009, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (39, 61, 61, 46, 442943, 183, 44, 202010, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (34, 74, 34, 25, 883569, 239, 61, 202011, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (55, 91, 38, 11, 415882, 281, 67, 202012, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (99, 20, 92, 15, 707595, 499, 46, 202101, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 20, 72, 31, 190248, 544, 42, 202102, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (68, 56, 93, 24, 584542, 455, 14, 202103, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 75, 88, 36, 810556, 371, 10, 202104, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 88, 103, 45, 1099631, 156, 54, 202105, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 44, 83, 42, 1030143, 376, 72, 202106, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (88, 31, 43, 60, 617792, 439, 94, 202107, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (38, 20, 109, 59, 976019, 533, 37, 202108, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (48, 43, 48, 54, 271591, 465, 18, 202109, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 93, 108, 46, 1021003, 177, 86, 202110, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (27, 84, 120, 15, 706307, 344, 102, 202111, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (89, 91, 115, 32, 578142, 362, 45, 202112, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 67, 118, 56, 170209, 113, 35, 202201, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (30, 44, 101, 56, 672808, 479, 69, 202202, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (38, 75, 92, 30, 459582, 158, 21, 202203, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 83, 83, 38, 1088450, 69, 52, 202204, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (47, 26, 30, 28, 430255, 391, 87, 202205, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (106, 49, 60, 51, 411416, 458, 37, 202206, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (93, 54, 33, 48, 121997, 101, 47, 202207, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (101, 78, 85, 59, 260024, 100, 102, 202208, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 28, 66, 20, 228499, 111, 48, 202209, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (62, 94, 26, 38, 663029, 503, 71, 202210, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (66, 95, 36, 16, 180186, 345, 26, 202211, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 99, 20, 20, 858598, 79, 59, 202212, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 25, 118, 18, 977464, 549, 37, 202301, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (104, 90, 92, 38, 892230, 378, 13, 202302, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (77, 98, 64, 14, 957552, 214, 56, 202303, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (62, 29, 52, 34, 784563, 231, 78, 202304, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 47, 37, 36, 477507, 331, 103, 202305, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 71, 54, 20, 304627, 244, 76, 202306, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (78, 59, 119, 53, 121839, 405, 60, 202307, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (50, 42, 104, 14, 366703, 426, 22, 202308, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (104, 59, 40, 32, 253687, 167, 46, 202309, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (48, 81, 31, 52, 970204, 253, 58, 202310, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (53, 85, 43, 26, 891453, 192, 61, 202311, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 77, 92, 29, 449681, 489, 39, 202312, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 89, 92, 34, 1041416, 445, 110, 202401, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 44, 101, 41, 661007, 265, 17, 202402, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (62, 79, 66, 38, 1042826, 100, 19, 202403, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (108, 59, 67, 25, 354836, 513, 38, 202404, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (47, 78, 36, 50, 947390, 261, 82, 202405, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (57, 55, 71, 39, 395897, 209, 97, 202406, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 28, 57, 37, 972061, 393, 33, 202407, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (23, 49, 45, 37, 430256, 218, 47, 202408, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (44, 20, 48, 13, 569294, 149, 32, 202409, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 72, 40, 12, 579632, 72, 64, 202410, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (52, 43, 103, 40, 425484, 195, 40, 202411, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (15, 99, 23, 19, 740830, 480, 70, 202412, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (101, 37, 22, 33, 768963, 435, 109, 202501, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (39, 51, 93, 19, 818104, 157, 50, 202502, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (25, 27, 26, 15, 577319, 235, 43, 202503, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (61, 92, 44, 17, 774384, 391, 12, 202504, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (80, 81, 90, 12, 700448, 244, 66, 202505, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (67, 86, 110, 50, 504024, 416, 80, 202506, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (94, 67, 80, 51, 371861, 324, 58, 202507, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 34, 23, 32, 918112, 347, 12, 202508, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (80, 63, 112, 59, 394909, 308, 79, 202509, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (24, 30, 54, 40, 548273, 395, 82, 202510, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (90, 32, 26, 52, 145414, 88, 70, 202511, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 44, 54, 45, 294818, 290, 96, 202512, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (28, 28, 80, 30, 905166, 388, 10, 202601, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (83, 89, 20, 16, 320825, 496, 63, 202602, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (98, 66, 40, 48, 516267, 295, 102, 202603, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 87, 74, 34, 404608, 514, 31, 202604, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (79, 81, 120, 58, 897538, 437, 72, 202605, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (82, 72, 72, 59, 209293, 545, 11, 202606, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (107, 71, 39, 56, 691685, 135, 56, 202607, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (13, 63, 97, 56, 738316, 106, 102, 202608, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (86, 23, 110, 28, 891143, 314, 46, 202609, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (34, 51, 115, 25, 854983, 412, 109, 202610, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (47, 70, 20, 29, 255177, 83, 54, 202611, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 99, 20, 30, 578369, 121, 24, 202612, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (27, 40, 75, 23, 694567, 461, 41, 202701, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (101, 74, 94, 24, 549586, 62, 90, 202702, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (36, 39, 118, 56, 490468, 322, 46, 202703, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (103, 91, 97, 16, 189776, 318, 18, 202704, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (105, 47, 90, 11, 326498, 497, 17, 202705, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (69, 28, 52, 34, 947782, 243, 62, 202706, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (58, 46, 20, 38, 798635, 524, 92, 202707, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (41, 40, 71, 56, 365413, 409, 32, 202708, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (108, 88, 58, 27, 537919, 372, 20, 202709, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 98, 22, 52, 906112, 217, 110, 202710, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (70, 70, 97, 31, 930919, 197, 89, 202711, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (58, 85, 65, 21, 661942, 216, 74, 202712, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (26, 56, 56, 58, 760143, 56, 79, 202801, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (23, 67, 64, 25, 518579, 220, 27, 202802, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (26, 96, 67, 38, 613411, 208, 81, 202803, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (12, 36, 90, 18, 749039, 399, 30, 202804, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 71, 73, 40, 443682, 346, 84, 202805, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (98, 23, 45, 11, 610214, 212, 27, 202806, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 56, 87, 45, 828688, 341, 43, 202807, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 98, 60, 24, 167700, 50, 110, 202808, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (44, 33, 120, 54, 156231, 308, 10, 202809, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 99, 79, 21, 1083309, 501, 92, 202810, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (104, 83, 114, 23, 672563, 165, 110, 202811, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 29, 43, 46, 798227, 228, 13, 202812, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (74, 61, 49, 22, 1041584, 393, 20, 202901, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (12, 75, 37, 51, 976888, 80, 22, 202902, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (92, 99, 59, 14, 306617, 413, 97, 202903, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (13, 32, 51, 57, 274456, 157, 51, 202904, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (55, 32, 53, 23, 285545, 335, 39, 202905, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (42, 78, 71, 48, 407691, 519, 25, 202906, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (83, 77, 111, 59, 454485, 321, 26, 202907, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (110, 79, 66, 44, 495148, 381, 47, 202908, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (30, 89, 63, 41, 710849, 535, 29, 202909, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (43, 56, 111, 27, 554442, 368, 92, 202910, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (68, 66, 48, 40, 755124, 248, 25, 202911, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (87, 31, 107, 46, 269853, 117, 10, 202912, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (81, 44, 79, 14, 217617, 538, 58, 203001, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 28, 65, 36, 652570, 289, 82, 203002, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (10, 69, 90, 16, 866680, 484, 43, 203003, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 57, 21, 54, 956849, 544, 62, 203004, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (96, 97, 96, 26, 581970, 378, 102, 203005, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (23, 38, 44, 60, 222891, 391, 23, 203006, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (21, 42, 36, 47, 925897, 131, 74, 203007, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (45, 100, 110, 27, 849200, 350, 43, 203008, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (93, 59, 57, 38, 602428, 235, 105, 203009, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (72, 20, 86, 59, 997466, 85, 35, 203010, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (94, 52, 36, 33, 673245, 285, 101, 203011, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (59, 76, 35, 52, 1004404, 270, 64, 203012, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (95, 82, 38, 30, 922484, 170, 11, 203101, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (10, 64, 44, 53, 296928, 495, 36, 203102, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (40, 59, 101, 40, 320055, 283, 26, 203103, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (75, 65, 84, 43, 1086071, 354, 26, 203104, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (56, 63, 92, 35, 508615, 321, 42, 203105, 2);
# INSERT INTO employee_goal (rental_product_count, rental_retention_count, total_rental_count, new_customer_count, total_rental_amount, customer_feedback_score, customer_feedback_count, target_date, employee_id) VALUES (51, 48, 116, 36, 773754, 269, 44, 203106, 2);

COMMIT;
