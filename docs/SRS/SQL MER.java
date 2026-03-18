-- 1. Tabla User_Role
CREATE TABLE User_Role (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 2. Tabla Project_Type
CREATE TABLE Project_Type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 3. Tabla Working_Teams
CREATE TABLE Working_Teams (
    team_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 4. Tabla Metodology
CREATE TABLE Metodology (
    metodology_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 5. Tabla User
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    team_id INT,
    role_id INT,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (team_id) REFERENCES Working_Teams(team_id),
    FOREIGN KEY (role_id) REFERENCES User_Role(role_id)
);

-- 6. Tabla Project
CREATE TABLE Project (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    type_id INT,
    team_id INT,
    metodology_id INT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    budget DECIMAL(12,2),
    FOREIGN KEY (type_id) REFERENCES Project_Type(type_id),
    FOREIGN KEY (team_id) REFERENCES Working_Teams(team_id),
    FOREIGN KEY (metodology_id) REFERENCES Metodology(metodology_id)
);