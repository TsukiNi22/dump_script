/*
** EPITECH PROJECT, 2025
** const.c
** File description:
** Global const
*/

#include "corewar.h"
#include <stddef.h>

char const flags[] = {
    'h',
    '\0',
};

char const *full_flags[] = {
    "--help",
    NULL,
};

int const flags_argc[] = {
    -1, // h
};

int (* const flag_functions[])(main_data_t *, int const, char const *[]) = {
    &flag_null, // h
};
