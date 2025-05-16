/*
** EPITECH PROJECT, 2025
** save.c
** File description:
** Save cursor position
*/

#include "define.h"
#include "write.h"
#include "error.h"

int cursor_save(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[s");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
