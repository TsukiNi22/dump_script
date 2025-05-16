/*
** EPITECH PROJECT, 2025
** my_strfind.c
** File description:
** Find a char in the given array and retur nthe place
*/

#include "error.h"

int my_strfind(const char *char_array, const char find_char)
{
    int place = 0;

    if (!char_array)
        return err_prog(PTR_ERR, -2, ERR_INFO);
    for (; char_array[place] && char_array[place] != find_char; place++);
    if (char_array[place] == '\0' && find_char != '\0')
        return KO;
    return place;
}
