/*
** EPITECH PROJECT, 2025
** color_rgb.c
** File description:
** Change the text color
*/

#include "define.h"
#include "write.h"
#include "error.h"

int color_rgb(int fd, unsigned char r, unsigned char g,
    unsigned char b)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[38;2;");
    res += my_putnbr(fd, r);
    res += my_putchar(fd, ';');
    res += my_putnbr(fd, g);
    res += my_putchar(fd, ';');
    res += my_putnbr(fd, b);
    res += my_putchar(fd, 'm');
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
