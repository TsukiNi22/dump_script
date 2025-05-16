/*
** EPITECH PROJECT, 2025
** my_strupcase.c
** File description:
** Make all char in uppercase
*/

#include "define.h"
#include "error.h"

char *my_strupcase(char *str)
{
    if (!str)
        return err_prog_n(PTR_ERR, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        if (str[i] <= 'z' && str[i] >= 'a')
            str[i] = (char) ((int) str[i] - 32);
    }
    return str;
}
