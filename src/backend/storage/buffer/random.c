#include "random.h"

cacheHashTable *hashTable;

uint64_t hash(uint64_t pageAddress) {
    pageAddress = (pageAddress ^ (pageAddress >> 30)) * UINT64_C(0xbf58476d1ce4e5b9);
    pageAddress = (pageAddress ^ (pageAddress >> 27)) * UINT64_C(0x94d049bb133111eb);
    pageAddress = pageAddress ^ (pageAddress >> 31);
    return pageAddress % HASHTABLE_SIZE;
}

void createHashTable() {
    hashTable = calloc(sizeof(cacheHashTable), 1);
    hashTable->entries = calloc(HASHTABLE_SIZE, sizeof(pageEntry *));
    hashTable->size = 0;
    hashTable->capacity = HASHTABLE_SIZE;
}

void printTable() {
    for (int i = 0; i < hashTable->capacity; i++) {
        pageEntry *entries = hashTable->entries[i];
        while (entries != NULL) {
            printf("%llu\n", entries->pageAddress);
            printf("%llx\n", entries->pageAddress);
            entries = entries->next;
        }
    }
}

void rehash() {
    
}

int main() {
    createHashTable();
    
    uint64_t pageAddress = 0x1003abcd;
    uint64_t hashIndex = hash(pageAddress);
    
    // rehash
    if (hashTable->entries[hashIndex]) {
        rehash();
    }
    // insert
    else {
        pageEntry *entry = malloc(sizeof(pageEntry));
        entry->pageAddress = pageAddress;
        entry->next = NULL;
        (hashTable->entries)[hashIndex] = entry;
    }
    
    printTable();
    
    return 0;
}
