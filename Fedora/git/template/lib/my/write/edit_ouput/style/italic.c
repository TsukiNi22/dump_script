/*
** EPITECH PROJECT, 2025
** italic.c
** File description:
** Set the text in italic
*/

#include "define.h"
#include "write.h"
#include "error.h"

int italic(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[3m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
