/*
** EPITECH PROJECT, 2025
** left.c
** File description:
** Change cursor position
*/

#include "define.h"
#include "write.h"
#include "error.h"

int cursor_left(int fd, int n)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putchar(fd, '[');
    res += my_putnbr(fd, n);
    res += my_putchar(fd, 'D');
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
