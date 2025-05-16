/*
** EPITECH PROJECT, 2025
** error.h
** File description:
** Header for the error handling / error code
*/

#ifndef ERROR_H
    #define ERROR_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* type */
    #include <stdbool.h> // boolean

    //----------------------------------------------------------------//
    /* DEFINE */

    /* error_info */
    #define ERR_INFO ((err_t){__FILE__, __func__, __LINE__})

    /* error_return_write */
    #define PUT_ERROR 1
    #define CUSTOM_PUT_ERROR 1
    #define SYSTEM_PUT_ERROR 1

    /* error_return */
    #define KO -1
    #define OK 0
    #define FATAL_ERR 255

    /* epitech_error_return */
    #define ERROR 84
    #define ERR 84
    #define EPITECH_ERR 84

    /* error_code */
    #define MIN_ERROR_CODE ERROR_ERR
    #define MAX_ERROR_CODE READ_DIR_ERR

//----------------------------------------------------------------//
/* TYPDEF */

/* error_code */
typedef enum error_code_e {
    ERROR_ERR = -2,
    UNDEF_ERR = -1,
    PTR_ERR = 0,
    MALLOC_ERR,
    WRITE_ERR,
    ARGC_ERR,
    ARGV_ERR,
    FLAG_ERR,
    OVERFLOW,
    OP_FILE_ERR,
    READ_FILE_ERR,
    OP_DIR_ERR,
    READ_DIR_ERR
} error_code_t;

/*
** For more detail in the error, look in /lib/my/error/error_dispatch.c
*/

//----------------------------------------------------------------//
/* TYPEDEF */

typedef struct err_s {
    char const *file;
    char const *func;
    int const line;
} err_t;

//----------------------------------------------------------------//
/* PROTOTYPE */

/* error_handling */ // Error: None
void err_prog_v(error_code_t code, err_t err);
void *err_prog_n(error_code_t code, err_t err);
int err_prog(error_code_t code, int to_return, err_t err);
void err_custom_v(char const *info, err_t err);
void *err_custom_n(char const *info, err_t err);
int err_custom(char const *info, int to_return, err_t err);
void err_system_v(void *data, char const *info, char const *err);
void *err_system_n(void *data, char const *info, char const *err);
int err_system(void *data, int to_return, char const *info, char const *err);

/* print_error_ouput */
void error_error(void); // Error: None
int dispatch(error_code_t code); // Error: KO
void print_error_system(char const *info, char const *err); // Error: None
void print_error_custom(char const *info, err_t err); // Error: None
void print_error_prog(error_code_t code, err_t err); // Error: None

#endif /* ERROR_H */
