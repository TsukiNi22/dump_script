/*
** EPITECH PROJECT, 2025
** hide.c
** File description:
** Set the text in hide
*/

#include "define.h"
#include "write.h"
#include "error.h"

int hide(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[8m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
