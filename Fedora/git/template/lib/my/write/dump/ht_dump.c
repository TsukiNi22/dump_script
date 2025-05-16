/*
** EPITECH PROJECT, 2025
** ht_dump.c
** File description:
** Print the hashtable
*/

#include "write.h"
#include "array.h"
#include "hashtable.h"
#include "error.h"
#include "define.h"

static int print_array(array_t *array)
{
    hash_linked_data_t *data = NULL;
    int res = OK;

    for (unsigned int i = 0; i < array->len; i++) {
        data = (hash_linked_data_t *) array->data[i];
        res += my_printf("> %d - \"%s\" - \"%s\"\n",
        data->index, data->key, data->value);
    }
    if (res < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    return OK;
}

int ht_dump(hashtable_t *ht)
{
    int res = OK;

    if (!ht)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (int i = 0; i < ht->len; i++) {
        res += my_printf("[%d]:\n", i);
        res += print_array(ht->arrays[i]);
        if (res < 0)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    return OK;
}
