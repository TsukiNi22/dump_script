/*
** EPITECH PROJECT, 2025
** linked_add.c
** File description:
** Get the data of the given id
*/

#include "define.h"
#include "linked.h"
#include "error.h"

void *linked_get_data(linked_list_t *head, int at)
{
    if (!head)
        return err_prog_n(PTR_ERR, ERR_INFO);
    for (int i = 1; head->next && i < at; i++)
        head = head->next;
    return head->data;
}
