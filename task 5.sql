-- Use created database
USE levelcDB;
GO

-- Create Hackers table
CREATE TABLE Hackers (
    hacker_id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Insert sample data into Hackers
INSERT INTO Hackers (hacker_id, name) VALUES
(15758, 'Rose'),
(20703, 'Angela'),
(36396, 'Frank'),
(38289, 'Patrick'),
(44065, 'Lisa'),
(53473, 'Kimberly'),
(62529, 'Bonnie'),
(79722, 'Michael');

-- Create Submissions table
CREATE TABLE Submissions (
    submission_date DATE,
    submission_id INT PRIMARY KEY,
    hacker_id INT,
    score INT
);

-- Insert sample data into Submissions
INSERT INTO Submissions (submission_date, submission_id, hacker_id, score) VALUES
('2016-03-01', 8494, 20703, 0),
('2016-03-01', 22403, 53473, 15),
('2016-03-01', 23965, 79722, 60),
('2016-03-01', 30173, 36396, 70),
('2016-03-02', 34928, 20703, 0),
('2016-03-02', 38740, 15758, 60),
('2016-03-02', 42769, 79722, 25),
('2016-03-02', 44364, 79722, 60),
('2016-03-03', 45440, 20703, 0),
('2016-03-03', 49050, 36396, 70),
('2016-03-03', 50273, 79722, 5),
('2016-03-04', 50344, 20703, 0),
('2016-03-04', 51360, 44065, 90),
('2016-03-04', 54404, 53473, 65),
('2016-03-04', 61533, 79722, 45),
('2016-03-05', 72852, 20703, 0),
('2016-03-05', 74546, 38289, 0),
('2016-03-05', 76487, 62529, 0),
('2016-03-05', 82439, 36396, 10),
('2016-03-05', 90006, 36396, 40),
('2016-03-06', 90404, 20703, 0);

-- Solution Query
WITH DailySubmissions AS (
    SELECT
        submission_date,
        hacker_id,
        COUNT(submission_id) AS total_daily_submissions
    FROM
        Submissions
    GROUP BY
        submission_date,
        hacker_id
),
RankedDailySubmissions AS (
    SELECT
        submission_date,
        hacker_id,
        total_daily_submissions,
        RANK() OVER (PARTITION BY submission_date ORDER BY total_daily_submissions DESC, hacker_id ASC) as rnk
    FROM
        DailySubmissions
),
CumulativeHackers AS (
    SELECT DISTINCT
        S1.submission_date,
        S1.hacker_id
    FROM
        Submissions S1
    WHERE S1.submission_date >= '2016-03-01' -- Contest start date 
)
SELECT
    RDS.submission_date,
    COUNT(DISTINCT CH.hacker_id) AS unique_hackers_count,
    RDS.hacker_id,
    H.name
FROM
    RankedDailySubmissions RDS
JOIN
    Hackers H ON RDS.hacker_id = H.hacker_id
JOIN
    CumulativeHackers CH ON CH.submission_date <= RDS.submission_date -- Condition for cumulative count
WHERE
    RDS.rnk = 1 -- Select the top hacker for each day 
GROUP BY
    RDS.submission_date,
    RDS.hacker_id,
    H.name
ORDER BY
    RDS.submission_date ASC; -- Order by date