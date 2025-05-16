/*
** EPITECH PROJECT, 2025
** define.h
** File description:
** Header for all global define with no real apartenance to other thing
*/

#ifndef DEFINE_H
    #define DEFINE_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* define */
    #include <unistd.h> // STDERR_FILENO, STDOUT_FILENO, STDIN_FILENO

    //----------------------------------------------------------------//
    /* DEFINE */

    /* ouput */
    #define STDERR STDERR_FILENO
    #define STDOUT STDOUT_FILENO
    #define STDIN STDIN_FILENO

    /* global */
    #define NULL ((void *)0)

    /* acii */
    #define EOF -1
    #define ESC 27

#endif /* DEFINE_H */
