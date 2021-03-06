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

void chaining(uint64_t hashIndex, pageEntry *entry) {
   /* Add to the beginning of the list*/
   pageEntry *current = hashTable->entries[hashIndex];
   entry->next = current;
   hashTable->entries[hashIndex] = entry;  
}

void addEntry(uint64_t hashIndex, pageEntry *entry) {
    /* If there is an entry at the hash index, use separate chaining */
    if (hashTable->entries[hashIndex]) {
        chaining(hashIndex, entry);
    }
    // insert
    else {
        (hashTable->entries)[hashIndex] = entry;
    }
}

uint64_t evictEntry() {
   pageEntry* cur;
   pageEntry* prev = NULL;
   uint64_t returnAddress;

   srand(time(NULL));
   int randomIndex = rand() % hashTable->capacity;
   while ((hashTable->entries)[randomIndex] == NULL) {
      randomIndex = rand() % hashTable->capacity;
   }
   printf("This is r: %d\n", randomIndex);

   cur = hashTable->entries[randomIndex];
   while (cur->next != NULL) {
      prev = cur;
      cur = cur->next;
   }
   returnAddress = cur->pageAddress;
   if (prev != NULL) {
      prev->next = NULL;
   }
   else {
      (hashTable->entries)[randomIndex] = NULL;
   }
   free(cur);
   
   return returnAddress;
}

int main() {
    createHashTable();
    
    uint64_t pageAddress = 0x1003abcd;
    uint64_t hashIndex = hash(pageAddress);
    
    pageEntry *entry = malloc(sizeof(pageEntry));
    entry->pageAddress = pageAddress;
    entry->next = NULL;
    
    pageEntry *copy = malloc(sizeof(pageEntry));
    copy->pageAddress = pageAddress;
    copy->next = NULL;

    printf("HashIndex: %llu\n", hashIndex);
    addEntry(hashIndex, entry);
    addEntry(hashIndex, copy);

    
    printTable();

    printf("This is the returnAddress: %llu\n", evictEntry());

    printTable();
    
    return 0;
}
