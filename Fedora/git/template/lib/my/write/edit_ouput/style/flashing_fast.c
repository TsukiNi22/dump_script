/*
** EPITECH PROJECT, 2025
** flashing_fast.c
** File description:
** Set the text in flashing_fast
*/

#include "define.h"
#include "write.h"
#include "error.h"

int flashing_fast(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[6m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
