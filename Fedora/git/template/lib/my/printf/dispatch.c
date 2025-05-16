/*
** EPITECH PROJECT, 2025
** dispatch.c
** File description:
** Dispatch to the destined function from the specifiers
*/

#include "printf.h"
#include "my_string.h"
#include "define.h"
#include "error.h"

static int (*const functions[])(printf_data_t *) = {
    &specifiers_identifier, // %
    &specifiers_ouput,      // O
    &specifiers_boolean,    // B
    &specifiers_reset,      // R
    &specifiers_strong,     // S
    &specifiers_color,      // C
    &specifiers_i,          // d
    &specifiers_i,          // i
    &specifiers_base,       // o
    &specifiers_base,       // u
    &specifiers_base,       // x
    &specifiers_base,       // X
    &specifiers_base,       // b
    &specifiers_null,       // e
    &specifiers_null,       // E
    &specifiers_null,       // f
    &specifiers_null,       // F
    &specifiers_null,       // g
    &specifiers_null,       // G
    &specifiers_c,          // c
    &specifiers_s,          // s
    &specifiers_p,          // p
    NULL                    // End
};

static int get_field_precision(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    data->field = 0;
    data->precision = 0;
    if (data->info_field[0] == '*')
        data->field = va_arg(data->ap, int);
    else if (data->info_field[0])
        data->field = my_atoi(data->info_field);
    if (data->info_precision[0] == '*')
        data->precision = va_arg(data->ap, int);
    else if (data->info_precision[0])
        data->precision = my_atoi(data->info_precision);
    return OK;
}

int specifiers_dispatch(printf_data_t *data)
{
    if (!data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (get_field_precision(data) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    for (int i = 0; data->specifiers[i] && functions[i]; i++) {
        if (data->info_specifiers == data->specifiers[i][0])
            return functions[i](data);
    }
    return err_custom("Can't dispatch the specifiers to it's function",
        KO, ERR_INFO);
}
