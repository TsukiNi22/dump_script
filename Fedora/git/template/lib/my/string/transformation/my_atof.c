/*
** EPITECH PROJECT, 2025
** my_atof.c
** File description:
** Return the float of a string
*/

#include "my_string.h"
#include "memory.h"
#include "error.h"
#include <stdlib.h>
#include <stdbool.h>

long double str_to_float(char *integer, char *decimal)
{
    long double nb = 0.0;
    long long integer_int = 0;
    long long decimal_int = 0;
    int zero_nb = 0;

    if (!integer || !decimal)
        return err_prog(PTR_ERR, 0, ERR_INFO);
    for (int i = 0; decimal[i] && decimal[i] == '0'; i++)
        zero_nb++;
    integer_int = my_atoi(integer);
    decimal_int = my_atoi(&decimal[zero_nb]);
    nb = decimal_int;
    while (nb > 1)
        nb /= 10.0;
    for (int i = 0; i < zero_nb; i++)
        nb /= 10.0;
    nb += integer_int * (1 - 2 * (integer_int < 0));
    nb *= 1 - 2 * (integer_int < 0);
    return nb;
}

long double my_atof(char *str)
{
    long double nb = 0.0;
    int dot_index = 0;
    char *cp_str = NULL;

    if (!str)
        return err_prog(PTR_ERR, 0, ERR_INFO);
    dot_index = my_strfind(str, '.');
    if (dot_index == -2)
        return err_prog(PTR_ERR, 0, ERR_INFO);
    if (dot_index < 0)
        return my_atoi(str);
    cp_str = my_strdup(str);
    if (!cp_str)
        return err_prog(PTR_ERR, 0, ERR_INFO);
    cp_str[dot_index] = '\0';
    nb = str_to_float(cp_str, &cp_str[dot_index + 1]);
    free(cp_str);
    return nb;
}
