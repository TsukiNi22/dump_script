/*
** EPITECH PROJECT, 2025
** line.c
** File description:
** Erase line
*/

#include "define.h"
#include "write.h"
#include "error.h"

int erase_line(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[2K");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
