/*
** EPITECH PROJECT, 2025
** my_str_isnum.c
** File description:
** Verif if the given string is only number
*/

#include "my_string.h"
#include "error.h"
#include <stdbool.h>

bool my_str_is(char const *str, char const *char_in)
{
    if (!str || !char_in)
        return err_prog(PTR_ERR, false, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        if (my_get_index(char_in, str[i]) == -1)
            return false;
    }
    return true;
}
