class Alphabet:
    def __init__(self, lang, letters):
        # Ініціалізуємо атрибути класу
        self.lang = lang # Мова алфавіту
        self.letters = list(letters) # Список літер алфавіту

    def print(self):
        # Метод для виведення всіх літер алфавіту
        print("".join(self.letters))

    def letters_num(self):
        # Метод для підрахунку кількості літер в алфавіті
        return len(self.letters)
    
class Eng_Alphabet(Alphabet):
    # Статичний атрибут, який зберігає кількість літер
    __letters_num = 26
    
    def __init__(self):
        # Виклик батьківського класу з параметрами
        super().__init__("En", "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    def is_en_letter(self, letter):
        # Метод для перевіркм чи належить літера до анг. алфавіту
        return letter.upper() in self.letters
    def letters_len(self):
        # Перевизначений метод для повернення кількості літер в анг.алфавіті
        return Eng_Alphabet.__letters_num

    @staticmethod
    def example():
        return "London is the capital of Great Britain!!!"

if __name__ == "__main__":
    # Створюємо об'єкт класу Eng_Alphabet
    eng_alphabet = Eng_Alphabet()

    # Виводимо літери англійського алфавіту
    eng_alphabet.print()

    # Виводимо кількість літер в англійському алфавіті
    print(f"Кількість літер в алфавіті: {eng_alphabet.letters_num()}")

    # Перевіряємо, чи належить літера 'F' до англійського алфавіту
    print(f"Чи є 'F' англійською літерою? {eng_alphabet.is_en_letter('F')}")

    # Перевіряємо, чи належить літера 'Щ' до англійського алфавіту
    print(f"Чи є 'Щ' англійською літерою? {eng_alphabet.is_en_letter('Щ')}")

    # Виводимо приклад тексту англійською мовою
    print(f"Приклад тексту англійською: {Eng_Alphabet.example()}")

