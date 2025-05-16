/*
** EPITECH PROJECT, 2025
** linked_pop_at.c
** File description:
** Pop the node at
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

static int handle_special(linked_list_t **head, linked_list_t *tmp)
{
    if (!head || !tmp)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (tmp == *((*head)->head)) {
        *head = tmp->next;
        *((*head)->head) = *head;
        if (tmp == *((*head)->mid))
            *((*head)->mid) = tmp->next;
        (*head)->previous = NULL;
        tmp->next = NULL;
    } else if (tmp == *((*head)->tail))
        *((*head)->tail) = tmp->previous;
    return OK;
}

static int pop_at(int (*free_func)(void *), linked_list_t **head, int at)
{
    linked_list_t *tmp = NULL;

    if (!free_func || !head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    tmp = *head;
    for (int i = 1; i < *((*head)->size) + 1 && i < at; i++)
        tmp = tmp->next;
    if (handle_special(head, tmp) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (tmp == *((*head)->mid) && tmp->next)
        *((*head)->mid) = tmp->next;
    if (tmp->previous)
        tmp->previous->next = tmp->next;
    if (tmp->next)
        tmp->next->previous = tmp->previous;
    if (free_func(tmp->data) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    free(tmp);
    return OK;
}

int linked_pop_at(int (*free_func)(void *), linked_list_t **head, int at)
{
    if (!free_func || !head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (!(*head))
        return OK;
    (*((*head)->size))--;
    *((*head)->mid_index) -= (at < *((*head)->mid_index));
    if (linked_upd_mid(*head) == KO)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    if (!(*head)->next) {
        if (pop_last(free_func, head) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    } else {
        if (pop_at(free_func, head, at) == KO)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
    }
    return OK;
}
