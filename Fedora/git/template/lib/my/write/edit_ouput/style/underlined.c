/*
** EPITECH PROJECT, 2025
** underlined.c
** File description:
** Set the text in underlined
*/

#include "define.h"
#include "write.h"
#include "error.h"

int underlined(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[4m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
