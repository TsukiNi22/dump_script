/*
** EPITECH PROJECT, 2025
** str_array_dump.c
** File description:
** Show the tab given
*/

#include "my_string.h"
#include "write.h"
#include "error.h"
#include <unistd.h>

int str_array_dump(char **array)
{
    if (!array)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (int i = 0; array[i]; i++) {
        if (my_printf("array[%d]=\"%s\"\n", i, array[i]) == KO)
            return err_prog(WRITE_ERR, KO, ERR_INFO);
    }
    return OK;
}
