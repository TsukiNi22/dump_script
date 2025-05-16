/*
** EPITECH PROJECT, 2025
** my_calloc.c
** File description:
** Set to zero every byte of the given array
*/

#include "error.h"
#include <stdbool.h>

int my_calloc(void **ptr, int type_size, int size)
{
    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (type_size <= 0 || size < 0)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    for (int i = 0; i < size * type_size; i++)
        ((unsigned char *) (*ptr))[i] = 0;
    return OK;
}

int my_calloc_b(bool **ptr, int size)
{
    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 0)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = false;
    return OK;
}

int my_calloc_c(char **ptr, int size)
{
    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 0)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = '\0';
    return OK;
}

int my_calloc_i(int **ptr, int size)
{
    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 0)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = 0;
    return OK;
}

int my_calloc_f(float **ptr, int size)
{
    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 0)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = 0.0;
    return OK;
}
