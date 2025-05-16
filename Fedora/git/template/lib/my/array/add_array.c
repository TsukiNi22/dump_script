/*
** EPITECH PROJECT, 2025
** add_array.c
** File description:
** Add a new element to the array
*/

#include "define.h"
#include "array.h"
#include "error.h"
#include <stdlib.h>

int add_array(array_t *array, void *data)
{
    void **tmp = NULL;

    if (!array || !data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (array->len == array->size) {
        array->size *= 2;
        tmp = malloc(sizeof(void *) * array->size);
        if (!tmp)
            return err_prog(MALLOC_ERR, KO, ERR_INFO);
        for (unsigned int i = 0; i < array->len; i++)
            tmp[i] = array->data[i];
        free(array->data);
        array->data = tmp;
    }
    array->data[array->len] = data;
    array->len++;
    return OK;
}
