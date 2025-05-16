/*
** EPITECH PROJECT, 2025
** show.c
** File description:
** Show cursor
*/

#include "define.h"
#include "write.h"
#include "error.h"

int cursor_show(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[?25h");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
