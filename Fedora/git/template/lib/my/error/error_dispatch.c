/*
** EPITECH PROJECT, 2025
** error_dispatch.c
** File description:
** Printf / Dispatch error message (type)
*/

#include "define.h"
#include "write.h"
#include "error.h"

static char const *error_message[] = {
    "An Error have ocured in the error return.",
    "Undefinied Error.",
    "The given pointer is NULL.",
    "The allocation attempt with malloc have fail.",
    "The write function have failed.",
    "Incorrect number of argument given to main.",
    "Incorrect input in the given argument.",
    "Unknow flag given for execution.",
    "Overflow on a variable.",
    "'Invalid Permision' or 'No Existant File'.",
    "'Can't' or 'Fail' to read the file.",
    "'Invalid Permision' or 'No Existant Directory.'",
    "'Can't' or 'Fail' to read the directory.",
    NULL
};

int dispatch(error_code_t code)
{
    int res = OK;

    if (code < MIN_ERROR_CODE || code > MAX_ERROR_CODE) {
        res += my_putnbr(STDERR, code);
        res += my_putstr(STDERR, ", Unknow error code.");
    } else
        res += my_putstr(STDERR,
        error_message[code + MIN_ERROR_CODE * -1]);
    if (res != OK)
        return KO;
    return OK;
}
