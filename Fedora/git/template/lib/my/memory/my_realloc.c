/*
** EPITECH PROJECT, 2025
** my_realloc.c
** File description:
** Realloc the given ptr of a given amout
*/

#include "memory.h"
#include "error.h"
#include <stdlib.h>
#include <stdbool.h>

int my_realloc(void **ptr, int type_size, int add, int size)
{
    void *new = NULL;

    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (type_size < 1 || add < 0 || size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    if (my_malloc(&new, type_size, add + size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        ((unsigned char *) new)[i] = ((unsigned char *) (*ptr))[i];
    free(*ptr);
    (*ptr) = new;
    return OK;
}

int my_realloc_b(bool **ptr, int add, int size)
{
    bool *new = NULL;

    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (add < 1 || size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    if (my_malloc_b(&new, size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        new[i] = (*ptr)[i];
    free(*ptr);
    (*ptr) = NULL;
    if (my_malloc_b(ptr, add + size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = new[i];
    free(new);
    return OK;
}

int my_realloc_c(char **ptr, int add, int size)
{
    char *new = NULL;

    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (add < 1 || size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    if (my_malloc_c(&new, size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        new[i] = (*ptr)[i];
    free(*ptr);
    (*ptr) = NULL;
    if (my_malloc_c(ptr, add + size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = new[i];
    free(new);
    return OK;
}

int my_realloc_i(int **ptr, int add, int size)
{
    int *new = NULL;

    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (add < 1 || size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    if (my_malloc_i(&new, size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        new[i] = (*ptr)[i];
    free(*ptr);
    (*ptr) = NULL;
    if (my_malloc_i(ptr, add + size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = new[i];
    free(new);
    return OK;
}

int my_realloc_f(float **ptr, int add, int size)
{
    float *new = NULL;

    if (!ptr || !(*ptr))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (add < 1 || size < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    if (my_malloc_f(&new, size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        new[i] = (*ptr)[i];
    free(*ptr);
    (*ptr) = NULL;
    if (my_malloc_f(ptr, add + size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; i < size; i++)
        (*ptr)[i] = new[i];
    free(new);
    return OK;
}
