
-- USERS


CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);



--  STUDENTS


CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL UNIQUE,

    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    surname VARCHAR(100) NOT NULL,

    identity_type VARCHAR(30) NOT NULL,
    identity_number VARCHAR(50) NOT NULL UNIQUE,

    date_of_birth DATE,
    school VARCHAR(255),
    province VARCHAR(100),
    phone VARCHAR(30),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_students_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id),

    CONSTRAINT ck_students_identity_type
        CHECK (identity_type IN ('ID_NO', 'PASSPORT'))
);



--  SUBJECTS


CREATE TABLE subjects (
    subject_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);



-- STUDENT MARKS


CREATE TABLE student_marks (
    student_mark_id SERIAL PRIMARY KEY,

    student_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,

    percentage DECIMAL(5,2) NOT NULL,
    grade INTEGER,

    CONSTRAINT fk_student_marks_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_student_marks_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id),

    CONSTRAINT uq_student_marks_student_subject
        UNIQUE (student_id, subject_id),

    CONSTRAINT ck_student_marks_percentage
        CHECK (percentage >= 0 AND percentage <= 100),

    CONSTRAINT ck_student_marks_grade
        CHECK (grade >= 1 AND grade <= 7)
);


-- UNIVERSITIES


CREATE TABLE universities (
    university_id SERIAL PRIMARY KEY,

    name VARCHAR(255) NOT NULL,
    short_name VARCHAR(50),
    province VARCHAR(100),
    website VARCHAR(500),

    aps_method VARCHAR(50)
);


-- FACULTIES


