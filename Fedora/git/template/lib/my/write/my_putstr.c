/*
** EPITECH PROJECT, 2025
** my_putstr.c
** File description:
** Write a str
*/

#include "my_string.h"
#include "error.h"
#include <unistd.h>

int my_putstr(int fd, char const *str)
{
    int len = 0;

    if (!str)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    len = my_strlen(str);
    if (len < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (write(fd, str, len) != len)
        return err_prog(WRITE_ERR, KO, ERR_INFO);
    return OK;
}
