/*
** EPITECH PROJECT, 2025
** hide.c
** File description:
** Hide cursor
*/

#include "define.h"
#include "write.h"
#include "error.h"

int cursor_hide(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[?25l");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
