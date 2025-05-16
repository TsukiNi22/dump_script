/*
** EPITECH PROJECT, 2025
** new_hashtable.c
** File description:
** Create a new hashtable
*/

#include "array.h"
#include "define.h"
#include "hashtable.h"
#include "error.h"
#include <stdlib.h>

hashtable_t *new_hashtable(int (*hash_function)(char *, int), int len)
{
    hashtable_t *ht = NULL;

    if (!hash_function)
        return err_prog_n(PTR_ERR, ERR_INFO);
    if (len < 1)
        return err_prog_n(ARGV_ERR, ERR_INFO);
    ht = malloc(sizeof(hashtable_t));
    if (!ht)
        return err_prog_n(MALLOC_ERR, ERR_INFO);
    ht->keys_nbr = 0;
    ht->len = len;
    ht->hash = hash_function;
    ht->arrays = malloc(sizeof(array_t *) * len);
    if (!ht->arrays)
        return err_prog_n(MALLOC_ERR, ERR_INFO);
    for (int i = 0; i < len; i++)
        ht->arrays[i] = new_array();
    return ht;
}
