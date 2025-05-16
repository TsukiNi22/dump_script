/*
** EPITECH PROJECT, 2025
** write.h
** File description:
** Header for all function who print something
*/

#ifndef WRITE_H
    #define WRITE_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* function */
    #include "printf.h" // my_printf

    /* type */
    #include "linked.h" // linked_list_t
    #include "hashtable.h" // hashtable_t
    #include "array.h" // array_t

    //----------------------------------------------------------------//
    /* DEFINE */

    /* write */
    #define BASE_OCT "01234567"
    #define BASE_DEC "0123456789"
    #define BASE_HEX "0123456789abcdef"

//----------------------------------------------------------------//
/* TYPEDEF */

/* color */
typedef enum color_e {
    BLACK = 30,
    RED,
    GREEN,
    YELLOW,
    BLUE,
    MAGENTA,
    CYAN,
    WHITE
} color_t;

typedef enum back_color_e {
    B_BLACK = 40,
    B_RED,
    B_GREEN,
    B_YELLOW,
    B_BLUE,
    B_MAGENTA,
    B_CYAN,
    B_WHITE
} back_color_t;

//----------------------------------------------------------------//
/* PROTOTYPE */

/* ouput_reset */
int reset_ouput(int fd); // Error: KO

/* ouput_style */
int strong(int fd); // Error: KO
int dark(int fd); // Error: KO
int italic(int fd); // Error: KO
int underlined(int fd); // Error: KO
int flashing_slow(int fd); // Error: KO
int flashing_fast(int fd); // Error: KO
int reversed(int fd); // Error: KO
int hide(int fd); // Error: KO
int bar(int fd); // Error: KO

/* cursor */
int cursor_up(int fd, int n); // Error: KO
int cursor_down(int fd, int n); // Error: KO
int cursor_left(int fd, int n); // Error: KO
int cursor_right(int fd, int n); // Error: KO
int cursor_next_line(int fd, int n); // Error: KO
int cursor_previous_line(int fd, int n); // Error: KO
int cursor_co(int fd, int x, int y); // Error: KO
int cursor_save(int fd); // Error: KO
int cursor_load(int fd); // Error: KO
int cursor_hide(int fd); // Error: KO
int cursor_show(int fd); // Error: KO

/* ouput_clear */
int erase_line(int fd); // Error: KO
int erase_line_start(int fd); // Error: KO
int erase_line_end(int fd); // Error: KO
int erase_screen(int fd); // Error: KO
int erase_screen_start(int fd); // Error: KO
int erase_screen_end(int fd); // Error: KO

/* ouput_color */
int back_color(int fd, back_color_t back); // Error: KO
int back_color_rgb(int fd, unsigned char r, unsigned char g,
    unsigned char b); // Error: KO
int color(int fd, color_t color); // Error: KO
int color_rgb(int fd, unsigned char r, unsigned char g,
    unsigned char b); // Error: KO

/* string */
int my_putchar(int fd, char const c); // Error: KO
int my_putstr(int fd, char const *str); // Error: KO

/* math */
int my_putnbr(int fd, long long nb); // Error: KO
int my_putnbr_base(int fd, unsigned long long nbr,
    char const *base); // Error: KO

/* dump */
int str_array_dump(char **array); // Error: KO
int ht_dump(hashtable_t *ht); // Error: KO
int array_dump(array_t *array, int (*display_ptr)(void *)); // Error: KO
int linked_dump(int (*display_data)(void *data),
    linked_list_t *head); // Error: KO

#endif /* WRITE_H */
