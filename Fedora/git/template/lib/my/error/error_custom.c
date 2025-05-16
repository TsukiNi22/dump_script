/*
** EPITECH PROJECT, 2025
** error_custom.c
** File description:
** Error print for custom version
*/

#include "define.h"
#include "error.h"
#include <errno.h>
#include <stdbool.h>

void err_custom_v(char const *info, err_t err)
{
    errno = KO;
    if (!info)
        error_error();
    if (!CUSTOM_PUT_ERROR || !info)
        return;
    print_error_custom(info, err);
}

void *err_custom_n(char const *info, err_t err)
{
    errno = KO;
    if (!info)
        error_error();
    if (!CUSTOM_PUT_ERROR || !info)
        return NULL;
    print_error_custom(info, err);
    return NULL;
}

int err_custom(char const *info, int to_return, err_t err)
{
    errno = KO;
    if (!info)
        error_error();
    if (!CUSTOM_PUT_ERROR || !info)
        return to_return;
    print_error_custom(info, err);
    return to_return;
}
