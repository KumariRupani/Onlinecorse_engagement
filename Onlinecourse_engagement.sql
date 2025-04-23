-- Use the youtube database (if it exists)
USE youtube;

-- Insert new sample data into Users table (avoiding duplicates)
INSERT INTO Users (user_name, email, registration_date)
VALUES 
('Alice', 'alice_new@example.com', '2023-01-01'),
('Bob', 'bob_new@example.com', '2023-01-05'),
('Charlie', 'charlie_new@example.com', '2023-02-01');

-- Insert sample data into Courses table (if not already inserted)
INSERT INTO Courses (course_name, course_category)
VALUES 
('Introduction to Programming', 'Programming'),
('Business 101', 'Business'),
('Health and Wellness', 'Health');

-- Insert sample data into Engagement table
INSERT INTO Engagement (user_id, course_id, course_completion, time_spent_on_course, number_of_videos_watched, number_of_quizzes_taken, completion_rate)
VALUES
(1, 1, 1, 120, 15, 5, 100),
(2, 2, 0, 60, 5, 2, 50),
(3, 3, 1, 180, 12, 4, 100),
(1, 2, 1, 200, 25, 8, 100),
(2, 3, 1, 150, 10, 3, 75);

-- Insert sample data into Quizzes table
INSERT INTO Quizzes (engagement_id, quiz_score)
VALUES
(1, 80),
(2, 70),
(3, 90),
(4, 85),
(5, 75);

-- Query 1: Identify the Course Category with the Most Completions
SELECT
    c.course_category,
    COUNT(e.course_id) AS number_of_completions
FROM
    Engagement e
JOIN
    Courses c ON e.course_id = c.course_id
WHERE
    e.course_completion = 1
GROUP BY
    c.course_category
ORDER BY
    number_of_completions DESC;

-- Query 2: Identify the Course Category with the Most Time Spent
SELECT
    c.course_category,
    SUM(e.time_spent_on_course) AS total_time_spent
FROM
    Engagement e
JOIN
    Courses c ON e.course_id = c.course_id
GROUP BY
    c.course_category
ORDER BY
    total_time_spent DESC;

-- Query 3: Find the Course with the Most Videos Watched
SELECT
    c.course_name,
    SUM(e.number_of_videos_watched) AS total_videos_watched
FROM
    Engagement e
JOIN
    Courses c ON e.course_id = c.course_id
GROUP BY
    c.course_name
ORDER BY
    total_videos_watched DESC;

-- Query 4: Find the Users with the Highest Quiz Scores in Each Course
SELECT
    e.user_id,
    c.course_name,
    q.quiz_score
FROM
    Quizzes q
JOIN
    Engagement e ON q.engagement_id = e.engagement_id
JOIN
    Courses c ON e.course_id = c.course_id
WHERE
    (SELECT COUNT(*) FROM Quizzes q2 
     WHERE q2.engagement_id = q.engagement_id AND q2.quiz_score >= q.quiz_score) = 1;

-- Query 5: Find the Average Completion Rate by Course Category
SELECT
    c.course_category,
    AVG(e.completion_rate) AS average_completion_rate
FROM
    Engagement e
JOIN
    Courses c ON e.course_id = c.course_id
GROUP BY
    c.course_category
ORDER BY
    average_completion_rate DESC;

