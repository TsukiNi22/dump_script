/*
** EPITECH PROJECT, 2025
** delete_linked.c
** File description:
** DElete linked list
*/

#include "linked.h"
#include "error.h"
#include <stdlib.h>

int delete_linked(int (*free_func)(void *), linked_list_t **head)
{
    linked_list_t *tmp = NULL;

    if (!free_func || !head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (*head) {
        free((*head)->acendant);
        free((*head)->size);
        free((*head)->mid_index);
        free((*head)->head);
        free((*head)->mid);
        free((*head)->tail);
    }
    while (*head) {
        tmp = (*head)->next;
        if (free_func((*head)->data) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        free(*head);
        *head = tmp;
    }
    return OK;
}
