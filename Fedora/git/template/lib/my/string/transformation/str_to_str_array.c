/*
** EPITECH PROJECT, 2025
** my_str_to_word_array.c
** File description:
** Transform a str in a world array
*/

#include "my_string.h"
#include "memory.h"
#include "define.h"
#include "error.h"
#include <stdlib.h>
#include <stdbool.h>

static char *my_strdup_local(char const *base_str, char const *identifier,
    int size, int i)
{
    char *src = NULL;
    char *str = NULL;

    if (!base_str || !identifier)
        return err_prog_n(PTR_ERR, ERR_INFO);
    size -= (!base_str[i + 1] && my_strfind(identifier, base_str[i]) != -1);
    i -= (i > 0);
    for (; i > 0 && my_strfind(identifier, base_str[i]) == -1; i--);
    src = &((char *)base_str)[i + (my_strfind(identifier, base_str[i]) >= 0)];
    if (my_malloc_c(&str, size + 1) == KO)
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    if (!my_strncpy(str, src, size))
        return err_prog_n(UNDEF_ERR, ERR_INFO);
    return str;
}

static int alloc_array(char const *str, char const *identifier,
    char ***str_array)
{
    int count = 0;
    int res = 0;
    bool last = true;

    if (!str || !identifier)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        res = my_strfind(identifier, str[i]);
        if (res == -2)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        if (res >= 0 && !last)
            count++;
        last = (res >= 0);
    }
    count += (res == -1);
    *str_array = malloc(sizeof(char *) * (count + 1));
    if (!(*str_array))
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    (*str_array)[count] = NULL;
    return OK;
}

char **str_to_str_array(char const *str, char const *identifier, bool take)
{
    char **str_array = NULL;
    int count = take;
    int index = 0;

    if (!str || !identifier || alloc_array(str, identifier, &str_array) == KO)
        return err_prog_n(PTR_ERR, ERR_INFO);
    for (int i = 0; str[i]; i++) {
        count += (i > 0 && my_strfind(identifier, str[i - 1]) == -1);
        if ((!str[i + 1] && my_strfind(identifier, str[i]) == -1)
            || (i > 0 && my_strfind(identifier, str[i]) >= 0
            && my_strfind(identifier, str[i - 1]) == -1)) {
            count += (!str[i + 1] || my_strfind(identifier, str[i - 1]) != KO);
            str_array[index] = my_strdup_local(str, identifier, count, i);
            count = take;
            index++;
        }
        if (index > 0 && !str_array[index - 1])
            return err_prog_n(UNDEF_ERR, ERR_INFO);
    }
    return str_array;
}
