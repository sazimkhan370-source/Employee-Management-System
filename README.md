# Employee Management System

A beginner-friendly mini-project demonstrating a full-stack CRUD web application.

## Project Structure
- `database.sql`: Oracle PL/SQL table creation, sequences, triggers, and stored procedures.
- `app.py`: Flask API backend routing request calls directly to PL/SQL procedures.
- `index.html`: Responsive single-page dashboard built with HTML5, CSS3, and Vanilla JavaScript.

## Setup Instructions

1. **Database Setup**:
   Execute `database.sql` in Oracle SQL Developer or Live SQL to create the schema and stored procedures.

2. **Backend Setup**:
   - Install required packages: `pip install flask flask-cors oracledb`
   - Update database credentials (`DB_USER`, `DB_PASS`, `DB_DSN`) in `app.py`.
   - Run the server: `python app.py`

3. **Frontend Setup**:
   Open `index.html` in any modern browser.
