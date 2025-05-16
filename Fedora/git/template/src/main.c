/*
** EPITECH PROJECT, 2025
** main.c
** File description:
** Main of the project
*/

#include "sample.h"
#include "write.h"
#include "error.h"
#include <stdbool.h>

int main(int const argc, char const *argv[])
{
    main_data_t data = {0};
    int res = 0;

    if (!argv)
        return err_prog(PTR_ERR, EPITECH_ERR, ERR_INFO);
    data.exe_name = argv[0];
    data.help = false;
    data.err_sys = false;
    res = sample(argc, argv, &data);
    if (res == KO || res == FATAL_ERR) {
        if (res != FATAL_ERR)
            free_data(&data);
        if (!data.err_sys) {
            my_putstr(STDERR, data.exe_name);
            my_putstr(STDERR, ": An error has occurred, "
            "execution has been interrupted.\n");
        }
        return EPITECH_ERR;
    }
    return free_data(&data);
}
