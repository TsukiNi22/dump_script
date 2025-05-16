/*
** EPITECH PROJECT, 2025
** linked.h
** File description:
** Header for the linked
*/

#ifndef LINKED_H
    #define LINKED_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* type */
    #include <stdbool.h> // boolean

//----------------------------------------------------------------//
/* PROTOTYPE */

/* linked */
typedef struct linked_list_s {
    /* mid_localisation */
    int *mid_index;
    bool *acendant;

    /* global_shared_information */
    int *size;
    struct linked_list_s **head;
    struct linked_list_s **mid;
    struct linked_list_s **tail;

    /* data */
    void *data;

    /* deplacement */
    struct linked_list_s *previous;
    struct linked_list_s *next;
} linked_list_t;

//----------------------------------------------------------------//
/* PROTOTYPE */

/* gestion */ // Error: KO
int linked_add(linked_list_t **head, void *data);
int linked_add_at(linked_list_t **head, void *data, int at);
int linked_pop(int (*free_func)(void *), linked_list_t **head);
int linked_pop_at(int (*free_func)(void *), linked_list_t **head, int at);
int linked_pop_this(int (*free_func)(void *), linked_list_t **head,
    linked_list_t *pop);
int linked_upd_mid(linked_list_t *head);
int delete_linked(int (*free_func)(void *), linked_list_t **head);

/* get_info */
void *linked_get_data(linked_list_t *head, int at); // Error: NULL

#endif /* LINKED_H */
