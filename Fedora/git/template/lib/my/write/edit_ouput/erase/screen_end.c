/*
** EPITECH PROJECT, 2025
** screen_end.c
** File description:
** Erase screen end
*/

#include "define.h"
#include "write.h"
#include "error.h"

int erase_screen_end(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[J");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
