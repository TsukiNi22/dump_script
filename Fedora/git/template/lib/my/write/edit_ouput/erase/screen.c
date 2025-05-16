/*
** EPITECH PROJECT, 2025
** screen.c
** File description:
** Erase screen
*/

#include "define.h"
#include "write.h"
#include "error.h"

int erase_screen(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[2J");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
