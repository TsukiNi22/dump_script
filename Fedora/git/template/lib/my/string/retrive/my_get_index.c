/*
** EPITECH PROJECT, 2025
** my_get_index.c
** File description:
** Get the index of the char in the given string
*/

#include "printf.h"
#include "error.h"

int my_get_index(char const *str, char const c)
{
    if (!str)
        return err_prog(PTR_ERR, -2, ERR_INFO);
    for (int i = 0; i[str]; i++) {
        if (i[str] == c && !(i == 0 && c == IDENTIFIER))
            return i;
    }
    return -1;
}
