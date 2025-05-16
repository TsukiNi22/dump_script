/*
** EPITECH PROJECT, 2025
** my_strndup.c
** File description:
** Copy n char of a str in a new malloced str
*/

#include "my_string.h"
#include "memory.h"
#include "define.h"
#include "error.h"

char *my_strndup(char const *src, int n)
{
    char *str = NULL;
    int len = 0;

    if (!src)
        return err_prog_n(PTR_ERR, ERR_INFO);
    len = my_strlen(src);
    if (len < 0)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    if (len < n)
        return err_prog_n(ARGV_ERR, ERR_INFO);
    if (my_malloc_c(&str, n + 1) == KO)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    if (!my_strncpy(str, src, n))
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    return str;
}
