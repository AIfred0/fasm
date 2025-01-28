# FASM
Решение задач на Assembly FASM.
## Запуск
Для запуска поменять в Makefile переменную MAIN на нужный файл.

## Лабораторная 2. Проблема Гольдбаха
Кратко: любое четное число можно представить в виде суммы двух простых чисел. Необходимо представить заданное четное число N, большее двух, в виде суммы двух простых чисел a1 и a2. При этом a1 должно быть минимальным из возможных чисел, и a1 <= a2.

*Входные данные* читаются из стандартного потока ввода и содержат значение числа N (4 <= N <= 10^5).
*Выходные данные* помещаются в стандартный поток вывода и содержат строку из двух чисел a1 и a2, разделенных одним или несколькими пробелами.

## Лабораторная 3. Наибольшая сумма цифр
Задана последовательность (S1, S2, ... Sn) йелых чисел. Найти элемент этой последовательности с наибольшей суммой цифр. Если таких элементов несколько, выбрать наибольший их них.

*Входные данные* читаются из текстового файла SUMDIGIT.IN. Первая строка этого файла содержит величину N (1 <= N <= 10^6). Далее следуют N чисел, каждое из которых не превосходит по модулю 10^9 - элементы последовательности. Эти числа разделяются между собой пробелами и/или символами перевода строки.
*Выходные данные* помещаются в текстовый файл SUMDIGIT.OUT и содержит единственную строку с найденным элементом последовательности.

## Лабораторная 4. Поиск подстроки в строке
Необходимо реализовать аналог функции strstr(), из стандартной библиотеки языка C, для поиска подстроки в строке.