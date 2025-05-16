/*
** EPITECH PROJECT, 2025
** reset.c
** File description:
** Specifier 'R'
*/

#include "write.h"
#include "printf.h"
#include "error.h"

int specifiers_strong(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    return strong(data->fd);
}
