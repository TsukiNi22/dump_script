/*
** EPITECH PROJECT, 2025
** back_color_rgb.c
** File description:
** Change the background color
*/

#include "define.h"
#include "write.h"
#include "error.h"

int back_color_rgb(int fd, unsigned char r, unsigned char g,
    unsigned char b)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[48;2;");
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
