/*
** EPITECH PROJECT, 2025
** my_ftoa.c
** File description:
** Return the string from a float
*/

#include "my_string.h"
#include "my_math.h"
#include "write.h"
#include "memory.h"
#include "error.h"
#include <stdlib.h>
#include <limits.h>

static int len_local(char *str)
{
    int len = 0;

    if (!str)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (; str[len] != '\0'; len++);
    free(str);
    return len;
}

static char *my_strcat_local(char *dest, char *src)
{
    int len = 0;
    int i = 0;

    if (!dest || !src)
        return err_prog_n(PTR_ERR, ERR_INFO);
    len = my_strlen(dest);
    if (len < 0)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    for (; src[i]; i++)
        dest[len + i] = src[i];
    dest[len + i] = '\0';
    free(src);
    return dest;
}

static int get_d_integer(long double nbr, long double *nbr_already,
    int *depth, char **str)
{
    long long cast = 0;
    int signe = 0;

    if (!nbr_already || !depth || !str)
        return err_prog(PTR_ERR, false, ERR_INFO);
    nbr -= *nbr_already;
    signe = (nbr < 0);
    nbr *= 1 - 2 * (signe == 1 && *depth != 0);
    for (; nbr > LLONG_MAX; nbr /= 10)
        *nbr_already *= 10;
    cast = (long long) nbr;
    if (my_realloc_c(str, len_local(my_itoa(cast)),
        my_strlen(*str) + 1) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (!(*str))
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    my_strcat_local(*str, my_itoa(cast));
    *nbr_already += cast * (1 - 2 * (signe == 1));
    (*depth)++;
    return (nbr < LLONG_MAX);
}

static int get_d_decimal(long double nbr, long double *nbr_already,
    int *depth, char **str)
{
    long long ll_cast = 0;
    long double d_cast = 0;
    int signe = (nbr < 0);

    if (!nbr_already || !depth || !str)
        return err_prog(PTR_ERR, false, ERR_INFO);
    nbr = (nbr - *nbr_already * (1 - 2 * signe)) * (1 - 2 * signe);
    if ((long long) (nbr * my_pow(10, my_log(LLONG_MAX, 10) - 1)) == 0)
        return true;
    for (int i = 0; nbr * 10 < LLONG_MAX && i < my_log(LLONG_MAX, 10) * 2; i++)
        nbr *= 10;
    ll_cast = (long long) nbr;
    d_cast = (long double) ll_cast;
    if (my_realloc_c(str, len_local(my_itoa(ll_cast)), my_strlen(*str)) == KO)
        return err_prog(UNDEF_ERR, false, ERR_INFO);
    my_strcat_local(*str, my_itoa(ll_cast));
    for (; d_cast > 1; d_cast /= 10);
    *nbr_already += d_cast * (1 - 2 * (signe == 1));
    (*depth)++;
    return (ll_cast == 0 || *depth >= 10);
}

static char *clear_char(char *str)
{
    if (!str)
        return err_prog_n(PTR_ERR, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        if ((str[i] < '0' || str[i] > '9') && str[i] != '-' && str[i] != '.')
            str[i] = '0';
    }
    return str;
}

static int set_dot(char *str)
{
    int len = 0;

    if (!str)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    len = my_strlen(str);
    if (len < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    str[len] = '.';
    str[len + 1] = '\0';
    return OK;
}

char *my_ftoa(long double nbr)
{
    char *str = malloc(sizeof(char));
    long double nbr_already = 0;
    int depth = 0;
    int size = 0;

    if (!str || my_calloc_c(&str, 1) == KO)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    while (get_d_integer(nbr, &nbr_already, &depth, &str) == 0);
    set_dot(str);
    if (depth < 3) {
        for (depth = 0; get_d_decimal(nbr, &nbr_already, &depth, &str) == 0;);
    }
    if (depth >= 3) {
        size = my_strlen(str);
        if (my_realloc_c(&str, 6, size) == KO)
            return err_prog_n(UNDEF_ERR, ERR_INFO);
        for (int i = 0; i < 6; i++)
            str[size + i] = '0';
    }
    return clear_char(str);
}
