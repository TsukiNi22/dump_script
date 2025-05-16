/*
** EPITECH PROJECT, 2025
** ht_delete.c
** File description:
** Delete a element in the ht
*/

#include "my_string.h"
#include "array.h"
#include "define.h"
#include "hashtable.h"
#include "error.h"
#include <stdlib.h>

int ht_delete(hashtable_t *ht, char *key, int (*free_hash_data)(void *))
{
    hash_linked_data_t *data = NULL;
    array_t *array = NULL;
    unsigned int i = 0;
    int index = 0;

    if (!ht || !key || !free_hash_data)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    index = ht->hash(key, ht->len);
    array = ht->arrays[index % ht->len];
    for (i = 0; !data && i < array->len; i++) {
        if (((hash_linked_data_t *) array->data[i])->index == index &&
            my_strcmp(((hash_linked_data_t *) array->data[i])->key, key) == 0)
            data = ((hash_linked_data_t *) array->data[i]);
    }
    if (!data)
        return err_custom("There is no data for this key", KO, ERR_INFO);
    ht->keys_nbr--;
    if (pop_array(array, free_hash_data, i) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}
