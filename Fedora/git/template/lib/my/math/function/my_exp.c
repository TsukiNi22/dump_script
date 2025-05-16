/*
** EPITECH PROJECT, 2025
** my_exp.c
** File description:
** The explonential function
*/

#include "my_math.h"
#include <float.h>

long double my_exp(double pow)
{
    long double res = 0.;
    long double fact = 1.;
    long double x = 1.;

    if (x > 709)
        return DBL_MAX;
    if (x < -709)
        return 0;
    for (int n = 0; n < 170; n++) {
        if (n == 0)
            res += x;
        else
            res += x / fact;
        fact *= (n + 1);
        x *= pow;
    }
    return res;
}
