/*
** EPITECH PROJECT, 2025
** my_malloc.c
** File description:
** For malloc function and calloc
*/

#include "memory.h"
#include "error.h"
#include <stdlib.h>
#include <stdbool.h>

int my_malloc(void **ptr, int type_size, int size)
{
    if (!ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (type_size < 1 || size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    (*ptr) = malloc(type_size * size);
    if (!(*ptr))
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    if (my_calloc(ptr, type_size, size) == ERROR)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

int my_malloc_b(bool **ptr, int size)
{
    if (!ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    (*ptr) = malloc(sizeof(bool) * size);
    if (!(*ptr))
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    if (my_calloc_b(ptr, size) == ERROR)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

int my_malloc_c(char **ptr, int size)
{
    if (!ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    (*ptr) = malloc(sizeof(char) * size);
    if (!(*ptr))
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    if (my_calloc_c(ptr, size) == ERROR)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

int my_malloc_i(int **ptr, int size)
{
    if (!ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    (*ptr) = malloc(sizeof(int) * size);
    if (!(*ptr))
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    if (my_calloc_i(ptr, size) == ERROR)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

int my_malloc_f(float **ptr, int size)
{
    if (!ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    (*ptr) = malloc(sizeof(float) * size);
    if (!(*ptr))
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    if (my_calloc_f(ptr, size) == ERROR)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
