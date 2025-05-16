/*
** EPITECH PROJECT, 2025
** my_gamma.c
** File description:
** My gamma is like n! but for all number
*/

#include "my_math.h"

double my_gamma(float x)
{
    return my_pow(2 * PI * x, .5) * my_pow((x / EULER), x);
}
