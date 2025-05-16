/*
** EPITECH PROJECT, 2025
** my_putnbr_base.c
** File description:
** Convert the given number in the given base
*/

#include "my_string.h"
#include "write.h"
#include "error.h"

int my_putnbr_base(int fd, unsigned long long nbr, char const *base)
{
    int base_size = 0;
    int res = OK;

    if (!base)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    base_size = my_strlen(base);
    if (base_size < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (base_size <= 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    for (int i = 0; nbr >= 1; i++) {
        res += my_putchar(fd, base[nbr % base_size]);
        nbr /= base_size;
    }
    if (res != OK)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
