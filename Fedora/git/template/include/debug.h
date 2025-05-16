/*
** EPITECH PROJECT, 2025
** debug.h
** File description:
** Header with include useful for debugin
*/

#ifndef DEBUG_H
    #define DEBUG_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* debug */
    #include <criterion/criterion.h> // unit test
    #include <criterion/redirect.h> // unit test -> stderr / stdout

//----------------------------------------------------------------//
/* PROTOTYPE */

/* sdtout_stderr */
void redirect(void);

#endif /* DEBUG_H */
