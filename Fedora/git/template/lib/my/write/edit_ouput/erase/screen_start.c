/*
** EPITECH PROJECT, 2025
** screen_start.c
** File description:
** Erase screen start
*/

#include "define.h"
#include "write.h"
#include "error.h"

int erase_screen_start(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[1J");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
