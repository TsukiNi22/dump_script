/*
** EPITECH PROJECT, 2025
** init_global.c
** File description:
** Init global variable
*/

#include "sample.h"
#include "error.h"
#include <stdbool.h>

int init_global(main_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    return OK;
}