CREATE TABLE faculties (
    faculty_id SERIAL PRIMARY KEY,
    university_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,

    CONSTRAINT fk_faculties_university
        FOREIGN KEY (university_id)
        REFERENCES universities(university_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_faculties_university_name
        UNIQUE (university_id, name)
);



--  PROGRAMMES


CREATE TABLE programmes (
    programme_id SERIAL PRIMARY KEY,

    faculty_id INTEGER NOT NULL,

    name VARCHAR(255) NOT NULL,
    degree_type VARCHAR(100) NOT NULL,
    duration_years INTEGER NOT NULL,

    CONSTRAINT fk_programmes_faculty
        FOREIGN KEY (faculty_id)
        REFERENCES faculties(faculty_id)
        ON DELETE CASCADE
);



-- PROGRAMME REQUIREMENTS


CREATE TABLE programme_requirements (
    requirement_id SERIAL PRIMARY KEY,

    programme_id INTEGER NOT NULL,
    subject_id INTEGER,

    requirement_type VARCHAR(50) NOT NULL,

    minimum_percentage DECIMAL(5,2),
    minimum_aps INTEGER,

    is_mandatory BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_requirements_programme
        FOREIGN KEY (programme_id)
        REFERENCES programmes(programme_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_requirements_subject
        FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id),

    CONSTRAINT ck_requirements_percentage
        CHECK (
            minimum_percentage IS NULL
            OR (
                minimum_percentage >= 0
                AND minimum_percentage <= 100
            )
        ),

    CONSTRAINT ck_requirements_aps
        CHECK (
            minimum_aps IS NULL
            OR minimum_aps >= 0
        )
);



--APPLICATIONS


CREATE TABLE applications (
    application_id SERIAL PRIMARY KEY,

    student_id INTEGER NOT NULL,
    programme_id INTEGER NOT NULL,

    status VARCHAR(50) NOT NULL DEFAULT 'draft',

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_applications_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_applications_programme
        FOREIGN KEY (programme_id)
        REFERENCES programmes(programme_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_applications_student_programme
        UNIQUE (student_id, programme_id)
);



-- DOCUMENTS


CREATE TABLE documents (
    document_id SERIAL PRIMARY KEY,

    student_id INTEGER NOT NULL,

    document_type VARCHAR(50) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_url VARCHAR(500) NOT NULL,

    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_documents_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE
);



-- APPLICATION DOCUMENTS


CREATE TABLE application_documents (
    application_id INTEGER NOT NULL,
    document_id INTEGER NOT NULL,

    CONSTRAINT pk_application_documents
        PRIMARY KEY (application_id, document_id),

    CONSTRAINT fk_application_documents_application
        FOREIGN KEY (application_id)
        REFERENCES applications(application_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_application_documents_document
        FOREIGN KEY (document_id)
        REFERENCES documents(document_id)
        ON DELETE CASCADE
);

--Adding faculties
INSERT INTO faculties (university_id, name)
SELECT university_id, faculty_name
FROM universities
CROSS JOIN (
    VALUES
        ('Science'),
        ('Humanities'),
        ('Health Sciences'),
        ('Commerce, Law and Management'),
        ('Engineering')
) AS faculty_list(faculty_name);


--wits(science)

INSERT INTO programmes (
    faculty_id,
    name,
    degree_type,
    duration_years
)
SELECT
    faculty_id,
    'Actuarial Science',
    'BSc',
    3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'WITS'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Applied Chemistry', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Astronomy and Astrophysics', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Science (General)', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Computational and Applied Mathematics', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Computer Science', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

-- WITS (HUMANITIES PROGRAMMES)


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Arts (BA)', 'BA', 3
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Digital Arts', 'BA Digital Arts', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Film and Television', 'BAFT', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Fine Arts', 'BAFA', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Music', 'BMus', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

--wits health sciences

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Dental Science', 'BDS', 5
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Medicine and Surgery', 'MBBCh', 6
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Nursing', 'BNurs', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Pharmacy', 'BPharm', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Biomedical Sciences', 'BHSc', 3
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');





-- wits (commerce, law and management)
INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Laws (LLB)', 'LLB', 4
FROM faculties
WHERE name = 'Commerce and Law Management'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Accounting', 'BCom', 3
FROM faculties
WHERE name = 'Commerce and Law Management'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Economic Science', 'BEconSc', 3
FROM faculties
WHERE name = 'Commerce and Law Management'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Accounting Science', 'BAccSc', 3
FROM faculties
WHERE name = 'Commerce and Law Management'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Information Systems', 'BCom', 3
FROM faculties
WHERE name = 'Commerce and Law Management'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

--wits (engineering)

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Aeronautical Engineering', 'BSc (Eng)', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Chemical Engineering', 'BSc (Eng)', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Civil Engineering', 'BSc (Eng)', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Electrical Engineering', 'BSc (Eng)', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Mechanical Engineering', 'BSc (Eng)', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (SELECT university_id FROM universities WHERE short_name = 'WITS');




-- UCT DATA FROM HERE


-- UCT - SCIENCE PROGRAMMES


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Astrophysics', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Computer Science', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Geology', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );


-- UCT - ENGINEERING PROGRAMMES


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Architectural Studies', 'BAS', 3
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Chemical Engineering', 'BSc(Eng)', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Geomatics: Surveying Stream', 'BSc(Geomatics)', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );




-- UCT - HEALTH SCIENCES PROGRAMMES


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Medicine and Surgery', 'MBChB', 6
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Physiotherapy', 'BSc(Physiotherapy)', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Occupational Therapy', 'BSc(OT)', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );



-- UCT - COMMERCE PROGRAMMES


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Financial Accounting: Chartered Accountant stream', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Economics and Finance', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Information Systems', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

-- UCT - HUMANITIES PROGRAMMES


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Arts (General)', 'BA', 3
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Music', 'BMus', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Fine Art', 'BA (Fine Art)', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UCT'
  );


-- UP - SCIENCE 


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Actuarial and Financial Mathematics', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Ecology', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Chemistry', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );



-- UP - ENGINEERING 


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Architecture', 'BSc', 3
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Civil Engineering', 'BEng', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Computer Science', 'BSc', 3
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );



-- UP - HEALTH SCIENCES 


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Medicine and Surgery', 'MBChB', 6
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Nursing Science', 'BNurs', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Occupational Therapy', 'BOT', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );



-- UP - COMMERCE, LAW   
-- 

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Commerce (General)', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Accounting Sciences', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Investment Management', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );



-- UP  HUMANITIES 


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Arts (General)', 'BA', 3
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Fine Arts', 'BA', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Speech-Language Pathology', 'BA', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'UP'
  );



-- STELLENBOSCH - SCIENCE 
=

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Chemistry', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Physics', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Computer Science', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );



-- STELLENBOSCH - ENGINEERING 


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Civil Engineering', 'BEng', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Mechanical Engineering', 'BEng', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Electrical and Electronic Engineering', 'BEng', 4
FROM faculties
WHERE name = 'Engineering'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );



