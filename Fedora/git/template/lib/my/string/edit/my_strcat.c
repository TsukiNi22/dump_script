/*
** EPITECH PROJECT, 2025
** my_strcat.c
** File description:
** Concatenates two string
*/

#include "my_string.h"
#include "define.h"
#include "error.h"

char *my_strcat(char *dest, char const *src)
{
    int len = 0;

    if (!dest || !src)
        return err_prog_n(PTR_ERR, ERR_INFO);
    len = my_strlen(dest);
    if (len < 0)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    for (int i = 0; src[i]; i++)
        dest[len + i] = src[i];
    return dest;
}
