import requests
import json

# URL вашого API
BASE_URL = "http://127.0.0.1:5000/students"
RESULTS_FILE = "results.txt"

def log_and_print(message):
    print(message)
    with open(RESULTS_FILE, "a") as file:
        file.write(message + "\n")

def main():
    # Очистити файл перед початком тестів
    open(RESULTS_FILE, 'w').close()

    # 1. Отримати всіх існуючих студентів (GET)
    response = requests.get(BASE_URL)
    log_and_print("GET all students:\n" + response.text)

    # 2. Створити трьох студентів (POST)
    students = [
        {"first_name": "Dmytro", "last_name": "Vashchuk", "age": 20},
        {"first_name": "Roma", "last_name": "TOR", "age": 22},
        {"first_name": "Mykola", "last_name": "Melnyl", "age": 24}
    ]
    for student in students:
        response = requests.post(BASE_URL, json=student)
        log_and_print(f"POST create student {student['first_name']}:\n" + response.text)

    # 3. Отримати інформацію про всіх студентів (GET)
    response = requests.get(BASE_URL)
    log_and_print("GET all students after adding new ones:\n" + response.text)

    # 4. Оновити вік другого студента (PATCH)
    student_id = 2  # Ідентифікатор другого студента
    updated_age = {"age": 23}
    response = requests.patch(f"{BASE_URL}/{student_id}/age", json=updated_age)
    log_and_print(f"PATCH update age of student {student_id}:\n" + response.text)

    # 5. Отримати інформацію про другого студента (GET)
    response = requests.get(f"{BASE_URL}?id={student_id}")
    log_and_print(f"GET student {student_id} info:\n" + response.text)

    # 6. Оновити ім’я, прізвище та вік третього студента (PUT)
    student_id = 3  # Ідентифікатор третього студента
    updated_info = {"first_name": "James", "last_name": "Bond", "age": 30}
    response = requests.put(f"{BASE_URL}/{student_id}", json=updated_info)
    log_and_print(f"PUT update student {student_id} info:\n" + response.text)

    # 7. Отримати інформацію про третього студента (GET)
    response = requests.get(f"{BASE_URL}?id={student_id}")
    log_and_print(f"GET student {student_id} info:\n" + response.text)

    # 8. Отримати всіх існуючих студентів (GET)
    response = requests.get(BASE_URL)
    log_and_print("GET all students after updates:\n" + response.text)

    # 9. Видалити першого користувача (DELETE)
    student_id = 1  # Ідентифікатор першого студента
    response = requests.delete(f"{BASE_URL}/{student_id}")
    log_and_print(f"DELETE student {student_id}:\n" + response.text)

    # 10. Отримати всіх існуючих студентів (GET)
    response = requests.get(BASE_URL)
    log_and_print("GET all students after deletion:\n" + response.text)

if __name__ == "__main__":
    main()
