/*
** EPITECH PROJECT, 2025
** hash.c
** File description:
** hash function
*/

#include "my_string.h"
#include "macro.h"
#include "my_math.h"
#include "hashtable.h"
#include "error.h"
#include <limits.h>
#include <float.h>

static int get_nbr_from_str(char *key, int const r)
{
    long double count = 0;
    int len = 0;
    int n = 0;

    if (!key)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    len = my_strlen(key);
    if (len < 0)
        return err_prog(UNDEF_ERR, KO, ERR_INFO);
    count = my_log(len << (r - len * 8), 1.000000000001);
    while (count > 256)
        count /= 1.460354;
    for (unsigned int j = 0; j < count; j++) {
        for (int i = 0; key[i]; i++)
            n += ((i + j) * key[i] * (key[i] % 2 + 1))
            << (((i + j) * key[i]) % r);
    }
    return n;
}

int hash(char *key, int len)
{
    int hashed_key = 0;
    int r = (sizeof(int) - sizeof(char)) * 8;

    if (!key)
        return err_prog(PTR_ERR, KO, ERR_INFO);
    if (len < 1)
        return err_prog(ARGV_ERR, KO, ERR_INFO);
    hashed_key = get_nbr_from_str(key, r);
    ABS(hashed_key);
    hashed_key >>= (int) (r * ((float) hashed_key / (float) INT_MAX));
    return hashed_key;
}
