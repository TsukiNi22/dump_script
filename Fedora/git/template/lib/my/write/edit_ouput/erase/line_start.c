/*
** EPITECH PROJECT, 2025
** line_start.c
** File description:
** Erase line start
*/

#include "define.h"
#include "write.h"
#include "error.h"

int erase_line_start(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[1K");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
