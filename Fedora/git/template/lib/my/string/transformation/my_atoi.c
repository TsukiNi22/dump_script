/*
** EPITECH PROJECT, 2025
** my_atoi.c
** File description:
** Str to int
*/

#include "my_string.h"
#include "error.h"
#include <stdbool.h>

long long my_atoi(char *str)
{
    long long nb = 0.0;
    bool negatif = false;

    if (!str)
        return err_prog(PTR_ERR, 0, ERR_INFO);
    negatif = (str[0] == '-');
    str = &str[negatif];
    for (int i = 0; str[i]; i++) {
        nb *= 10;
        nb += str[i] - 48;
    }
    nb *= 1 - 2 * negatif;
    return nb;
}
