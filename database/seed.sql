--Creating subjects to populate table before demo
INSERT INTO subjects (name)
VALUES
    ('Mathematics'),
    ('Mathematical Literacy'),
    ('English Home Language'),
    ('Afrikaans First Additional Language'),
    ('isiZulu First Additional Language'),
    ('Life Sciences'),
    ('Physical Sciences'),
    ('Computer Applications Technology'),
    ('Information Technology'),
    ('Accounting'),
    ('Business Studies'),
    ('History'),
    ('Geography');

--Inserting unis into table
INSERT INTO universities (
    name,
    short_name,
    province,
    website,
    aps_method
)
VALUES
    (
        'University of the Witwatersrand',
        'WITS',
        'Gauteng',
        'https://www.wits.ac.za/',
        'WITS'
    ),
    (
        'University of Cape Town',
        'UCT',
        'Western Cape',
        'https://uct.ac.za/',
        'UCT'
    ),
    (
        'University of Pretoria',
        'UP',
        'Gauteng',
        'https://www.up.ac.za/',
        'UP'
    ),
    (
        'Stellenbosch University',
        'SU',
        'Western Cape',
        'https://www.su.ac.za/en',
        'STELLENBOSCH'
    ),
    (
        'University of the Western Cape',
        'UWC',
        'Western Cape',
        'https://www.uwc.ac.za/',
        'UWC'
    );
