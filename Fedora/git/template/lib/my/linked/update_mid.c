/*
** EPITECH PROJECT, 2025
** update_mid.c
** File description:
** Update mid status for the linked list
*/

#include "linked.h"
#include "error.h"
#include <stdbool.h>

int linked_upd_mid(linked_list_t *head)
{
    if (!head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (!(*head->mid) || *(head->size) <= 1 || *(head->size) % 2 != 1)
        return OK;
    if ((*(head->size) + 1) / 2 == *(head->mid_index))
        return OK;
    if (*(head->size) / 2 < *(head->mid_index)) {
        *(head->mid) = (*(head->mid))->previous;
        *(head->acendant) = true;
        (*(head->mid_index))--;
    } else {
        *(head->mid) = (*(head->mid))->next;
        *(head->acendant) = false;
        (*(head->mid_index))++;
    }
    return OK;
}
