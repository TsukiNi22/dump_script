/*
** EPITECH PROJECT, 2025
** null.c
** File description:
** Do nothing
*/

#include "macro.h"
#include "sample.h"
#include "error.h"

int flag_null(main_data_t *data, UNUSED int const argc, char const *argv[])
{
    if (!data || !argv)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    return OK;
}
