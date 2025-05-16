/*
** EPITECH PROJECT, 2025
** my_tan.c
** File description:
** The tan function
*/

#include "my_math.h"
#include "macro.h"
#include "error.h"

double my_tan(float x)
{
    ABS(x);
    if (x < 0)
        return err_prog(OVERFLOW, 0, ERR_INFO);
    return (double) my_sin(x) / (double) my_cos(x);
}
