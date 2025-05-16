/*
** EPITECH PROJECT, 2025
** load.c
** File description:
** Load cursor position
*/

#include "define.h"
#include "write.h"
#include "error.h"

int cursor_load(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[u");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
