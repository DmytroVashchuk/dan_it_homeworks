from flask import Flask, request, jsonify, abort
import csv
import os

app = Flask(__name__)
CSV_FILE = 'students.csv'

# Функція для зчитування даних студентів з CSV файлу
def read_students():
    students = []
    if os.path.exists(CSV_FILE):
        with open(CSV_FILE, mode='r') as file:
            reader = csv.DictReader(file)
            students = list(reader)
    return students

# Функція для запису оновлених даних студентів до CSV файлу
def write_students(students):
    with open(CSV_FILE, mode='w', newline='') as file:
        fieldnames = ['id', 'first_name', 'last_name', 'age']
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(students)

# Маршрут для отримання інформації про студентів за ID, прізвищем або отримання списку всіх студентів
@app.route('/students', methods=['GET'])
def get_students():
    id = request.args.get('id')
    last_name = request.args.get('last_name')
    students = read_students()

    # Пошук студента за ID
    if id:
        student = next((s for s in students if int(s['id']) == int(id)), None)
        if student:
            return jsonify(student)
        else:
            return abort(404, description="Student not found")
    # Пошук студентів за прізвищем
    elif last_name:
        filtered_students = [s for s in students if s['last_name'] == last_name]
        if filtered_students:
            return jsonify(filtered_students)
        else:
            return abort(404, description="No students found with that last name")
    # Повернення списку всіх студентів
    else:
        return jsonify(students)

# Маршрут для отримання списку всіх студентів (альтернативний маршрут)
@app.route('/students/all', methods=['GET'])
def get_all_students():
    students = read_students()
    return jsonify(students)

# Маршрут для додавання нового студента
@app.route('/students', methods=['POST'])
def add_student():
    new_student = request.get_json()
    required_fields = ['first_name', 'last_name', 'age']

    # Перевірка наявності необхідних полів у запиті
    if not all(field in new_student for field in required_fields):
        return abort(400, description="Missing fields in request")

    # Перевірка на відсутність зайвих полів у запиті
    if any(field not in required_fields for field in new_student.keys()):
        return abort(400, description="Extra fields in request")

    # Генерація нового ID для студента
    students = read_students()
    new_id = max([int(s['id']) for s in students], default=0) + 1
    new_student['id'] = new_id

    # Додавання нового студента до списку і запис у CSV файл
    students.append(new_student)
    write_students(students)
    return jsonify(new_student), 201

# Маршрут для оновлення інформації про студента за його ID
@app.route('/students/<int:id>', methods=['PUT'])
def update_student(id):
    updated_student = request.get_json()
    required_fields = ['first_name', 'last_name', 'age']

    # Перевірка наявності всіх необхідних полів у запиті
    if not all(field in updated_student for field in required_fields):
        return abort(400, description="Missing fields in request")

    # Перевірка на відсутність зайвих полів у запиті
    if any(field not in required_fields for field in updated_student.keys()):
        return abort(400, description="Extra fields in request")

    # Оновлення інформації про студента
    students = read_students()
    for student in students:
        if int(student['id']) == id:
            student.update(updated_student)
            write_students(students)
            return jsonify(student)

    return abort(404, description="Student not found")

# Маршрут для оновлення віку студента за його ID
@app.route('/students/<int:id>/age', methods=['PATCH'])
def update_student_age(id):
    updated_age = request.get_json()

    # Перевірка наявності поля віку в запиті
    if 'age' not in updated_age:
        return abort(400, description="Missing age field in request")

    # Перевірка на відсутність зайвих полів у запиті
    if len(updated_age.keys()) > 1:
        return abort(400, description="Extra fields in request")

    # Оновлення віку студента
    students = read_students()
    for student in students:
        if int(student['id']) == id:
            student['age'] = updated_age['age']
            write_students(students)
            return jsonify(student)

    return abort(404, description="Student not found")

# Маршрут для видалення студента за його ID
@app.route('/students/<int:id>', methods=['DELETE'])
def delete_student(id):
    students = read_students()
    student_to_delete = next((s for s in students if int(s['id']) == id), None)

    # Видалення студента зі списку і запис у CSV файл
    if student_to_delete:
        students.remove(student_to_delete)
        write_students(students)
        return jsonify({"message": "Student deleted successfully"})
    else:
        return abort(404, description="Student not found")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
