/*
** EPITECH PROJECT, 2025
** ouput.c
** File description:
** Specifier that change the ouput writng
*/

#include "printf.h"
#include "error.h"

int specifiers_ouput(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    data->fd = va_arg(data->ap, i_t);
    return OK;
}
