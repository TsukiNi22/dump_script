/*
** EPITECH PROJECT, 2025
** linked_pop_this.c
** File description:
** Pop the given node
*/

#include "define.h"
#include "linked.h"
#include "error.h"
#include <stdlib.h>

static int pop_last(int (*free_func)(void *), linked_list_t **head)
{
    if (!free_func || !head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    free((*head)->acendant);
    free((*head)->size);
    free((*head)->mid_index);
    free((*head)->head);
    free((*head)->mid);
    free((*head)->tail);
    if (free_func((*head)->data) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    free(*head);
    *head = NULL;
    return OK;
}

static int pop_this(int (*free_func)(void *), linked_list_t **head,
    linked_list_t *pop)
{
    if (!free_func || !head || !pop)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (pop == *((*head)->head)) {
        *head = pop->next;
        *((*head)->head) = *head;
        (*head)->previous = NULL;
    } else if (pop == *((*head)->tail))
        *((*head)->tail) = pop->previous;
    if (pop->previous)
        pop->previous->next = pop->next;
    if (pop->next)
        pop->next->previous = pop->previous;
    if (free_func(pop->data) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    free(pop);
    return OK;
}

int linked_pop_this(int (*free_func)(void *), linked_list_t **head,
    linked_list_t *pop)
{
    if (!free_func || !head || !pop)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (!(*head))
        return OK;
    (*((*head)->size))--;
    *((*head)->mid) = NULL;
    if (linked_upd_mid(*head) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (!(*head)->next) {
        if (pop_last(free_func, head) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    } else {
        if (pop_this(free_func, head, pop) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    return OK;
}
