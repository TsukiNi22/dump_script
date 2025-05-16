/*
** EPITECH PROJECT, 2025
** error_system.c
** File description:
** Error print for system version
*/

#include "define.h"
#include "sample.h"
#include "write.h"
#include "error.h"
#include <errno.h>
#include <stdbool.h>

void err_system_v(void *data, char const *info, char const *err)
{
    errno = KO;
    if (!err)
        error_error();
    if (data)
        ((main_data_t *) data)->err_sys = true;
    if (!SYSTEM_PUT_ERROR)
        return;
    print_error_system(info, err);
}

void *err_system_n(void *data, char const *info, char const *err)
{
    errno = KO;
    if (!err)
        error_error();
    if (data)
        ((main_data_t *) data)->err_sys = true;
    if (!SYSTEM_PUT_ERROR)
        return NULL;
    print_error_system(info, err);
    return NULL;
}

int err_system(void *data, int to_return, char const *info, char const *err)
{
    errno = KO;
    if (!err)
        error_error();
    if (data)
        ((main_data_t *) data)->err_sys = true;
    if (!SYSTEM_PUT_ERROR)
        return to_return;
    print_error_system(info, err);
    return to_return;
}
