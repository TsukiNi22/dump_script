/*
** EPITECH PROJECT, 2025
** my_cos.c
** File description:
** The cos function
*/

#include "my_math.h"
#include "macro.h"
#include "error.h"

float my_cos(float x)
{
    float sum = 1;

    ABS(x);
    if (x < 0)
        return err_prog(OVERFLOW, KO, ERR_INFO);
    for (; x > PI; x -= PI);
    for (int i = 1; i * 2 < 170; i++)
        sum += (my_pow(x, i * 2) / my_factorial(i * 2)) * (1 - 2 * (i % 2));
    return sum;
}
