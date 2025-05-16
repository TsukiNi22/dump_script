/*
** EPITECH PROJECT, 2025
** is_prime.c
** File description:
** Find if the given number is prime
*/

#include <stdbool.h>

bool is_prime(int nb)
{
    if (nb < 2)
        return false;
    for (int i = 1; i < nb; i++) {
        if (nb % i == 0 && i != 1)
            return false;
    }
    return true;
}
