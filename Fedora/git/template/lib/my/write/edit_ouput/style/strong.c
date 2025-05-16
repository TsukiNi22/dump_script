/*
** EPITECH PROJECT, 2025
** strong.c
** File description:
** Set the text in strong
*/

#include "define.h"
#include "write.h"
#include "error.h"

int strong(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[1m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
