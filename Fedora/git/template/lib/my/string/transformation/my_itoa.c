/*
** EPITECH PROJECT, 2025
** my_itoa.c
** File description:
** Return the given int in an array
*/

#include "my_string.h"
#include "memory.h"
#include "error.h"
#include "define.h"
#include <limits.h>

static char *get_str_from_nbr(long long n, int negatif)
{
    char *str = NULL;
    long long diviseur = 1;
    long long nbis = 0;
    int size = 0;
    int i = negatif;

    for (; n / diviseur >= 10; diviseur *= 10)
        size++;
    size += (size == 0);
    if (my_malloc_c(&str, size + negatif + 2) == KO)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    str[0] = '-' * negatif;
    for (int nb = 0; diviseur > 0; diviseur /= 10) {
        nb = (n / diviseur) - nbis;
        nbis = (n / diviseur) * 10;
        str[i] = nb + 48 + (n == LLONG_MAX && diviseur == 1 && negatif);
        i++;
    }
    str[i] = '\0';
    return str;
}

char *my_itoa(long long n)
{
    int negatif = (n < 0);

    n *= 1 - 2 * negatif;
    if (n == LLONG_MIN)
        n = LLONG_MAX;
    return get_str_from_nbr(n, negatif);
}
