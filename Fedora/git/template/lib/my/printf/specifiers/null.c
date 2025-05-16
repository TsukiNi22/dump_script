/*
** EPITECH PROJECT, 2025
** null.c
** File description:
** Specifier that do nothing
*/

#include "printf.h"
#include "error.h"

int specifiers_null(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    return OK;
}
