-- 1. Create Employees Table
CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    department VARCHAR2(50) NOT NULL,
    salary NUMBER(10, 2) NOT NULL,
    hire_date DATE DEFAULT SYSDATE
);

-- 2. Create Sequence and Trigger for Auto-Incrementing ID
CREATE SEQUENCE emp_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_emp_id
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT emp_seq.NEXTVAL INTO :NEW.id FROM DUAL;
    END IF;
END;
/

-- 3. Stored Procedure: Create/Add New Employee
CREATE OR REPLACE PROCEDURE add_employee (
    p_name IN employees.name%TYPE,
    p_email IN employees.email%TYPE,
    p_dept IN employees.department%TYPE,
    p_salary IN employees.salary%TYPE
) AS
BEGIN
    INSERT INTO employees (name, email, department, salary)
    VALUES (p_name, p_email, p_dept, p_salary);
    COMMIT;
END add_employee;
/

-- 4. Stored Procedure: Read/Fetch All Employees (Returns a SYS_REFCURSOR)
CREATE OR REPLACE PROCEDURE get_all_employees (
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
        SELECT id, name, email, department, salary, TO_CHAR(hire_date, 'YYYY-MM-DD') AS hire_date
        FROM employees
        ORDER BY id DESC;
END get_all_employees;
/

-- 5. Stored Procedure: Delete Employee by ID
CREATE OR REPLACE PROCEDURE delete_employee (
    p_id IN employees.id%TYPE
) AS
BEGIN
    DELETE FROM employees WHERE id = p_id;
    COMMIT;
END delete_employee;
/
