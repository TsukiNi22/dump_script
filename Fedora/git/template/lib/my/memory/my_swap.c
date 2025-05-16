/*
** EPITECH PROJECT, 2025
** my_swap.c
** File description:
** Swaps the content of two ptr
*/

#include "error.h"

int my_swap_c(char *a, char *b)
{
    char tmp = (*a);

    if (!a || !b)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    (*a) = (*b);
    (*b) = tmp;
    return OK;
}

int my_swap_i(int *a, int *b)
{
    int tmp = (*a);

    if (!a || !b)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    (*a) = (*b);
    (*b) = tmp;
    return OK;
}

int my_swap_f(float *a, float *b)
{
    float tmp = (*a);

    if (!a || !b)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    (*a) = (*b);
    (*b) = tmp;
    return OK;
}

int my_swap(int *a, int *b)
{
    if (!a || !b)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    *a = *a ^ *b;
    *b = *a ^ *b;
    *a = *a ^ *b;
    return OK;
}
