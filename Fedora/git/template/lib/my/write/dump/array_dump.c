/*
** EPITECH PROJECT, 2025
** array_dump.c
** File description:
** Display the array
*/

#include "array.h"
#include "write.h"
#include "error.h"

int array_dump(array_t *array, int (*display_ptr)(void *))
{
    if (!array || !display_ptr)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (unsigned int i = 0; i < array->len; i++) {
        if (my_printf("[%d]:", i) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        if (display_ptr(array->data[i]) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    return OK;
}
