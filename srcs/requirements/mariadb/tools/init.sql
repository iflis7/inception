-- Create a new database
-- CREATE DATABASE IF NOT EXISTS mydatabase;

-- Switch to the new database
-- USE mydatabase;

-- Create a new table (example)
-- CREATE TABLE IF NOT EXISTS users (
--    id INT AUTO_INCREMENT PRIMARY KEY,
--    username VARCHAR(255) NOT NULL,
--    password VARCHAR(255) NOT NULL,
--    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- Create a new user and grant privileges
-- CREATE USER 'hsaadi'@'%' IDENTIFIED BY 'root123';
-- GRANT ALL PRIVILEGES ON mydatabase.* TO 'hsaadi'@'%';

-- Flush privileges to ensure they are applied
-- FLUSH PRIVILEGES;

FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'hsaadi'@'%' IDENTIFIED BY 'root123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'hsaadi'@'%';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123';
