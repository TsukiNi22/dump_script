/*
** EPITECH PROJECT, 2025
** my_strstr.c
** File description:
** Find the first occurence of a sting in a string
*/

#include "my_string.h"
#include "define.h"
#include "error.h"

char *my_strstr(char *str, char const *to_find)
{
    int len = 0;
    int size = 0;
    int i = 0;

    if (!str || !to_find)
        return err_prog_n(PTR_ERR, ERR_INFO);
    len = my_strlen(to_find);
    if (len < 0)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    for (; size < len && str[i]; i++) {
        if (str[i] == to_find[size])
            size++;
        else
            size = 0;
    }
    if (size >= len)
        return &str[i - len];
    return NULL;
}
