/*
** EPITECH PROJECT, 2025
** ht_search.c
** File description:
** Retrive the data of the given key
*/

#include "my_string.h"
#include "define.h"
#include "hashtable.h"
#include "error.h"

char *ht_search(hashtable_t *ht, char *key)
{
    hash_linked_data_t *data = NULL;
    array_t *array = NULL;
    unsigned int i = 0;
    int index = 0;

    if (!ht || !key)
        return err_prog_n(PTR_ERR, ERR_INFO);
    index = ht->hash(key, ht->len);
    array = ht->arrays[index % ht->len];
    for (i = 0; !data && i < array->len; i++) {
        if (((hash_linked_data_t *) array->data[i])->index == index &&
            my_strcmp(((hash_linked_data_t *) array->data[i])->key, key) == 0)
            data = ((hash_linked_data_t *) array->data[i]);
    }
    if (!data)
        return err_custom_n("There is no data for this key", ERR_INFO);
    return data->value;
}
