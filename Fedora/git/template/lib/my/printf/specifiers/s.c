/*
** EPITECH PROJECT, 2025
** s.c
** File description:
** 's' specifier
*/

#include "printf.h"
#include "my_string.h"
#include "memory.h"
#include "write.h"
#include "define.h"
#include "error.h"
#include <stdlib.h>
#include <stdbool.h>

static int set_str(printf_data_t *data, char *str, char *s, int len)
{
    int size = 0;

    if (!data || !str || !s)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (my_strcmp(data->info_precision, "") == 0)
        size = len;
    else
        size = data->precision * data->c;
    if (my_get_index(data->info_flags, '-') != -1) {
        my_strncat(str, s, size);
        for (int i = 0; i < data->field - size; i++)
            my_strcat(str, " ");
    } else {
        for (int i = 0; i < data->field - size; i++)
            my_strcat(str, " ");
        my_strncat(str, s, size);
    }
    return OK;
}

static int get_str(printf_data_t *data, char **str, char *s)
{
    int size = 0;
    int len = 0;

    if (!data || !str || !s)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    len = my_strlen(s);
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
    if (set_str(data, *str, s, len) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

int specifiers_s(printf_data_t *data)
{
    char *str = NULL;
    char *s = NULL;

    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    s = va_arg(data->ap, void *);
    data->c = true;
    if (!s) {
        s = "(null)";
        data->c = false;
    }
    if (get_str(data, &str, s) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (my_putstr(data->fd, str) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    free(str);
    return OK;
}
