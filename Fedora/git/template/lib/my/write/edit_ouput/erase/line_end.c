/*
** EPITECH PROJECT, 2025
** line_end.c
** File description:
** Erase line end
*/

#include "define.h"
#include "write.h"
#include "error.h"

int erase_line_end(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[K²");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
