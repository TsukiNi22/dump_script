/*
** EPITECH PROJECT, 2025
** linked_add_at.c
** File description:
** Add a node at
*/

#include "define.h"
#include "linked.h"
#include "error.h"
#include <stdlib.h>
#include <stdbool.h>

static int add_new(linked_list_t **head, linked_list_t *new)
{
    if (!head || !new)
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
    *(new->mid_index) = 1;
    *(new->head) = new;
    *(new->mid) = new;
    *(new->tail) = new;
    new->next = NULL;
    new->previous = NULL;
    *head = new;
    return OK;
}

static int add_head(linked_list_t **head, linked_list_t *new)
{
    if (!head || !new)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    (*head)->previous = new;
    new->next = *head;
    new->previous = NULL;
    *((*head)->head) = new;
    *head = new;
    return OK;
}

static int add_mid(linked_list_t *tmp, linked_list_t *new, int at)
{
    if (!tmp || !new)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    for (int i = 0; i < at; i++)
        tmp = tmp->next;
    new->next = tmp;
    new->previous = tmp->previous;
    if (tmp->previous)
        tmp->previous->next = new;
    tmp->previous = new;
    return OK;
}

static int add_tail(linked_list_t **head, linked_list_t *new)
{
    linked_list_t *tail = NULL;

    if (!head || !new)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    tail = *((*head)->tail);
    tail->next = new;
    new->next = NULL;
    new->previous = tail;
    *((*head)->tail) = new;
    return OK;
}

static int add_new_alr(linked_list_t *new, linked_list_t **head, int at)
{
    if (!new || !head || !(*head))
        return err_prog(PTR_ERR, KO, ERR_INFO);
    new->acendant = (*head)->acendant;
    new->size = (*head)->size;
    new->mid_index = (*head)->mid_index;
    new->head = (*head)->head;
    new->mid = (*head)->mid;
    new->tail = (*head)->tail;
    if (at <= 0)
        return add_head(head, new);
    else if (at >= *((*head)->size))
        return add_tail(head, new);
    return add_mid(*head, new, at);
}

int linked_add_at(linked_list_t **head, void *data, int at)
{
    linked_list_t *new = NULL;

    if (!head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    new = malloc(sizeof(linked_list_t));
    if (!new)
        return err_prog(MALLOC_ERR, KO, ERR_INFO);
    new->data = data;
    if (!(*head)) {
        if (add_new(head, new) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    } else {
        if (add_new_alr(new, head, at) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        *((*head)->mid_index) += (at < *((*head)->mid_index));
    }
    (*((*head)->size))++;
    return linked_upd_mid(*head);
}
