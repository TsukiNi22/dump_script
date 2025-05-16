/*
** EPITECH PROJECT, 2025
** my_putchar.c
** File description:
** Write a given char
*/

#include "error.h"
#include <unistd.h>

int my_putchar(int fd, char const c)
{
    if (write(fd, &c, 1) != 1)
        return err_prog(WRITE_ERR, KO, ERR_INFO);
    return OK;
}
