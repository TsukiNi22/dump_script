/*
** EPITECH PROJECT, 2025
** printf.c
** File description:
** Main file of printf
*/

#include "printf.h"
#include "my_string.h"
#include "write.h"
#include "define.h"
#include "error.h"
#include <stdbool.h>
#include <stdlib.h>

static int set_data(printf_data_t *data, char const *str)
{
    if (!data || !str)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    data->i = 0;
    data->str = (char *) str;
    data->modifier = str_to_str_array(MODIFIER, ":", false);
    data->specifiers = str_to_str_array(SPECIFIERS, ":", false);
    if (!data->modifier || !data->specifiers)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    data->fd = DEFAULT_OUPUT;
    data->info = NULL;
    data->info_flags = NULL;
    data->info_field = NULL;
    data->info_precision = NULL;
    data->info_modifier = NULL;
    data->info_specifiers = '\0';
    return OK;
}

static int free_printf_data(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (data->modifier) {
        for (int i = 0; data->modifier[i]; i++)
            free(data->modifier[i]);
        free(data->modifier);
    }
    if (data->specifiers) {
        for (int i = 0; data->specifiers[i]; i++)
            free(data->specifiers[i]);
        free(data->specifiers);
    }
    return OK;
}

static int print(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (data->invalid_star && data->str[data->i] == '*') {
        if (my_putnbr(data->fd, va_arg(data->ap, int)) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        data->invalid_star = false;
    } else {
        if (my_putchar(data->fd, data->str[data->i]) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    return OK;
}

int my_printf(char const *str, ...)
{
    printf_data_t data = {0};
    bool identifier_b = false;
    int res = OK;

    if (!str)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (set_data(&data, str) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    va_start(data.ap, str);
    for (data.i = 0; str[data.i]; data.i++) {
        identifier_b = false;
        if (str[data.i] == IDENTIFIER)
            res = identifier(&data, &identifier_b);
        if (res == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        if (!identifier_b && print(&data) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    va_end(data.ap);
    return free_printf_data(&data);
}
