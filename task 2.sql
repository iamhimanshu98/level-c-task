-- Use created database
USE levelcDB;
GO

-- Create Students table
CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Insert sample data into Students
INSERT INTO Students (ID, Name) VALUES
(1, 'Ashley'),
(2, 'Samantha'),
(3, 'Julia'),
(4, 'Scarlet');

-- Create Friends table
CREATE TABLE Friends (
    ID INT PRIMARY KEY,
    Friend_ID INT
);

-- Insert sample data into Friends
INSERT INTO Friends (ID, Friend_ID) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 1);

-- Create Packages table
CREATE TABLE Packages (
    ID INT PRIMARY KEY,
    Salary DECIMAL(18, 2)
);

-- Insert sample data into Packages
INSERT INTO Packages (ID, Salary) VALUES
(1, 15.20),
(2, 10.06),
(3, 11.55),
(4, 12.12);

-- Solution Query
SELECT
    S.Name
FROM
    Students S
JOIN
    Friends F ON S.ID = F.ID -- Join student to their friend
JOIN
    Packages P_Student ON S.ID = P_Student.ID -- Get student's salary
JOIN
    Packages P_Friend ON F.Friend_ID = P_Friend.ID -- Get friend's salary
WHERE
    P_Friend.Salary > P_Student.Salary -- Condition: friend's salary is higher 
ORDER BY
    P_Friend.Salary ASC; -- Order by friend's salary
