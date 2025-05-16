/*
** EPITECH PROJECT, 2025
** co.c
** File description:
** Change cursor position
*/

#include "define.h"
#include "write.h"
#include "error.h"

int cursor_co(int fd, int x, int y)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putchar(fd, '[');
    res += my_putnbr(fd, y);
    res += my_putchar(fd, ';');
    res += my_putnbr(fd, x);
    res += my_putchar(fd, 'H');
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
