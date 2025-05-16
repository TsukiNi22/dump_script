/*
** EPITECH PROJECT, 2025
** array.h
** File description:
** Header for the array
*/

#ifndef ARRAY_H
    #define ARRAY_H

    //----------------------------------------------------------------//
    /* DEFINE */

    /* default_param */
    #define DEFAULT_ARRAY_SIZE 1

//----------------------------------------------------------------//
/* TYPEDEF */

/* array */
typedef struct array_s {
    /* global_info */
    unsigned int len;
    unsigned int size;

    /* data */
    void **data;
} array_t;

//----------------------------------------------------------------//
/* PROTOTYPE */

/* init */
array_t *new_array(void); // Error: NULL

/* edit */ // Error: KO
int add_array(array_t *array, void *data);
int pop_array(array_t *array, int (*free_ptr)(void *), unsigned int index);

/* free */
int delete_array(array_t **array, int (*free_ptr)(void *)); // Error: KO

#endif /* ARRAY_H */
