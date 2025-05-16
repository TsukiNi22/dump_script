/*
** EPITECH PROJECT, 2025
** my_strcomp.c
** File description:
** Comparaison of 2 string
*/

#include "error.h"

int my_strcmp(char const *s1, char const *s2)
{
    int i = 0;

    if (!s1 || !s2)
        return err_prog(PTR_ERR, 501, ERR_INFO);
    for (; s1[i] && s2[i]; i++) {
        if (s1[i] != s2[i])
            return (s1[i] - s2[i]);
    }
    if (s1[i] != s2[i])
        return (s1[i] - s2[i]);
    return 0;
}
