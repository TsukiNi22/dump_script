/*
** EPITECH PROJECT, 2025
** my_round.c
** File description:
** Round number
*/

float my_round(float x, int precision)
{
    for (int i = 0; i < precision; i++)
        x *= 10;
    x *= 10;
    x = (x / 10) + ((long long) x % 10 >= 5);
    x = (long long) x;
    for (int i = 0; i < precision; i++)
        x /= 10;
    return x;
}
