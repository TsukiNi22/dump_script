/*
** EPITECH PROJECT, 2025
** ht_insert.c
** File description:
** Insert a element in the ht
*/

#include "my_string.h"
#include "array.h"
#include "define.h"
#include "hashtable.h"
#include "error.h"
#include <stdlib.h>

static int set_value(hash_linked_data_t *data, char *key, void *value,
    int index)
{
    if (!data || !key || !value)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    data->index = index;
    data->key = key;
    data->value = value;
    return OK;
}

int new_value(hash_linked_data_t *data, void *value,
    int (*free_hash_data)(void *))
{
    if (!data || !value || !free_hash_data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    free(data->value);
    data->value = value;
    return OK;
}

int ht_insert(hashtable_t *ht, char *key, void *value,
    int (*free_hash_data)(void *))
{
    hash_linked_data_t *data = NULL;
    array_t *array = NULL;
    int index = 0;

    if (!ht || !key || !value || !free_hash_data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    index = ht->hash(key, ht->len);
    array = ht->arrays[index % ht->len];
    for (unsigned int i = 0; i < array->len; i++) {
        if (((hash_linked_data_t *) array->data[i])->index == index &&
            my_strcmp(((hash_linked_data_t *) array->data[i])->key, key) == 0)
            return new_value(array->data[i], value, free_hash_data);
    }
    ht->keys_nbr++;
    data = malloc(sizeof(hash_linked_data_t));
    if (set_value(data, key, value, index) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (add_array(array, data) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
