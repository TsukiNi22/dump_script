/*
** EPITECH PROJECT, 2025
** hashtable.h
** File description:
** Header for the hashtable function
*/

#ifndef HASHTABLE_H
    #define HASHTABLE_H

    //----------------------------------------------------------------//
    /* INCLUDE */

    /* type */
    #include "array.h" // array_t

    //----------------------------------------------------------------//
    /* DEFINE */

    /* default_param */
    #define DEFAULT_HASH_SIZE 512 // a power of 2 -> 2^9

//----------------------------------------------------------------//
/* TYPDEF */

/* linked_data */
typedef struct hash_linked_data_s {
    int index;
    char *key;
    void *value;
} hash_linked_data_t;

/* hash_table */
typedef struct hashtable_s {
    int keys_nbr;
    int len;
    int (*hash)(char *, int);
    array_t **arrays;
} hashtable_t;

//----------------------------------------------------------------//
/* PROTOTYPE */

/* hash_function */
int hash(char *key, int len); // Error: KO

/* create */
hashtable_t *new_hashtable(int (*hash_function)(char *, int),
    int len); // Error: NULL
int ht_insert(hashtable_t *ht, char *key, void *value,
    int (*free_hash_data)(void *)); // Error: KO

/* destroy */
int delete_hashtable(hashtable_t *ht,
    int (*free_hash_data)(void *)); // Error: KO
int ht_delete(hashtable_t *ht, char *key,
    int (*free_hash_data)(void *)); // Error: KO

/* retrieve */
char **ht_keys(hashtable_t *ht); // Error: NULL
char *ht_search(hashtable_t *ht, char *key); // Error: NULL

/* free */
int free_hash_data_str(void *data); // Error: KO
int free_hash_keys(char **keys); // Error: KO

#endif /* HASHTABLE_H */
