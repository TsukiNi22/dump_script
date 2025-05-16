/*
** EPITECH PROJECT, 2025
** my_factorial.c
** File description:
** A factorial
*/

#include "error.h"

double my_factorial(int x)
{
    double sum = 1;

    if (x > 170)
        return err_prog(OVERFLOW, KO, ERR_INFO);
    for (; x > 1; x--)
        sum *= x;
    return sum;
}
