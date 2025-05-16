/*
** EPITECH PROJECT, 2025
** my_str_isalpha.c
** File description:
** Verif if the given string is only upper case
*/

#include "error.h"
#include <stdbool.h>

bool my_str_isupper(char const *str)
{
    if (!str)
        return err_prog(PTR_ERR, false, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        if (!(str[i] >= 'A' && str[i] <= 'Z'))
            return false;
    }
    return true;
}
