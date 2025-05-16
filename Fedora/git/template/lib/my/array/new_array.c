/*
** EPITECH PROJECT, 2025
** new_array.c
** File description:
** Create a new array
*/

#include "define.h"
#include "array.h"
#include "error.h"
#include <stdlib.h>

array_t *new_array(void)
{
    array_t *array = NULL;

    array = malloc(sizeof(array_t));
    if (!array)
        return err_prog_n(MALLOC_ERR, ERR_INFO);
    array->len = 0;
    array->size = DEFAULT_ARRAY_SIZE;
    array->data = malloc(sizeof(void *) * DEFAULT_ARRAY_SIZE);
    if (!array->data)
        return err_prog_n(MALLOC_ERR, ERR_INFO);
    return array;
}
