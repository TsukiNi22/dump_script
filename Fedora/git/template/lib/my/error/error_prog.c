/*
** EPITECH PROJECT, 2025
** error_prog.c
** File description:
** Error print for prog version
*/

#include "define.h"
#include "error.h"
#include <errno.h>
#include <stdbool.h>

void err_prog_v(error_code_t code, err_t err)
{
    errno = KO;
    if (!PUT_ERROR)
        return;
    print_error_prog(code, err);
}

void *err_prog_n(error_code_t code, err_t err)
{
    errno = KO;
    if (!PUT_ERROR)
        return NULL;
    print_error_prog(code, err);
    return NULL;
}

int err_prog(error_code_t code, int to_return, err_t err)
{
    errno = KO;
    if (!PUT_ERROR)
        return to_return;
    print_error_prog(code, err);
    return to_return;
}
