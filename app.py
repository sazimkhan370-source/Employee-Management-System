from flask import Flask, request, jsonify
from flask_cors import CORS
import oracledb

app = Flask(__name__)
CORS(app)  # Enable Cross-Origin Resource Sharing

# Configure DB connection
DB_USER = "hr"
DB_PASS = "your_password"
DB_DSN = "localhost:1521/XEPDB1"

def get_connection():
    return oracledb.connect(user=DB_USER, password=DB_PASS, dsn=DB_DSN)

@app.route('/api/employees', methods=['GET'])
def fetch_employees():
    conn = get_connection()
    cursor = conn.cursor()
    ref_cursor = conn.cursor()
    
    # Call PL/SQL procedure get_all_employees
    cursor.callproc("get_all_employees", [ref_cursor])
    
    columns = [col[0].lower() for col in ref_cursor.description]
    employees = [dict(zip(columns, row)) for row in ref_cursor.fetchall()]
    
    cursor.close()
    conn.close()
    return jsonify(employees)

@app.route('/api/employees', methods=['POST'])
def create_employee():
    data = request.json
    conn = get_connection()
    cursor = conn.cursor()
    
    # Call PL/SQL procedure add_employee
    cursor.callproc("add_employee", [data['name'], data['email'], data['department'], data['salary']])
    
    cursor.close()
    conn.close()
    return jsonify({"message": "Employee added successfully"}), 201

@app.route('/api/employees/<int:emp_id>', methods=['DELETE'])
def remove_employee(emp_id):
    conn = get_connection()
    cursor = conn.cursor()
    
    # Call PL/SQL procedure delete_employee
    cursor.callproc("delete_employee", [emp_id])
    
    cursor.close()
    conn.close()
    return jsonify({"message": "Employee deleted successfully"})

if __name__ == '__main__':
    app.run(port=5000, debug=True)
