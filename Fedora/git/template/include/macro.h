/*
** EPITECH PROJECT, 2025
** my_macro_abs.h
** File description:
** Header for all macro
*/

#ifndef MACRO_H
    #define MACRO_H

    //----------------------------------------------------------------//
    /* MACRO */

    /* __attribute__ */
    #define USED __attribute__((used))
    #define UNUSED __attribute__((unused))
    #define AUTOFREE __attribute__((cleanup(free)))
    #define AUTOCLOSE __attribute__((cleanup(close)))

    /* condition */
    #define LIKELY(c)   __builtin_expect(!!(c), 1)
    #define UNLIKELY(c) __builtin_expect(!!(c), 0)

    /* usefull */
    #define QUIT(condition, literal) if (condition) return literal

    /* math */
    #define ABS(x) x = ((x) * (1 - 2 * (x < 0 || x == -0)))

    /* string */
    #define GET_BOOL_STR(c) ((c) ? "true" : "false")

    /* binary */
    #define LEFT_BITS_ROTATE(n, r, s) (n << r) | (n >> (s - r))
    #define RIGHT_BITS_ROTATE(n, r, s) (n >> r) | (n << (s - r))

#endif /* MACRO_H */
