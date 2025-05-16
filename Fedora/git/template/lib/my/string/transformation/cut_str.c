/*
** EPITECH PROJECT, 2025
** my_cut_str.c
** File description:
** Return the array after or befor the given point
*/

#include "my_string.h"
#include "memory.h"
#include "define.h"
#include "error.h"
#include <stdbool.h>

char *cut_str(const char *str, const bool before, int cut_place)
{
    char *new_str = NULL;
    int index = 0;
    int len = 0;

    if (!str)
        return err_prog_n(PTR_ERR, ERR_INFO);
    len = my_strlen(str);
    if (len < 0)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    if (cut_place > len || cut_place < 0)
        return err_prog_n(ARGV_ERR, ERR_INFO);
    if (my_malloc_c(&new_str, len) == KO)
        return err_prog_n(MALLOC_ERR, ERR_INFO);
    for (int i = cut_place - before; i >= 0 && str[i]; i += 1 - 2 * before) {
        new_str[index] = str[i];
        index++;
    }
    if (before && cut_place > 0 && !my_revstr(new_str))
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    return new_str;
}
