/*
** EPITECH PROJECT, 2025
** identifier.c
** File description:
** Specifier that print the identifier
*/

#include "printf.h"
#include "write.h"
#include "error.h"

int specifiers_identifier(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (my_putchar(data->fd, IDENTIFIER) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
