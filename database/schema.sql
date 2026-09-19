
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
        ON DELETE CASCADE
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
SELECT university_id, 'Science'
FROM universities
WHERE short_name = 'WITS';

INSERT INTO faculties (university_id, name)
SELECT university_id, 'Humanities'
FROM universities
WHERE short_name = 'WITS';

INSERT INTO faculties (university_id, name)
SELECT university_id, 'Health Sciences'
FROM universities
WHERE short_name = 'WITS';

INSERT INTO faculties (university_id, name)
SELECT university_id, 'Commerce, Law and Management'
FROM universities
WHERE short_name = 'WITS';

INSERT INTO faculties (university_id, name)
SELECT university_id, 'Engineering'
FROM universities
WHERE short_name = 'WITS';


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
