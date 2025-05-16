/*
** EPITECH PROJECT, 2025
** ht_keys.c
** File description:
** Retrevie the list of the keys
*/

#include "define.h"
#include "memory.h"
#include "array.h"
#include "hashtable.h"
#include "error.h"
#include <stdlib.h>

static int add_key(char **keys, char *key, int *index)
{
    if (!keys || !key || !index)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    keys[*index] = my_strdup(key);
    if (!keys[*index])
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    (*index)++;
    return OK;
}

char **ht_keys(hashtable_t *ht)
{
    char **keys = NULL;
    char *key = NULL;
    int index = 0;
    int res = OK;

    if (!ht)
        return err_prog_n(PTR_ERR, ERR_INFO);
    keys = malloc(sizeof(char *) * (ht->keys_nbr + 1));
    if (!keys)
        return err_prog_n(MALLOC_ERR, ERR_INFO);
    keys[ht->keys_nbr] = NULL;
    for (int i = 0; i < ht->len; i++) {
        for (unsigned int j = 0; j < ht->arrays[i]->len; j++) {
            key = ((hash_linked_data_t *) ht->arrays[i]->data[j])->key;
            res += add_key(keys, key, &index);
        }
        if (res != OK)
            return err_prog_n(UNDEF_ERR, ERR_INFO);
    }
    return keys;
}
