/*
** EPITECH PROJECT, 2025
** color.c
** File description:
** Change the text color
*/

#include "define.h"
#include "write.h"
#include "error.h"

int color(int fd, color_t color)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putchar(fd, '[');
    res += my_putnbr(fd, color);
    res += my_putchar(fd, 'm');
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