-- STELLENBOSCH - HEALTH SCIENCES 


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Medicine and Surgery', 'MBChB', 6
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Nursing', 'Bachelor of Nursing', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Physiotherapy', 'BSc', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );


-- STELLENBOSCH - COMMERCE, LAW   


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Economic Sciences', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Accounting', 'BAcc', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Management Sciences', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );



-- STELLENBOSCH - HUMANITIES 


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Humanities (General)', 'BA', 3
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Music', 'BMus', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Visual Arts', 'BA', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id FROM universities WHERE short_name = 'SU'
  );



-- UWC - SCIENCE


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BSc Biodiversity and Conservation Biology', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BSc Computer Science', 'BSc', 3
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Pharmacy', 'BPharm', 4
FROM faculties
WHERE name = 'Science'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );



-- UWC - HUMANITIES


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Arts (BA)', 'BA', 3
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BA Extended Curriculum Programme', 'BA', 4
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Theology (Full-Time)', 'BTh', 3
FROM faculties
WHERE name = 'Humanities'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );



-- UWC - HEALTH SCIENCES


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'Bachelor of Nursing', 'BNurs', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BSc Occupational Therapy', 'BSc (OT)', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BSc Physiotherapy', 'BSc (Physiotherapy)', 4
FROM faculties
WHERE name = 'Health Sciences'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );


-- UWC - COMMERCE, LAW AND MANAGEMENT


INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BCom Accounting', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BCom Information Systems', 'BCom', 3
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );

INSERT INTO programmes (faculty_id, name, degree_type, duration_years)
SELECT faculty_id, 'BCom (4-year Stream)', 'BCom', 4
FROM faculties
WHERE name = 'Commerce, Law and Management'
  AND university_id = (
      SELECT university_id
      FROM universities
      WHERE short_name = 'UWC'
  );



