/*
** EPITECH PROJECT, 2025
** back_color.c
** File description:
** Change the background color
*/

#include "define.h"
#include "write.h"
#include "error.h"

int back_color(int fd, back_color_t back)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putchar(fd, '[');
    res += my_putnbr(fd, back);
    res += my_putchar(fd, 'm');
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
