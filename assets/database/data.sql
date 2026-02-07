-- Create the database
CREATE DATABASE IF NOT EXISTS web_design_records;
USE web_design_records;

-- Table for team members (users)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    image_path VARCHAR(255), -- Path to profile image
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data for team members (based on the HTML)
INSERT INTO users (name, role, image_path, bio) VALUES
('Jean Bundalian', 'Research Writer', 'assets/images/Jean Bundalian III.jpg', 'Responsible for research and documentation.'),
('Ashly Montalvo', 'Capstone Project Leader', 'assets/images/Ashly Montalvo.jpg', 'Leads the project development.'),
('Rashmir Gemoto', 'Developer & Author', 'assets/images/Rashmir Gemoto.jpg', 'Handles coding and authoring.'),
('Eduard Damaso', 'Member', 'assets/images/Eduard Damaso.jpg', 'Contributes to project tasks.'),
('Jaynard Andaya', 'Member', 'assets/images/Jaynard Andaya.jpg', 'Assists in various project aspects.');

-- Table for projects (web design projects recorded in the system)
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    image_path VARCHAR(255), -- Path to project image
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    created_by INT, -- Foreign key to users.id
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert sample projects (based on features/portfolio in HTML)
INSERT INTO projects (title, description, image_path, status, created_by) VALUES
('E-Commerce Website', 'A responsive e-commerce site with modern UI/UX design.', 'assets/images/project1.jpg', 'published', 3),
('Portfolio Template', 'A customizable portfolio template for designers.', 'assets/images/project2.jpg', 'published', 3),
('Blog Platform', 'A dynamic blog platform with interactive features.', 'assets/images/project3.jpg', 'draft', 2);

-- Table for tutorials/features (comprehensive database of tutorials and guides)
CREATE TABLE tutorials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    category ENUM('diagnostics', 'database', 'collaboration', 'general') DEFAULT 'general',
    author_id INT, -- Foreign key to users.id
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert sample tutorials (based on features in HTML)
INSERT INTO tutorials (title, content, category, author_id) VALUES
('Advanced Diagnostics Guide', 'Utilize AI-powered tools for precise issue identification and instant solutions.', 'diagnostics', 1),
('Comprehensive Database Tutorial', 'Access an extensive library of fixes, tutorials, and maintenance guides.', 'database', 1),
('Collaborative Platform Tips', 'Connect with experts and peers for shared knowledge and support.', 'collaboration', 2);

-- Table for downloads/publications (to track app downloads or publications)
CREATE TABLE downloads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(255) NOT NULL, -- Path to downloadable file
    description TEXT,
    is_published BOOLEAN DEFAULT FALSE, -- Flag for publication status
    uploaded_by INT, -- Foreign key to users.id
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Insert sample download (for the app mentioned in HTML)
INSERT INTO downloads (file_name, file_path, description, is_published, uploaded_by) VALUES
('Web Designing Record System App', 'assets/downloads/app.zip', 'The full application for recording web design projects.', FALSE, 3);

-- Table for logs (to record system activities, e.g., project views, downloads)
CREATE TABLE activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT, -- Foreign key to users.id (nullable for anonymous)
    action VARCHAR(255) NOT NULL, -- e.g., 'viewed_project', 'downloaded_app'
    details TEXT,
    ip_address VARCHAR(45),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Sample log entry
INSERT INTO activity_logs (user_id, action, details) VALUES
(3, 'downloaded_app', 'Attempted download of Web Designing Record System App.');

-- Optional: Create indexes for better performance
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_tutorials_category ON tutorials(category);
CREATE INDEX idx_downloads_published ON downloads(is_published);
CREATE INDEX idx_logs_timestamp ON activity_logs(timestamp);