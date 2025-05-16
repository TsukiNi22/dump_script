/*
** EPITECH PROJECT, 2025
** my_evil_str.c
** File description:
** Return the string but reversed
*/

#include "my_string.h"
#include "memory.h"
#include "define.h"
#include "error.h"
#include <stdlib.h>

char *my_revstr(char *str)
{
    char *evil_str = NULL;
    int len = 0;

    if (!str)
        return err_prog_n(PTR_ERR, ERR_INFO);
    len = my_strlen(str);
    if (len < 0)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    if (my_malloc_c(&evil_str, len) == KO)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    for (int i = 0; str[i]; i++)
        evil_str[len - (i + 1)] = str[i];
    for (int i = 0; str[i]; i++)
        str[i] = evil_str[i];
    free(evil_str);
    return str;
}
