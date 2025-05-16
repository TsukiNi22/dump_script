/*
** EPITECH PROJECT, 2025
** error_print.c
** File description:
** Print the error message (information)
*/

#include "define.h"
#include "write.h"
#include "error.h"
#include <unistd.h>
#include <stdbool.h>

void error_error(void)
{
    write(STDERR, "\n", 1);
    write(STDERR, "----------------------ERROR----------------------\n", 49);
    write(STDERR, "Error: An Error have ocured in the error return.\n", 49);
    write(STDERR, "----------------------ERROR----------------------\n", 49);
    write(STDERR, "\n", 1);
}

void print_error_system(char const *info, char const *err)
{
    int res = OK;

    if (!err) {
        error_error();
        return;
    }
    res += reset_ouput(STDERR);
    if (info) {
        res += color_rgb(STDERR, 192, 192, 192);
        res += my_putstr(STDERR, info);
        res += my_putstr(STDERR, ": ");
    }
    res += color_rgb(STDERR, 0, 255, 255);
    res += my_putstr(STDERR, err);
    res += my_putchar(STDERR, '.');
    res += my_putchar(STDERR, '\n');
    res += reset_ouput(STDERR);
    if (res != OK)
        error_error();
}

static int print_error_head(void)
{
    int res = OK;

    res += reset_ouput(STDERR);
    res += strong(STDERR);
    res += my_putstr(STDERR, "-------------");
    res += color(STDERR, RED);
    res += my_putstr(STDERR, "[ERROR]");
    res += reset_ouput(STDERR);
    res += strong(STDERR);
    res += my_putstr(STDERR, "-------------\n");
    res += reset_ouput(STDERR);
    if (res != OK)
        return KO;
    return OK;
}

static int print_error_tail(void)
{
    int res = OK;

    res += reset_ouput(STDERR);
    res += strong(STDERR);
    res += my_putstr(STDERR, "\n--------------------------------\n\n");
    res += reset_ouput(STDERR);
    if (res != OK)
        return KO;
    return OK;
}

static int print_error_info(err_t err)
{
    int res = OK;

    res += reset_ouput(STDERR);
    res += color_rgb(STDERR, 192, 192, 192);
    res += my_putstr(STDERR, err.file);
    res += my_putstr(STDERR, ", ");
    res += my_putstr(STDERR, err.func);
    res += my_putstr(STDERR, ", line ");
    res += my_putnbr(STDERR, err.line);
    res += my_putstr(STDERR, ": ");
    res += reset_ouput(STDERR);
    if (res != OK)
        return KO;
    return OK;
}

void print_error_custom(char const *info, err_t err)
{
    int res = OK;

    if (!info) {
        error_error();
        return;
    }
    res += print_error_head();
    res += print_error_info(err);
    res += color_rgb(STDERR, 0, 255, 255);
    res += my_putstr(STDERR, info);
    res += my_putchar(STDERR, '.');
    res += print_error_tail();
    if (res != OK)
        error_error();
}

void print_error_prog(error_code_t code, err_t err)
{
    int res = OK;

    res += print_error_head();
    res += print_error_info(err);
    res += color_rgb(STDERR, 0, 255, 255);
    res += dispatch(code);
    res += print_error_tail();
    if (res != OK)
        error_error();
}
