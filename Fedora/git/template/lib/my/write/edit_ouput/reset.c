/*
** EPITECH PROJECT, 2025
** reset.c
** File description:
** Reset the parameter of the ouput
*/

#include "define.h"
#include "write.h"
#include "error.h"

int reset_ouput(int fd)
{
    int res = OK;

    res += my_putchar(fd, ESC);
    res += my_putstr(fd, "[0m");
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
