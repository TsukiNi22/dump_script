/*
** EPITECH PROJECT, 2025
** find_prime_sup.c
** File description:
** Find the first prime above the given integer
*/

#include "my_math.h"

int find_prime_sup(int nb)
{
    int i = nb;

    if (nb < 2)
        return 2;
    for (; !is_prime(i); i++);
    return i;
}
