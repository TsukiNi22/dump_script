/*
** EPITECH PROJECT, 2025
** reset.c
** File description:
** Specifier 'R'
*/

#include "write.h"
#include "printf.h"
#include "error.h"

int specifiers_color(printf_data_t *data)
{
    unsigned char r = 0;
    unsigned char g = 0;
    unsigned char b = 0;

    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    r = va_arg(data->ap, i_t);
    g = va_arg(data->ap, i_t);
    b = va_arg(data->ap, i_t);
    return color_rgb(data->fd, r, g, b);
}
