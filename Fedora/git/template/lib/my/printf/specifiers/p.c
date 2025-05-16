/*
** EPITECH PROJECT, 2025
** p.c
** File description:
** 'p' specifier
*/

#include "printf.h"
#include "my_math.h"
#include "my_string.h"
#include "memory.h"
#include "write.h"
#include "define.h"
#include "error.h"
#include <stdlib.h>

static int set_str(printf_data_t *data, char *str, char *n, int len)
{
    if (!data || !str || !n)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    data->c = (my_strcmp(n, "(nil)") != 0);
    if (my_get_index(data->info_flags, '-') != -1) {
        if (data->c)
            my_strcat(str, "0x");
        my_strcat(str, n);
        for (int i = 0; i < data->field - len; i++)
            my_strcat(str, " ");
    } else {
        for (int i = 0; i < data->field - len; i++)
            my_strcat(str, " ");
        if (data->c)
            my_strcat(str, "0x");
        my_strcat(str, n);
    }
    if (data->c)
        free(n);
    return OK;
}

int specifiers_p(printf_data_t *data)
{
    char *str = NULL;
    char *n = NULL;
    int len = 0;

    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    n = convertnbr_base((llu_t) va_arg(data->ap, void *), BASE_HEX);
    if (my_strcmp(n, "") == 0)
        n = "(nil)";
    len = my_strlen(n) + 2 * (my_strcmp(n, "(nil)") != 0);
    data->c = (len >= data->field);
    if (my_malloc_c(&str, data->field * !data->c + len * data->c + 2) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (set_str(data, str, n, len) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (my_putstr(data->fd, str) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    free(str);
    return OK;
}
