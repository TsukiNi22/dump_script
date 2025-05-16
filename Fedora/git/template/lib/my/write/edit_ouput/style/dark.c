/*
** EPITECH PROJECT, 2025
** dark.c
** File description:
** Set the text in dark
*/

#include "define.h"
#include "write.h"
#include "error.h"

int dark(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[2m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
