/*
** EPITECH PROJECT, 2025
** my_ln.c
** File description:
** The ln function
*/

#include "my_math.h"
#include <float.h>

long double my_ln(double x)
{
    long double res = 0.;
    long double h2 = 0.;
    long double h = 0.;
    int k = 0;

    for (; x > 2; x /= 2)
        k++;
    for (; x < 0.5; x *= 2)
        k--;
    if (x <= 0)
        return DBL_MIN;
    h = (x - 1) / (x + 1);
    h2 = h * h;
    for (int n = 1; n < ACCURACY; n++) {
        res += h / ((n - 1) * 2 + 1);
        h *= h2;
    }
    return (2 * res + k * 0.69314718056);
}
