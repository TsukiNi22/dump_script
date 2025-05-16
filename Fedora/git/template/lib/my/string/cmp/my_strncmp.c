/*
** EPITECH PROJECT, 2025
** my_strncmp.c
** File description:
** Comparaison of 2 string a n char
*/

#include "error.h"

int my_strncmp(char const *s1, char const *s2, int n)
{
    int i = 0;

    if (!s1 || !s2)
        return err_prog(PTR_ERR, 501, ERR_INFO);
    for (; s1[i] && s2[i] && i < n; i++) {
        if (s1[i] != s2[i])
            return (s1[i] - s2[i]);
    }
    if (s1[i] != s2[i] && i < n)
        return (s1[i] - s2[i]);
    return 0;
}
