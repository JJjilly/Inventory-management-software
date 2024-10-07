DROP DATABASE IF EXISTS `Inventory_bins`;
CREATE DATABASE `Inventory_bins`;
USE `Inventory_bins`;

-- Table: Workers
CREATE TABLE Workers (
    worker_id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100),
    gender ENUM ('M', 'F'),
    birth_date DATE,
    pin VARCHAR(10) NOT NULL, -- Personal PIN for each worker
    is_active BOOLEAN DEFAULT TRUE, -- To activate or deactivate a worker
	is_admin boolean default false
);

-- Table: Categories (e.g., Electrical or Mechanical)
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Table: Subcategories (e.g., Bolts, Wires)
CREATE TABLE Subcategories (
    subcategory_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL, -- Foreign key from Categories
    subcategory_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Table: Piece (e.g., specific types of bolts, wires)
CREATE TABLE Piece (
    Piece_id INT PRIMARY KEY,
    bin_id INT NOT NULL,
    subcategory_id INT default 0, -- Foreign key from Subcategories
    Piece_name VARCHAR(100) default 0, -- E.g., Bolts with specific girth, length
    Supplier Varchar(50) NOT NULL,
    quantity INT NOT NULL -- Total quantity available
    /*FOREIGN KEY (subcategory_id) REFERENCES Subcategories(subcategory_id)*/

);

-- Table: Bins (Warehouse bin data)
CREATE TABLE Bins (
    bin_id INT AUTO_INCREMENT PRIMARY KEY,
    bin_number INT UNIQUE NOT NULL, -- Unique identifier for each bin
    Piece_id INT NOT NULL, -- Foreign key to Piece
    FOREIGN KEY (Piece_id) REFERENCES Piece(Piece_id)
);

-- Table: Transactions (to track what each worker takes or leaves)
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    worker_id INT NOT NULL, -- Foreign key to Workers
    Piece_id INT NOT NULL, -- Foreign key to Piece
    bin_id INT NOT NULL, -- Foreign key to Bins
    action ENUM('take', 'leave') NOT NULL, -- Whether they are taking or leaving Piece
    quantity INT NOT NULL, -- How many pieces taken or left
    transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Time of transaction
    FOREIGN KEY (worker_id) REFERENCES Workers(worker_id),
    FOREIGN KEY (Piece_id) REFERENCES Piece(Piece_id),
    FOREIGN KEY (bin_id) REFERENCES Bins(bin_id)
);

-- Table: Managers (track manager-specific operations)
CREATE TABLE Managers (
    manager_id INT AUTO_INCREMENT PRIMARY KEY,
    worker_id INT NOT NULL, -- Foreign key to Workers
    can_add_worker BOOLEAN DEFAULT TRUE,
    can_remove_worker BOOLEAN DEFAULT TRUE,
    can_modify_quantity BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (worker_id) REFERENCES Workers(worker_id)
);



INSERT INTO Workers (worker_id, name, surname, gender, birth_date,pin, is_admin)
VALUES
(0,'Chris', 'BORG', 'M','1979-09-25', '2002', '1'),
(2, 'demeris','BORG' ,'M', '1998-05-29','1990', '0' ),
(3, 'Chris','mech' ,'M', '1998-05-29', '1902', '0' ),
(4, 'arnel','kik' ,'M', '2098-05-29','2004', '0' ),
(5, 'Jason','KRIK' ,'M', '8992-05-29', '1980', '0' );