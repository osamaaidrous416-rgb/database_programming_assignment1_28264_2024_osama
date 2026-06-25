CREATE DATABASE StudentManagementDB;
GO

USE StudentManagementDB;
GO

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Department VARCHAR(50)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Students VALUES
(1,'Ali','Computer Science'),
(2,'Sara','Information Technology'),
(3,'John','Computer Science'),
(4,'Amina','Business'),
(5,'David','Information Technology');

INSERT INTO Courses VALUES
(101,'Database Programming',3),
(102,'Mathematics',4),
(103,'Networking',3);

INSERT INTO Enrollments VALUES
(1,1,101,85),
(2,1,102,90),
(3,2,101,78),
(4,2,103,88),
(5,3,101,92),
(6,3,102,80),
(7,4,103,70),
(8,5,102,95);

WITH HighGrades AS
(
    SELECT *
    FROM Enrollments
    WHERE Grade >= 85
)
SELECT * FROM HighGrades;

WITH AverageGrades AS
(
    SELECT StudentID, AVG(Grade) AS AvgGrade
    FROM Enrollments
    GROUP BY StudentID
),
TopStudents AS
(
    SELECT *
    FROM AverageGrades
    WHERE AvgGrade >= 85
)
SELECT * FROM TopStudents;

WITH Numbers AS
(
    SELECT 1 AS Num
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num < 10
)
SELECT *
FROM Numbers
OPTION (MAXRECURSION 10);

WITH DepartmentAverage AS
(
    SELECT S.Department,
           AVG(E.Grade) AS AverageGrade
    FROM Students S
    JOIN Enrollments E
        ON S.StudentID = E.StudentID
    GROUP BY S.Department
)
SELECT * FROM DepartmentAverage;

WITH StudentCourseInfo AS
(
    SELECT S.StudentName,
           C.CourseName,
           E.Grade
    FROM Students S
    JOIN Enrollments E
        ON S.StudentID = E.StudentID
    JOIN Courses C
        ON E.CourseID = C.CourseID
)
SELECT * FROM StudentCourseInfo;

SELECT StudentID,
       Grade,
       ROW_NUMBER() OVER (ORDER BY Grade DESC) AS RowNum
FROM Enrollments;

SELECT StudentID,
       Grade,
       RANK() OVER (ORDER BY Grade DESC) AS RankNum
FROM Enrollments;

SELECT StudentID,
       Grade,
       DENSE_RANK() OVER (ORDER BY Grade DESC) AS DenseRankNum
FROM Enrollments;

SELECT StudentID,
       Grade,
       PERCENT_RANK() OVER (ORDER BY Grade) AS PercentRankValue
FROM Enrollments;

SELECT StudentID,
       Grade,
       SUM(Grade) OVER () AS TotalGrades
FROM Enrollments;

SELECT StudentID,
       Grade,
       AVG(Grade) OVER () AS AverageGrade
FROM Enrollments;

SELECT StudentID,
       Grade,
       MIN(Grade) OVER () AS MinimumGrade
FROM Enrollments;

SELECT StudentID,
       Grade,
       MAX(Grade) OVER () AS MaximumGrade
FROM Enrollments;

SELECT StudentID,
       Grade,
       LAG(Grade) OVER (ORDER BY Grade) AS PreviousGrade
FROM Enrollments;

SELECT StudentID,
       Grade,
       LEAD(Grade) OVER (ORDER BY Grade) AS NextGrade
FROM Enrollments;

SELECT StudentID,
       Grade,
       NTILE(4) OVER (ORDER BY Grade DESC) AS Quartile
FROM Enrollments;

SELECT StudentID,
       Grade,
       CUME_DIST() OVER (ORDER BY Grade) AS CumulativeDistribution
FROM Enrollments;