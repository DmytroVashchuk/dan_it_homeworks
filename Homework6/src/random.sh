#!/bin/bash

#Генерація випадкового числа від 1 до 100

range=$((RANDOM % 100 + 1))

#Лічильник генерації спроб та його максимальна кількість
attemts=0
max_attemts=5

echo "Вгадайте число від 1 до 100. У вас є $max_attemts спроб."

#Основний цикл

while [ $attemts -lt $max_attemts ]; do
	read -p "Ваше припущення: " guess
	attemts=$((attemts +1))

	if [ "$guess" -eq "$range" ];
	then
		echo "Вітаємо!Ви вгадали правильне число."
		exit 0
	elif [ "$guess" -lt "$range" ];
	then
		echo "Занадто низько."
	else
		echo "Занадто високо"
	fi
done

echo "ВИбачте, у вас закінчилися спроби. Правильним число було $range."
exit 0



