/*
** EPITECH PROJECT, 2025
** linked_dump.c
** File description:
** Display the content of the linked list
*/

#include "write.h"
#include "my_math.h"
#include "linked.h"
#include "error.h"

int linked_dump(int (*display_data)(void *data), linked_list_t *head)
{
    int res = OK;

    if (!display_data || !head)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    res += my_printf("\nHead: |%p|\nMid: |%p|\nTail: |%p|\n",
    *(head->head), *(head->mid), *(head->tail));
    res += my_printf("Mid Index: |%d|\nAcendant: |%B|\n",
    *(head->mid_index), *(head->acendant));
    res += my_printf("Size: |%d|\n//---------------------//\n", *(head->size));
    for (int i = 0; head; i++) {
        if (res != OK)
            return err_prog(UNDEF_ERR, KO, ERR_INFO);
        res += my_printf("Ptr: |%p|\n", head);
        res += my_printf("I: |%.*d|\n", (int) my_log(*(head->size), 10), i);
        res += my_printf("Data:\n-------------------------\n");
        res += display_data(head->data);
        res += my_printf("-------------------------\n");
        head = head->next;
    }
    return OK;
}
