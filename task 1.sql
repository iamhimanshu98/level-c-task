-- Use created database
USE levelcDB;
GO

-- Create the Projects table
CREATE TABLE Projects (
    Task_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE
);
GO

-- Insert sample data
INSERT INTO Projects (Task_ID, Start_Date, End_Date) VALUES
(1, '2015-10-01', '2015-10-02'),
(2, '2015-10-02', '2015-10-03'),
(3, '2015-10-03', '2015-10-04'),
(4, '2015-10-13', '2015-10-14'),
(5, '2015-10-14', '2015-10-15'),
(6, '2015-10-28', '2015-10-29'),
(7, '2015-10-30', '2015-10-31');
GO

-- Solution Query
WITH TaskGroups AS (
    SELECT
        Start_Date,
        End_Date,
        ROW_NUMBER() OVER (ORDER BY Start_Date) AS rn,
        DATEADD(day, -ROW_NUMBER() OVER (ORDER BY Start_Date), Start_Date) AS GroupingKey
    FROM
        Projects
)
SELECT
    MIN(Start_Date) AS Project_Start_Date,
    MAX(End_Date) AS Project_End_Date
FROM
    TaskGroups
GROUP BY
    GroupingKey
ORDER BY
    DATEDIFF(day, MIN(Start_Date), MAX(End_Date)) ASC, -- Order by completion days
    MIN(Start_Date) ASC; -- Then by start date
GO










