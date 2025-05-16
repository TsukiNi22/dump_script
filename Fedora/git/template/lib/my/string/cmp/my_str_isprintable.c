/*
** EPITECH PROJECT, 2025
** my_str_isprintable.c
** File description:
** Return if the given string only contain printable char
*/

#include "error.h"
#include <stdbool.h>

bool my_str_isprintable(char const *str)
{
    if (!str)
        return err_prog(PTR_ERR, false, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        if (!((unsigned) str[i] >= 0 && (unsigned) str[i] <= 127))
            return false;
    }
    return true;
}
