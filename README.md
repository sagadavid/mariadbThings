# mariadbThings
SQL Workout Project

Welcome to the SQL Workout Project — a hands-on learning resource for practicing SQL queries in MySQL/MariaDB environments. This project is perfect for learners and professionals looking to strengthen their SQL querying, database design, and schema manipulation skills using real-world data like the classic world database.

⸻

🧰 Requirements
	•	MySQL or MariaDB installed
	•	world sample database loaded (Get it here)
	•	SQL client: MySQL CLI, DBeaver, MySQL Workbench, or similar

⸻

📁 Structure of the Workout

1. World Database Exploration
	•	Selecting databases and tables
	•	Basic SELECT queries from city, country, and language
	•	Filtering with WHERE, LIKE, IN, BETWEEN
	•	Sorting and limiting results

2. Joins
	•	LEFT JOIN and INNER JOIN with filtering
	•	JOIN on population and language conditions
	•	DISTINCT selections and advanced filtering

3. Aggregate Functions & Grouping
	•	SUM, MIN, MAX, AVG, COUNT
	•	Grouping with GROUP BY, filtering with HAVING

4. Subqueries and CTEs
	•	Subqueries in WHERE and FROM
	•	Common Table Expressions (CTEs) with WITH

5. Set Operations
	•	UNION, INTERSECT, and EXCEPT
	•	Comparison with JOIN operations

6. Creating & Managing a Custom Database
	•	Creating a new database testing
	•	Creating tables with various data types
	•	Virtual columns and default values

7. Insert, Update, Delete
	•	Multiple forms of INSERT
	•	UPDATE with SET, REPLACE
	•	DELETE with filters and ON DELETE CASCADE

8. Schema Evolution
	•	ALTER TABLE: Add, modify, rename, drop columns
	•	Describing and viewing table structures
	•	Renaming and dropping tables

9. Constraints & Keys
	•	PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK
	•	Index inspection and modification

10. Database Management
	•	Creating, showing, altering, and dropping databases
	•	Viewing available engines and metadata

11. Stored Procedures
	•	Example of procedure creation (commented out)
	•	Using control flow inside procedures

⸻

📝 Example Topics Practiced
	•	SQL Data Retrieval
	•	Table Joins
	•	Data Aggregation & Grouping
	•	Table Creation and Alteration
	•	Advanced Filtering
	•	Subqueries and CTEs
	•	Keys and Constraints
	•	Stored Procedures

⸻

🔧 Getting Started

mysql -u root -p
source world.sql;
source workout.sql;


⸻

📜 License

This repository is open for educational use.

⸻

🤝 Contributions

Feel free to fork this repo, suggest improvements, or add new exercises!

⸻

📫 Contact

For questions or feedback, open an issue or submit a pull request.

⸻

Happy Querying! 🧠💻
