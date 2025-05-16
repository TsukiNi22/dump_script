/*
** EPITECH PROJECT, 2025
** delete_array.c
** File description:
** Delete array
*/

#include "define.h"
#include "array.h"
#include "error.h"
#include <stdlib.h>

int delete_array(array_t **array, int (*free_ptr)(void *))
{
    if (!array || !(*array) || !free_ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (unsigned int i = 0; i < (*array)->len; i++) {
        if (free_ptr((*array)->data[i]) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    free((*array)->data);
    free(*array);
    *array = NULL;
    return OK;
}
