/*
** EPITECH PROJECT, 2025
** i.c
** File description:
** 'i' or 'd' specifier
*/

#include "printf.h"
#include "my_string.h"
#include "write.h"
#include "memory.h"
#include "define.h"
#include "error.h"
#include <stdlib.h>

static int set_str_left(printf_data_t *data, char **str, char *n, int size)
{
    int len = 0;

    if (!data || !str || !n)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (n[0] == '-')
        my_strcat(*str, "-");
    if (my_get_index(data->info_flags, '+') != -1 && n[0] != '-')
        my_strcat(*str, "+");
    else if (my_get_index(data->info_flags, ' ') != -1 && n[0] != '-')
        my_strcat(*str, " ");
    len = my_strlen(n);
    for (int i = 0; i < data->precision + (n[0] == '-') - len; i++)
        my_strcat(*str, "0");
    n = &(n[1 * (n[0] == '-')]);
    my_strcat(*str, n);
    len = my_strlen(*str);
    for (int i = 0; i < size - len; i++)
        my_strcat(*str, " ");
    return OK;
}

static int set_str_right(printf_data_t *data, char **str, char *n, int size)
{
    int len = 0;

    if (!data || !str || !n)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    len = my_strlen(n) - (n[0] == '-');
    for (int i = 0; i < size - 1 * data->c - data->precision
        * (data->precision > len) - len * !(data->precision > len); i++)
        my_strcat(*str, " ");
    if (n[0] == '-')
        my_strcat(*str, "-");
    if (my_get_index(data->info_flags, '+') != -1 && n[0] != '-')
        my_strcat(*str, "+");
    else if (my_get_index(data->info_flags, ' ') != -1 && n[0] != '-')
        my_strcat(*str, " ");
    len = my_strlen(n);
    for (int i = 0; i < data->precision + (n[0] == '-') - len; i++)
        my_strcat(*str, "0");
    n = &(n[1 * (n[0] == '-')]);
    my_strcat(*str, n);
    return OK;
}

static int set_str(printf_data_t *data, char **str, char *n, int size)
{
    if (!data || !str || !n)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (my_get_index(data->info_flags, '-') != -1) {
        if (set_str_left(data, str, n, size) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    } else {
        data->c = (n[0] == '-'
        || (my_get_index(data->info_flags, '+') != -1 && n[0] != '-')
        || (my_get_index(data->info_flags, ' ') != -1 && n[0] != '-'));
        if (set_str_right(data, str, n, size) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    return OK;
}

static int get_str(printf_data_t *data, char **str, char *n)
{
    int size = 0;
    int len = 0;

    if (!data || !str || !n)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    len = my_strlen(n);
    if (len < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (len >= data->field && len >= data->precision)
        size = len;
    if (data->field >= len && data->field >= data->precision)
        size = data->field;
    if (data->precision >= data->field && data->precision >= len)
        size = data->precision;
    if (my_malloc_c(str, size + 2) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (set_str(data, str, n, size) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

int specifiers_i(printf_data_t *data)
{
    char *str = NULL;
    char *n = NULL;

    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (my_strcmp(data->info_modifier, "l") == 0)
        n = my_itoa(va_arg(data->ap, lli_t));
    else if (my_strcmp(data->info_modifier, "ll") == 0)
        n = my_itoa(va_arg(data->ap, li_t));
    else
        n = my_itoa(va_arg(data->ap, i_t));
    if (get_str(data, &str, n) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (my_putstr(data->fd, str) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    free(str);
    free(n);
    return OK;
}
