import random
import sys

def guess_the_number():
    correct_number = random.randint(1,100)
    attempts = 5

    print("Я загадав число від 1 до 100. У тебе є 5 спроб щоб його відгадати!!!")

    for attempt in range (1,attempts + 1):
        try:
            guess = int(input(f"Спроба {attempt}: Введи своє число: "))

            if guess == correct_number:
                print("Вітаю!!!Ти вгадав правильне число.")
                sys.exit() #Вихід з програми після вгадування
            elif guess < correct_number:
                print("Занадто низько.")
            else:
                print("Занадто високо.")
        except ValueError:
            print("Будь ласка, введіть ціле число.")

            continue
    print(f"Вибачте, вле у вас закінчилися спроби. Правильне число було {correct_number}.")

#Викликаємо функцію
guess_the_number()
