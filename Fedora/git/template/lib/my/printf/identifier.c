/*
** EPITECH PROJECT, 2025
** identifier.c
** File description:
** You know, I don t think there are good or bad descriptions,
** for me, life is above all about functions...
*/

#include "printf.h"
#include "my_string.h"
#include "write.h"
#include "define.h"
#include "memory.h"
#include "error.h"
#include <stdbool.h>
#include <stdlib.h>

static int get_info(printf_data_t *data)
{
    int val = 0;

    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    data->end = KO;
    for (int i = 0; data->specifiers[i]; i++) {
        val = my_get_index(&(data->str[data->i]), data->specifiers[i][0]);
        if (val == -2)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        if (val != -1 && (val < data->end || data->end == -1))
            data->end = val;
    }
    if (data->end == KO)
        return OK;
    if (my_malloc_c(&data->info, data->end + 1) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (!my_strncpy(data->info, &(data->str[data->i + 1]), data->end))
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

static int malloc_info(printf_data_t *data, int len, bool *identifier)
{
    if (!data || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    *identifier = true;
    if (my_malloc_c(&(data->info_flags), len) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (my_malloc_c(&(data->info_field), len) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (my_malloc_c(&(data->info_precision), len) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (my_malloc_c(&(data->info_modifier), len) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

static int extract_flags(printf_data_t *data, int *len, bool *identifier)
{
    int res = 0;

    if (!data || !len || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (int i = 0; i <= *len; i++) {
        res = my_get_index(FLAGS, data->info[*len - i]);
        if (res == -2)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        if (res < 0) {
            *identifier = false;
            return OK;
        }
    }
    if (!my_strncpy(data->info_flags, data->info, *len + 1))
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

static int extract_field(printf_data_t *data, int *len, bool *identifier)
{
    int res = 0;
    int i = 0;

    if (!data || !len || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (i = 0; i <= *len; i++) {
        res = my_get_index(FIELD_WIDHT, data->info[*len - i]);
        if (res == -2)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        if (res < 0)
            break;
    }
    while (data->info[*len - i + 1] == '0')
        i--;
    if (!my_strncpy(data->info_field, &(data->info[*len - i + 1]), i))
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    *len -= i;
    return OK;
}

static int extract_precision(printf_data_t *data, int *len, bool *identifier)
{
    int index = 0;
    int res = 0;
    int i = 0;

    if (!data || !len || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    index = my_get_index(data->info, '.');
    if (index < 0)
        return OK;
    for (i = 0; i <= *len - index - 1; i++) {
        res = my_get_index(PRECISION, data->info[*len - i]);
        if (res < 0) {
            *identifier = false;
            return OK;
        }
    }
    if (!my_strncpy(data->info_precision, &(data->info[index + 1]), i))
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    *len -= i + 1;
    return OK;
}

static int extract_modifier(printf_data_t *data, int *len, bool *identifier)
{
    bool res = false;
    int i = 0;

    if (!data || !len || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (i = 1; i <= *len; i++) {
        res = false;
        for (int j = 0; !res && data->modifier[j]; j++) {
            res = (my_strncmp(data->modifier[j],
            &(data->info[*len - i]), i) == 0);
        }
        if (!res)
            break;
    }
    i--;
    if (!my_strncpy(data->info_modifier, &(data->info[*len - i]), i))
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    *len -= i + 1;
    return OK;
}

static int extract_info(printf_data_t *data, bool *identifier)
{
    int len = 0;

    if (!data || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    len = my_strlen(data->info) - 1;
    if (len < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    data->info_specifiers = data->info[len];
    if (malloc_info(data, len + 2, identifier) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (extract_modifier(data, &len, identifier) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (identifier && extract_precision(data, &len, identifier) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (identifier && extract_field(data, &len, identifier) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (identifier && extract_flags(data, &len, identifier) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

static int free_info(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (data->info)
        free(data->info);
    if (data->info_flags)
        free(data->info_flags);
    if (data->info_field)
        free(data->info_field);
    if (data->info_precision)
        free(data->info_precision);
    if (data->info_modifier)
        free(data->info_modifier);
    data->info = NULL;
    return OK;
}

static int check(printf_data_t *data, bool *identifier)
{
    int index = 0;
    int len = 0;

    if (!data || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    index = my_get_index(data->info_precision, '*');
    len = my_strlen(data->info_precision);
    if (index == -2 || len < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (index != -1 && len > 1)
        *identifier = false;
    index = my_get_index(data->info_field, '*');
    len = my_strlen(data->info_field);
    if (index == -2 || len < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if ((index == 0 || index != -1) && len > 1)
        *identifier = false;
    if (index == 0 && len > 1)
        data->invalid_star = true;
    return OK;
}

int identifier(printf_data_t *data, bool *identifier)
{
    if (!data || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (data->str[data->i + 1] == IDENTIFIER) {
        my_putchar(data->fd, IDENTIFIER);
        data->i++;
        *identifier = true;
        return OK;
    }
    if (get_info(data) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (!data->info)
        return OK;
    if (extract_info(data, identifier) == KO || check(data, identifier) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (!(*identifier))
        return free_info(data);
    if (specifiers_dispatch(data) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    data->i += data->end;
    return free_info(data);
}
