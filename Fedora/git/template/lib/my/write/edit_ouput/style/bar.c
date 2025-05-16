/*
** EPITECH PROJECT, 2025
** bar.c
** File description:
** Set the text in bar
*/

#include "define.h"
#include "write.h"
#include "error.h"

int bar(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[9m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
