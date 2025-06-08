-- Use created database
USE levelcDB;
GO

-- Create Functions table
CREATE TABLE Functions (
    X INT,
    Y INT
);

-- Insert sample data into Functions
INSERT INTO Functions (X, Y) VALUES
(20, 20),
(20, 20),
(20, 21),
(23, 22),
(22, 23),
(21, 20);

-- Solution Query
SELECT DISTINCT
    F1.X,
    F1.Y
FROM
    Functions F1
JOIN
    Functions F2 ON F1.X = F2.Y AND F1.Y = F2.X
WHERE
    F1.X < F1.Y 
    OR (F1.X = F1.Y AND F1.X <= F2.X AND F1.Y <= F2.Y AND F1.X = F2.X) 
ORDER BY
    F1.X ASC;
