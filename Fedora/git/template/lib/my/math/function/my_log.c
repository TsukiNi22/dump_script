/*
** EPITECH PROJECT, 2025
** my_log.c
** File description:
** Log with my formula
*/

#include "my_math.h"

long double my_log(double x, double base)
{
    long double h = H_ZERO;

    return (my_pow(x, h) - 1) / (my_pow(base, h) - 1);
}
