#ifndef random_h
#define random_h

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define HASHTABLE_SIZE 100

typedef struct pageEntry {
    uint64_t pageAddress;
    struct pageEntry *next;
} pageEntry;

typedef struct cacheHashTable {
    int size;
    int capacity;
    pageEntry **entries;
} cacheHashTable;

#endif
