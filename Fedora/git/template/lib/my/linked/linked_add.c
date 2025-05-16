/*
** EPITECH PROJECT, 2025
** linked_add.c
** File description:
** Add a node
*/

#include "define.h"
#include "linked.h"
#include "error.h"
#include <stdlib.h>
#include <stdbool.h>

static int add_new(linked_list_t *new)
{
    if (!new)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    new->acendant = malloc(sizeof(bool));
    new->size = malloc(sizeof(int));
    new->mid_index = malloc(sizeof(int));
    new->head = malloc(sizeof(linked_list_t *));
    new->mid = malloc(sizeof(linked_list_t *));
    new->tail = malloc(sizeof(linked_list_t *));
    if (!new->acendant || !new->size || !new->mid_index
        || !new->head || !new->mid || !new->tail)
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    *(new->size) = 0;
    *(new->mid_index) = 0;
    *(new->mid) = new;
    *(new->tail) = new;
    new->next = NULL;
    new->previous = NULL;
    return OK;
}

static int add_new_alr(linked_list_t *new, linked_list_t **head)
{
    if (!new || !head || !(*head))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    new->acendant = (*head)->acendant;
    new->size = (*head)->size;
    new->mid_index = (*head)->mid_index;
    new->head = (*head)->head;
    new->mid = (*head)->mid;
    new->tail = (*head)->tail;
    new->next = *head;
    new->previous = NULL;
    (*head)->previous = new;
    return OK;
}

int linked_add(linked_list_t **head, void *data)
{
    linked_list_t *new = NULL;

    if (!head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    new = malloc(sizeof(linked_list_t));
    if (!new)
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    new->data = data;
    if (!(*head)) {
        if (add_new(new) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    } else {
        if (add_new_alr(new, head) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    *head = new;
    (*((*head)->size))++;
    (*((*head)->head)) = new;
    (*((*head)->mid_index))++;
    return linked_upd_mid(*head);
}
