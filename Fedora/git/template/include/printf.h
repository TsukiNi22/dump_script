/*
** EPITECH PROJECT, 2025
** printf.h
** File description:
** Printf header
*/

#ifndef PRINTF_H
    #define PRINTF_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* type */
    #include "define.h" // STDOUT
    #include <stdbool.h> // boolean
    #include <stdarg.h> // va_list

    //----------------------------------------------------------------//
    /* DEFINE */

    /* default */
    #define DEFAULT_OUPUT STDOUT

    /* flag */
    #define IDENTIFIER '%'
    #define FLAGS "#0- +"
    #define FIELD_WIDHT "0123456789*"
    #define PRECISION "0123456789*"
    #define MODIFIER "l:ll"
    #define SPECIFIERS "%:O:B:R:S:C:d:i:o:u:x:X:b:e:E:f:F:g:G:c:s:p"

//----------------------------------------------------------------//
/* TYPEDEF */

/* unsigned_int */
typedef unsigned long long int llu_t;
typedef unsigned long int lu_t;
typedef unsigned int u_t;

/* int */
typedef long long int lli_t;
typedef long int li_t;
typedef int i_t;

/* data */
typedef struct printf_data_s {
    /* global */
    char **modifier;
    char **specifiers;
    char *str;
    va_list ap;
    int i;
    int fd;

    /* identifier_data */
    bool invalid_star;
    bool c;
    int end;
    char *info;
    char *info_flags;
    char *info_field;
    int field;
    char *info_precision;
    int precision;
    char *info_modifier;
    char info_specifiers;
} printf_data_t;

//----------------------------------------------------------------//
/* PROTOTYPE */

/* printf */
int my_printf(char const *str, ...); // Error: EPITECH_ERR

/* identifier_gestion */
int identifier(printf_data_t *data, bool *identifier); // Error: KO
int specifiers_dispatch(printf_data_t *data); // Error: KO
int specifiers_null(printf_data_t *data); // Error: KO

/* specifiers */
int specifiers_identifier(printf_data_t *data); // Error: KO
int specifiers_ouput(printf_data_t *data); // Error: KO
int specifiers_boolean(printf_data_t *data); // Error: KO
int specifiers_reset(printf_data_t *data); // Error: KO
int specifiers_strong(printf_data_t *data); // Error: KO
int specifiers_color(printf_data_t *data); // Error: KO
int specifiers_i(printf_data_t *data); // Error: KO
int specifiers_base(printf_data_t *data); // Error: KO
int specifiers_c(printf_data_t *data); // Error: KO
int specifiers_s(printf_data_t *data); // Error: KO
int specifiers_p(printf_data_t *data); // Error: KO

#endif /* PRINTF_H */
