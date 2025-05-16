/*
** EPITECH PROJECT, 2025
** sample.c
** File description:
** Sample
*/

#include "sample.h"
#include "error.h"

int sample(int const argc, char const *argv[], main_data_t *data)
{
    if (!data || !argv)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (init_data(data) == KO)
        return err_custom("Data initialisation error", FATAL_ERR, ERR_INFO);
    if (init_flag(data, argc, argv) == KO)
        return err_custom("Flag initialisation error", KO, ERR_INFO);
    if (data->help)
        return OK;
    return OK;
}
