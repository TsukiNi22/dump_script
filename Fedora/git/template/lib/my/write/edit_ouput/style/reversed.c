/*
** EPITECH PROJECT, 2025
** reversed.c
** File description:
** Set the swap color text/back
*/

#include "define.h"
#include "write.h"
#include "error.h"

int reversed(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[7m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
