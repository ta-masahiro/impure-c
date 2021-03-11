#include <ctype.h>
#include "symbol.h"

Symbol * new_symbol(unsigned char * str, unsigned long size) {
    char * s = (char * )malloc((size + 1) * sizeof(char)); 
    // strcpy(s, str); // printf("%s\n", s);
    memcpy(s,str,size);
    // if (strcmp(s, "LDC") == 0) printf("!LDC!\n");  
    Symbol * sym = (Symbol * )malloc(sizeof(Symbol));
    sym -> _size = size; 
    sym -> _table = s;  
    return sym;  
}

int symbol_eq(Symbol*s1,Symbol*s2) {return (s1->_size) != (s2->_size) ? FALSE : strcmp(s1->_table,s2->_table)==0;}
Symbol* symbol_cat(Symbol*s1,Symbol*s2) {
        int s3_size=s1->_size+s2->_size;
        char*s=(char*)malloc(s3_size*sizeof(char));
        memcpy(s,s1,s1->_size-1);memcpy(s+s1->_size-1,s2,s2->_size);
        Symbol*sym=(Symbol*)malloc(sizeof(Symbol));
        sym->_size=s3_size;
        sym->_table=s;
        return sym;
}

Symbol*symbol_cpy(Symbol*s) {
    char *st=(char*)malloc(s->_size*sizeof(char));
    memcpy(st,s->_table,s->_size);
    Symbol*sym=(Symbol*)malloc(sizeof(Symbol));
    sym->_size=s->_size;sym->_table=st;
    return sym;
}
