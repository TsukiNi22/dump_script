/*
** EPITECH PROJECT, 2025
** pop_array.c
** File description:
** Pop the given index
*/

#include "array.h"
#include "error.h"

int pop_array(array_t *array, int (*free_ptr)(void *), unsigned int index)
{
    if (!array || !free_ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (index >= array->len)
        index = array->len - 1;
    if (free_ptr(array->data[index]) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (unsigned int i = index; i + 1 < array->len; i++)
        array->data[i] = array->data[i + 1];
    array->len--;
    return OK;
}
