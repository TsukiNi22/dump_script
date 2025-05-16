/*
** EPITECH PROJECT, 2025
** sample.h
** File description:
** Sample header
*/

#ifndef SAMPLE_H
    #define SAMPLE_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* type */
    #include <stdbool.h> // boolean

//----------------------------------------------------------------//
/* TYPEDEF */

/* data */
typedef struct main_data_s {
    /* global_info */
    char const *exe_name;

    /* ouput */
    bool help;
    bool err_sys;
} main_data_t;

//----------------------------------------------------------------//
/* PROTOTYPE */

/* sample */ // Error: KO
int sample(int const argc, char const *argv[], main_data_t *data);

/* init_data */
int init_data(main_data_t *data); // Error: KO
int init_global(main_data_t *data); // Error: KO

/* init_flag */
int init_flag(main_data_t *data,
    int const argc, char const *argv[]); // Error: KO
int flag_help(void); // Error: KO
int flag_null(main_data_t *data,
    int const argc, char const *argv[]); // Error: KO

/* exit */
int free_data(main_data_t *data); // Error: EPITECH_ERR

//----------------------------------------------------------------//
/* GLOBAL_CONST */

/* flag */
extern char const flags[];
extern char const *full_flags[];
extern int const flags_argc[];
extern int (* const flag_functions[])(main_data_t *,
    int const, char const *[]);

#endif /* SAMPLE_H */