WITH requirements(
    university,
    programme,
    requirement_type,
    subject_name,
    minimum_percentage,
    minimum_score,
    score_type
) AS (

    VALUES

    -- =========================================================
    -- WITS
    -- =========================================================

    -- Science
    ('WITS','Actuarial Science','SCORE',NULL,NULL,44,'APS'),
    ('WITS','Actuarial Science','SUBJECT','English Home Language',80,NULL,NULL),
    ('WITS','Actuarial Science','SUBJECT','Mathematics',80,NULL,NULL),
    ('WITS','Actuarial Science','SUBJECT','Physical Sciences',80,NULL,NULL),

    ('WITS','Applied Chemistry','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Applied Chemistry','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Applied Chemistry','SUBJECT','Mathematics',70,NULL,NULL),
    ('WITS','Applied Chemistry','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('WITS','Astronomy and Astrophysics','SCORE',NULL,NULL,43,'APS'),
    ('WITS','Astronomy and Astrophysics','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Astronomy and Astrophysics','SUBJECT','Mathematics',70,NULL,NULL),
    ('WITS','Astronomy and Astrophysics','SUBJECT','Physical Sciences',70,NULL,NULL),

    ('WITS','Bachelor of Science (General)','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Bachelor of Science (General)','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Bachelor of Science (General)','SUBJECT','Mathematics',60,NULL,NULL),

    ('WITS','Computational and Applied Mathematics','SCORE',NULL,NULL,44,'APS'),
    ('WITS','Computational and Applied Mathematics','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Computational and Applied Mathematics','SUBJECT','Mathematics',70,NULL,NULL),

    ('WITS','Computer Science','SCORE',NULL,NULL,44,'APS'),
    ('WITS','Computer Science','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Computer Science','SUBJECT','Mathematics',70,NULL,NULL),

    -- Humanities
    ('WITS','Bachelor of Arts (BA)','SCORE',NULL,NULL,36,'APS'),
    ('WITS','Bachelor of Arts (BA)','SUBJECT','English Home Language',60,NULL,NULL),

    ('WITS','Digital Arts','SCORE',NULL,NULL,36,'APS'),
    ('WITS','Digital Arts','SUBJECT','English Home Language',60,NULL,NULL),

    ('WITS','Film and Television','SCORE',NULL,NULL,34,'APS'),
    ('WITS','Film and Television','SUBJECT','English Home Language',60,NULL,NULL),

    ('WITS','Fine Arts','SCORE',NULL,NULL,34,'APS'),
    ('WITS','Fine Arts','SUBJECT','English Home Language',60,NULL,NULL),

    ('WITS','Bachelor of Music','SCORE',NULL,NULL,34,'APS'),
    ('WITS','Bachelor of Music','SUBJECT','English Home Language',60,NULL,NULL),

    -- Health Sciences
    ('WITS','Dental Science','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Dental Science','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Dental Science','SUBJECT','Life Sciences',60,NULL,NULL),
    ('WITS','Dental Science','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('WITS','Medicine and Surgery','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Medicine and Surgery','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Medicine and Surgery','SUBJECT','Life Sciences',60,NULL,NULL),

    ('WITS','Nursing','SUBJECT','English Home Language',50,NULL,NULL),
    ('WITS','Nursing','SUBJECT','Mathematics',50,NULL,NULL),
    ('WITS','Nursing','SUBJECT','Life Sciences',50,NULL,NULL),

    ('WITS','Pharmacy','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Pharmacy','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Pharmacy','SUBJECT','Life Sciences',60,NULL,NULL),

    ('WITS','Biomedical Sciences','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Biomedical Sciences','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Biomedical Sciences','SUBJECT','Life Sciences',60,NULL,NULL),

    -- Commerce, Law and Management
    ('WITS','Bachelor of Laws (LLB)','SCORE',NULL,NULL,46,'APS'),
    ('WITS','Bachelor of Laws (LLB)','SUBJECT','English Home Language',70,NULL,NULL),
    ('WITS','Bachelor of Laws (LLB)','SUBJECT','Mathematics',50,NULL,NULL),

    ('WITS','Accounting','SCORE',NULL,NULL,38,'APS'),
    ('WITS','Accounting','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Accounting','SUBJECT','Mathematics',60,NULL,NULL),

    ('WITS','Economic Science','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Economic Science','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Economic Science','SUBJECT','Mathematics',80,NULL,NULL),

    ('WITS','Accounting Science','SCORE',NULL,NULL,44,'APS'),
    ('WITS','Accounting Science','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Accounting Science','SUBJECT','Mathematics',70,NULL,NULL),

    ('WITS','Information Systems','SCORE',NULL,NULL,38,'APS'),
    ('WITS','Information Systems','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Information Systems','SUBJECT','Mathematics',60,NULL,NULL),

    -- Engineering
    ('WITS','Aeronautical Engineering','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Aeronautical Engineering','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Aeronautical Engineering','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Aeronautical Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('WITS','Chemical Engineering','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Chemical Engineering','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Chemical Engineering','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Chemical Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('WITS','Civil Engineering','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Civil Engineering','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Civil Engineering','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Civil Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('WITS','Electrical Engineering','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Electrical Engineering','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Electrical Engineering','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Electrical Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('WITS','Mechanical Engineering','SCORE',NULL,NULL,42,'APS'),
    ('WITS','Mechanical Engineering','SUBJECT','English Home Language',60,NULL,NULL),
    ('WITS','Mechanical Engineering','SUBJECT','Mathematics',60,NULL,NULL),
    ('WITS','Mechanical Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),


    -- =========================================================
    -- UCT
    -- =========================================================

    -- Science
    ('UCT','Astrophysics','SCORE',NULL,NULL,550,'FPS'),
    ('UCT','Astrophysics','SUBJECT','Mathematics',70,NULL,NULL),
    ('UCT','Astrophysics','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('UCT','Computer Science','SCORE',NULL,NULL,550,'FPS'),
    ('UCT','Computer Science','SUBJECT','Mathematics',70,NULL,NULL),
    ('UCT','Computer Science','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('UCT','Geology','SCORE',NULL,NULL,550,'FPS'),
    ('UCT','Geology','SUBJECT','Mathematics',70,NULL,NULL),
    ('UCT','Geology','SUBJECT','Physical Sciences',60,NULL,NULL),

    -- Engineering
    ('UCT','Architectural Studies','SCORE',NULL,NULL,348,'FPS'),
    ('UCT','Architectural Studies','SUBJECT','Mathematics',50,NULL,NULL),
    ('UCT','Architectural Studies','SUBJECT','English Home Language',50,NULL,NULL),

    ('UCT','Chemical Engineering','SCORE',NULL,NULL,420,'FPS'),
    ('UCT','Chemical Engineering','SUBJECT','Mathematics',80,NULL,NULL),
    ('UCT','Chemical Engineering','SUBJECT','Physical Sciences',70,NULL,NULL),

    ('UCT','Geomatics: Surveying Stream','SCORE',NULL,NULL,390,'FPS'),
    ('UCT','Geomatics: Surveying Stream','SUBJECT','Mathematics',65,NULL,NULL),
    ('UCT','Geomatics: Surveying Stream','SUBJECT','Physical Sciences',60,NULL,NULL),

    -- Health Sciences
    ('UCT','Medicine and Surgery','SCORE',NULL,NULL,450,'FPS'),
    ('UCT','Medicine and Surgery','SUBJECT','English Home Language',65,NULL,NULL),
    ('UCT','Medicine and Surgery','SUBJECT','Mathematics',70,NULL,NULL),
    ('UCT','Medicine and Surgery','SUBJECT','Physical Sciences',70,NULL,NULL),
    ('UCT','Medicine and Surgery','BEST_SUBJECT',NULL,70,NULL,NULL),
    ('UCT','Medicine and Surgery','BEST_SUBJECT',NULL,70,NULL,NULL),
    ('UCT','Medicine and Surgery','BEST_SUBJECT',NULL,70,NULL,NULL),

    ('UCT','Physiotherapy','SCORE',NULL,NULL,360,'FPS'),
    ('UCT','Physiotherapy','SUBJECT','English Home Language',65,NULL,NULL),
    ('UCT','Physiotherapy','SUBJECT','Mathematics',60,NULL,NULL),
    ('UCT','Physiotherapy','SUBJECT','Physical Sciences',65,NULL,NULL),
    ('UCT','Physiotherapy','BEST_SUBJECT',NULL,60,NULL,NULL),
    ('UCT','Physiotherapy','BEST_SUBJECT',NULL,60,NULL,NULL),
    ('UCT','Physiotherapy','BEST_SUBJECT',NULL,60,NULL,NULL),

    ('UCT','Occupational Therapy','SCORE',NULL,NULL,340,'FPS'),
    ('UCT','Occupational Therapy','SUBJECT','English Home Language',65,NULL,NULL),
    ('UCT','Occupational Therapy','SUBJECT','Mathematics',60,NULL,NULL),
    ('UCT','Occupational Therapy','SUBJECT','Physical Sciences',65,NULL,NULL),
    ('UCT','Occupational Therapy','BEST_SUBJECT',NULL,60,NULL,NULL),
    ('UCT','Occupational Therapy','BEST_SUBJECT',NULL,60,NULL,NULL),
    ('UCT','Occupational Therapy','BEST_SUBJECT',NULL,60,NULL,NULL),

    -- Commerce
    ('UCT','Financial Accounting: Chartered Accountant stream','SCORE',NULL,NULL,430,'FPS'),
    ('UCT','Financial Accounting: Chartered Accountant stream','SUBJECT','Mathematics',60,NULL,NULL),
    ('UCT','Financial Accounting: Chartered Accountant stream','SUBJECT','English Home Language',50,NULL,NULL),

    ('UCT','Economics and Finance','SCORE',NULL,NULL,430,'FPS'),
    ('UCT','Economics and Finance','SUBJECT','Mathematics',60,NULL,NULL),
    ('UCT','Economics and Finance','SUBJECT','English Home Language',50,NULL,NULL),

    ('UCT','Information Systems','SCORE',NULL,NULL,430,'FPS'),
    ('UCT','Information Systems','SUBJECT','Mathematics',60,NULL,NULL),
    ('UCT','Information Systems','SUBJECT','English Home Language',50,NULL,NULL),

    -- Humanities
    ('UCT','Bachelor of Arts (General)','SCORE',NULL,NULL,380,'FPS'),
    ('UCT','Bachelor of Arts (General)','SUBJECT','English Home Language',50,NULL,NULL),

    ('UCT','Music','SCORE',NULL,NULL,380,'FPS'),
    ('UCT','Music','SUBJECT','English Home Language',50,NULL,NULL),

    ('UCT','Fine Art','SCORE',NULL,NULL,380,'FPS'),
    ('UCT','Fine Art','SUBJECT','English Home Language',50,NULL,NULL),


    -- =========================================================
    -- UP
    -- =========================================================

    -- Science
    ('UP','Actuarial and Financial Mathematics','SCORE',NULL,NULL,36,'APS'),
    ('UP','Actuarial and Financial Mathematics','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Actuarial and Financial Mathematics','SUBJECT','Mathematics',80,NULL,NULL),

    ('UP','Ecology','SCORE',NULL,NULL,32,'APS'),
    ('UP','Ecology','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Ecology','SUBJECT','Mathematics',60,NULL,NULL),
    ('UP','Ecology','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('UP','Chemistry','SCORE',NULL,NULL,34,'APS'),
    ('UP','Chemistry','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Chemistry','SUBJECT','Mathematics',60,NULL,NULL),
    ('UP','Chemistry','SUBJECT','Physical Sciences',60,NULL,NULL),

    -- Engineering
    ('UP','Architecture','SCORE',NULL,NULL,30,'APS'),
    ('UP','Architecture','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Architecture','SUBJECT','Mathematics',50,NULL,NULL),
    ('UP','Architecture','SUBJECT','Physical Sciences',50,NULL,NULL),

    ('UP','Civil Engineering','SCORE',NULL,NULL,35,'APS'),
    ('UP','Civil Engineering','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Civil Engineering','SUBJECT','Mathematics',70,NULL,NULL),
    ('UP','Civil Engineering','SUBJECT','Physical Sciences',70,NULL,NULL),

    ('UP','Computer Science','SCORE',NULL,NULL,30,'APS'),
    ('UP','Computer Science','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Computer Science','SUBJECT','Mathematics',70,NULL,NULL),

    -- Health Sciences
    ('UP','Medicine and Surgery','SCORE',NULL,NULL,35,'APS'),
    ('UP','Medicine and Surgery','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Medicine and Surgery','SUBJECT','Mathematics',70,NULL,NULL),
    ('UP','Medicine and Surgery','SUBJECT','Physical Sciences',60,NULL,NULL),

    ('UP','Nursing Science','SCORE',NULL,NULL,28,'APS'),
    ('UP','Nursing Science','SUBJECT','English Home Language',50,NULL,NULL),
    ('UP','Nursing Science','SUBJECT','Mathematics',50,NULL,NULL),
    ('UP','Nursing Science','SUBJECT','Life Sciences',50,NULL,NULL),

    ('UP','Occupational Therapy','SCORE',NULL,NULL,30,'APS'),
    ('UP','Occupational Therapy','SUBJECT','English Home Language',50,NULL,NULL),
    ('UP','Occupational Therapy','SUBJECT','Mathematics',50,NULL,NULL),
    ('UP','Occupational Therapy','SUBJECT','Physical Sciences',50,NULL,NULL),

    -- Commerce
    ('UP','Bachelor of Commerce (General)','SCORE',NULL,NULL,30,'APS'),
    ('UP','Bachelor of Commerce (General)','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Bachelor of Commerce (General)','SUBJECT','Mathematics',50,NULL,NULL),

    ('UP','Accounting Sciences','SCORE',NULL,NULL,34,'APS'),
    ('UP','Accounting Sciences','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Accounting Sciences','SUBJECT','Mathematics',70,NULL,NULL),

    ('UP','Investment Management','SCORE',NULL,NULL,34,'APS'),
    ('UP','Investment Management','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Investment Management','SUBJECT','Mathematics',70,NULL,NULL),

    -- Humanities
    ('UP','Bachelor of Arts (General)','SCORE',NULL,NULL,30,'APS'),
    ('UP','Bachelor of Arts (General)','SUBJECT','English Home Language',60,NULL,NULL),

    ('UP','Fine Arts','SCORE',NULL,NULL,30,'APS'),
    ('UP','Fine Arts','SUBJECT','English Home Language',60,NULL,NULL),

    ('UP','Speech-Language Pathology','SCORE',NULL,NULL,32,'APS'),
    ('UP','Speech-Language Pathology','SUBJECT','English Home Language',60,NULL,NULL),
    ('UP','Speech-Language Pathology','SUBJECT','Mathematics',50,NULL,NULL),


    -- =========================================================
    -- STELLENBOSCH
    -- =========================================================

    -- Science
    ('SU','Chemistry','SCORE',NULL,NULL,65,'NSC_AGGREGATE'),
    ('SU','Chemistry','SUBJECT','English Home Language',50,NULL,NULL),
    ('SU','Chemistry','SUBJECT','Mathematics',70,NULL,NULL),
    ('SU','Chemistry','SUBJECT','Physical Sciences',50,NULL,NULL),

    ('SU','Physics','SCORE',NULL,NULL,65,'NSC_AGGREGATE'),
    ('SU','Physics','SUBJECT','English Home Language',50,NULL,NULL),
    ('SU','Physics','SUBJECT','Mathematics',70,NULL,NULL),
    ('SU','Physics','SUBJECT','Physical Sciences',50,NULL,NULL),

    ('SU','Computer Science','SCORE',NULL,NULL,65,'NSC_AGGREGATE'),
    ('SU','Computer Science','SUBJECT','English Home Language',50,NULL,NULL),
    ('SU','Computer Science','SUBJECT','Mathematics',70,NULL,NULL),
    ('SU','Computer Science','SUBJECT','Physical Sciences',50,NULL,NULL),

    -- Engineering
    ('SU','Civil Engineering','SCORE',NULL,NULL,70,'NSC_AGGREGATE'),
    ('SU','Civil Engineering','SUBJECT','Mathematics',70,NULL,NULL),
    ('SU','Civil Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),
    ('SU','Civil Engineering','SUBJECT','English Home Language',50,NULL,NULL),

    ('SU','Mechanical Engineering','SCORE',NULL,NULL,70,'NSC_AGGREGATE'),
    ('SU','Mechanical Engineering','SUBJECT','Mathematics',70,NULL,NULL),
    ('SU','Mechanical Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),
    ('SU','Mechanical Engineering','SUBJECT','English Home Language',50,NULL,NULL),

    ('SU','Electrical and Electronic Engineering','SCORE',NULL,NULL,70,'NSC_AGGREGATE'),
    ('SU','Electrical and Electronic Engineering','SUBJECT','Mathematics',70,NULL,NULL),
    ('SU','Electrical and Electronic Engineering','SUBJECT','Physical Sciences',60,NULL,NULL),
    ('SU','Electrical and Electronic Engineering','SUBJECT','English Home Language',50,NULL,NULL),

    -- Health Sciences
    ('SU','Medicine and Surgery','SCORE',NULL,NULL,75,'NSC_AGGREGATE'),
    ('SU','Medicine and Surgery','SUBJECT','Mathematics',60,NULL,NULL),
    ('SU','Medicine and Surgery','SUBJECT','Physical Sciences',50,NULL,NULL),
    ('SU','Medicine and Surgery','SUBJECT','Life Sciences',50,NULL,NULL),

    ('SU','Nursing','SCORE',NULL,NULL,60,'NSC_AGGREGATE'),
    ('SU','Nursing','SUBJECT','Mathematics',40,NULL,NULL),
    ('SU','Nursing','SUBJECT','Life Sciences',50,NULL,NULL),

    ('SU','Physiotherapy','SCORE',NULL,NULL,60,'NSC_AGGREGATE'),
    ('SU','Physiotherapy','SUBJECT','Mathematics',60,NULL,NULL),
    ('SU','Physiotherapy','SUBJECT','Physical Sciences',50,NULL,NULL),

    -- Commerce
    ('SU','Economic Sciences','SCORE',NULL,NULL,65,'NSC_AGGREGATE'),
    ('SU','Economic Sciences','SUBJECT','Mathematics',60,NULL,NULL),
    ('SU','Economic Sciences','SUBJECT','English Home Language',50,NULL,NULL),

    ('SU','Accounting','SCORE',NULL,NULL,70,'NSC_AGGREGATE'),
    ('SU','Accounting','SUBJECT','Mathematics',70,NULL,NULL),
    ('SU','Accounting','SUBJECT','English Home Language',50,NULL,NULL),

    ('SU','Management Sciences','SCORE',NULL,NULL,65,'NSC_AGGREGATE'),
    ('SU','Management Sciences','SUBJECT','Mathematics',60,NULL,NULL),
    ('SU','Management Sciences','SUBJECT','English Home Language',50,NULL,NULL),

    -- Humanities
    ('SU','Humanities (general)','SCORE',NULL,NULL,63,'NSC_AGGREGATE'),
    ('SU','Humanities (general)','SUBJECT','English Home Language',50,NULL,NULL),
    ('SU','Humanities (general)','SUBJECT','Afrikaans First Additional Language',40,NULL,NULL),

    ('SU','Music','SCORE',NULL,NULL,60,'NSC_AGGREGATE'),
    ('SU','Music','SUBJECT','English Home Language',50,NULL,NULL),
    ('SU','Music','SUBJECT','Afrikaans First Additional Language',40,NULL,NULL),

    ('SU','Visual Arts','SCORE',NULL,NULL,60,'NSC_AGGREGATE'),
    ('SU','Visual Arts','SUBJECT','English Home Language',50,NULL,NULL),
    ('SU','Visual Arts','SUBJECT','Afrikaans First Additional Language',40,NULL,NULL),


    -- =========================================================
    -- UWC
    -- =========================================================

    -- Commerce, Law and Management
    ('UWC','BCom Accounting','SCORE',NULL,NULL,30,'UWC_POINTS'),
    ('UWC','BCom Accounting','SUBJECT','Mathematics',50,NULL,NULL),
    ('UWC','BCom Accounting','SUBJECT','Accounting',60,NULL,NULL),

    ('UWC','BCom Information Systems','SCORE',NULL,NULL,30,'UWC_POINTS'),
    ('UWC','BCom Information Systems','SUBJECT','Mathematics',50,NULL,NULL),

    ('UWC','BCom 4-year stream','SCORE',NULL,NULL,30,'UWC_POINTS'),
    ('UWC','BCom 4-year stream','SUBJECT','Mathematics',30,NULL,NULL),

    -- Health Sciences
    ('UWC','Bachelor of Nursing','SCORE',NULL,NULL,30,'UWC_POINTS'),
    ('UWC','Bachelor of Nursing','SUBJECT','Mathematics',50,NULL,NULL),
    ('UWC','Bachelor of Nursing','SUBJECT','Life Sciences',50,NULL,NULL),

    ('UWC','BSc Occupational Therapy','SCORE',NULL,NULL,33,'UWC_POINTS'),

    ('UWC','BSc Physiotherapy','SCORE',NULL,NULL,39,'UWC_POINTS'),

    ('UWC','Bachelor of Pharmacy','SCORE',NULL,NULL,38,'UWC_POINTS'),

    -- Humanities
    ('UWC','BA','SCORE',NULL,NULL,35,'UWC_POINTS'),
    ('UWC','BA','SUBJECT','English Home Language',50,NULL,NULL),

    ('UWC','BA Extended Curriculum Programme','SCORE',NULL,NULL,32,'UWC_POINTS'),

    ('UWC','Bachelor of Theology','SCORE',NULL,NULL,35,'UWC_POINTS'),
    ('UWC','Bachelor of Theology','SUBJECT','English Home Language',50,NULL,NULL),

    -- Science
    ('UWC','BSc Biodiversity and Conservation Biology','SCORE',NULL,NULL,33,'UWC_POINTS'),
    ('UWC','BSc Biodiversity and Conservation Biology','SUBJECT','Mathematics',50,NULL,NULL),
    ('UWC','BSc Biodiversity and Conservation Biology','SUBJECT','Physical Sciences',50,NULL,NULL),

    ('UWC','BSc Computer Science','SCORE',NULL,NULL,33,'UWC_POINTS'),
    ('UWC','BSc Computer Science','SUBJECT','Mathematics',60,NULL,NULL)

)

INSERT INTO programme_requirements (
    programme_id,
    subject_id,
    requirement_type,
    minimum_percentage,
    minimum_score,
    score_type,
    is_mandatory
)

SELECT
    p.programme_id,
    s.subject_id,
    r.requirement_type,
    r.minimum_percentage,
    r.minimum_score,
    r.score_type,
    TRUE

FROM requirements r

JOIN programmes p
    ON p.name = r.programme

JOIN faculties f
    ON f.faculty_id = p.faculty_id

JOIN universities u
    ON u.university_id = f.university_id
    AND u.short_name = r.university

LEFT JOIN subjects s
    ON s.name = r.subject_name;
