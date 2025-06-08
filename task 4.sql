-- Use created database
USE levelcDB;
GO

-- Create Contests table
CREATE TABLE Contests (
    contest_id INT PRIMARY KEY,
    hacker_id INT,
    name VARCHAR(100)
);

-- Insert sample data into Contests
INSERT INTO Contests (contest_id, hacker_id, name) VALUES
(66406, 17973, 'Rose'),
(66556, 79153, 'Angela'),
(94828, 80275, 'Frank');

-- Create Colleges table
CREATE TABLE Colleges (
    college_id INT PRIMARY KEY,
    contest_id INT
);

-- Insert sample data into Colleges
INSERT INTO Colleges (college_id, contest_id) VALUES
(11219, 66406),
(32473, 66556),
(56685, 94828);

-- Create Challenges table
CREATE TABLE Challenges (
    challenge_id INT PRIMARY KEY,
    college_id INT
);

-- Insert sample data into Challenges
INSERT INTO Challenges (challenge_id, college_id) VALUES
(18765, 11219),
(47127, 11219),
(60292, 32473),
(72974, 56685);

-- Create View_Stats table
CREATE TABLE View_Stats (
    challenge_id INT,
    total_views INT,
    total_unique_views INT
);

-- Insert sample data into View_Stats
INSERT INTO View_Stats (challenge_id, total_views, total_unique_views) VALUES
(47127, 26, 19),
(47127, 15, 14),
(18765, 43, 10),
(18765, 72, 13),
(75516, 35, 17),
(60292, 11, 10),
(72974, 41, 15),
(75516, 75, 11);

-- Create Submission_Stats table
CREATE TABLE Submission_Stats (
    challenge_id INT,
    total_submissions INT,
    total_accepted_submissions INT
);

-- Insert sample data into Submission_Stats
INSERT INTO Submission_Stats (challenge_id, total_submissions, total_accepted_submissions) VALUES
(75516, 34, 12),
(47127, 27, 10),
(47127, 56, 18),
(75516, 74, 12),
(75516, 83, 8),
(72974, 68, 24),
(72974, 82, 14),
(47127, 28, 11);

-- Solution Query
SELECT
    C.contest_id,
    C.hacker_id,
    C.name,
    SUM(ISNULL(SS.total_submissions, 0)) AS total_submissions_sum,
    SUM(ISNULL(SS.total_accepted_submissions, 0)) AS total_accepted_submissions_sum,
    SUM(ISNULL(VS.total_views, 0)) AS total_views_sum,
    SUM(ISNULL(VS.total_unique_views, 0)) AS total_unique_views_sum
FROM
    Contests C
JOIN
    Colleges CO ON C.contest_id = CO.contest_id
JOIN
    Challenges CH ON CO.college_id = CH.college_id
LEFT JOIN
    View_Stats VS ON CH.challenge_id = VS.challenge_id
LEFT JOIN
    Submission_Stats SS ON CH.challenge_id = SS.challenge_id
GROUP BY
    C.contest_id,
    C.hacker_id,
    C.name
HAVING
    SUM(ISNULL(SS.total_submissions, 0)) > 0 OR
    SUM(ISNULL(SS.total_accepted_submissions, 0)) > 0 OR
    SUM(ISNULL(VS.total_views, 0)) > 0 OR
    SUM(ISNULL(VS.total_unique_views, 0)) > 0
ORDER BY
    C.contest_id;

