/*
** EPITECH PROJECT, 2025
** my_str_isnum.c
** File description:
** Verif if the given string is only number
*/

#include "error.h"
#include <stdbool.h>

bool my_str_isnum(char const *str)
{
    if (!str)
        return err_prog(PTR_ERR, false, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        if (!(str[i] >= '0' && str[i] <= '9'))
            return false;
    }
    return true;
}
