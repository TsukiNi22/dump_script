/*
** EPITECH PROJECT, 2025
** boolean.c
** File description:
** 'B' specifier
*/

#include "macro.h"
#include "write.h"
#include "printf.h"
#include "error.h"
#include <stdbool.h>

int specifiers_boolean(printf_data_t *data)
{
    bool b = false;
    int res = OK;

    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    b = !!(va_arg(data->ap, i_t));
    res += reset_ouput(data->fd);
    res += color_rgb(data->fd, 255 * !b, 255 * b, 0);
    res += my_putstr(data->fd, GET_BOOL_STR(b));
    res += reset_ouput(data->fd);
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
