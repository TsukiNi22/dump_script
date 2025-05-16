/*
** EPITECH PROJECT, 2025
** my_put_nbr.c
** File description:
** Display the given number
*/

#include "macro.h"
#include "write.h"
#include "error.h"

int my_putnbr(int fd, long long nb)
{
    int div = 1;

    for (div = 1; nb / div > 1; div *= 10);
    for (; div > 0; div /= 10) {
        if (my_putchar(fd, ((nb / div) % 10) + 48) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    return OK;
}
