/*
** EPITECH PROJECT, 2025
** concat_params.c
** File description:
** All param in one str
*/

#include "my_string.h"
#include "memory.h"
#include "define.h"
#include "error.h"

static int get_size(char **array)
{
    int size = 0;
    int res = 0;

    if (!array)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (int i = 0; array[i]; i++) {
        res = my_strlen(array[i]);
        if (res < 0)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        size += res + 1;
    }
    return size;
}

char *concat_params(char **array)
{
    char *str = NULL;
    int size = 0;

    if (!array)
        return err_prog_n(PTR_ERR, ERR_INFO);
    size = get_size(array);
    if (size < 0)
        return err_prog_n(ARGV_ERR, ERR_INFO);
    if (my_malloc_c(&str, size) == KO)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    for (int i = 0; array[i]; i++) {
        if (!my_strcat(str, array[i]))
            return err_prog_n(UNDEF_ERR, ERR_INFO);
        if (!my_strcat(str, " "))
            return err_prog_n(UNDEF_ERR, ERR_INFO);
    }
    return str;
}
