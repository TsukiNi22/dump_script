/*
** EPITECH PROJECT, 2025
** my_pow.c
** File description:
** My pow made with the Series of Taylor for (u + 1)^a
*/

#include "my_math.h"
#include <float.h>
#include <stdbool.h>

long double my_pow(double x, double pow)
{
    bool neg = (x < 0);

    if (x == 0)
        return 0;
    if (x == 1 || pow == 0)
        return 1;
    if (pow == 1)
        return x;
    if (neg)
        x = -x;
    if (x < 0)
        x = DBL_MAX;
    if (neg)
        return (1 / my_exp(pow * my_ln(x)));
    return my_exp(pow * my_ln(x));
}
