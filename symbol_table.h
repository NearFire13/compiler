#ifndef H_SYMBOL_TABLE
#define H_SYMBOL_TABLE

typedef struct Symbol Symbol;

struct Symbol
{
    char * id;
    char * address;
    int profondeur;
    char * type;
    Symbol *next;
};

typedef struct Symbol_Table Symbol_Table;
struct Symbol_Table
{
    Symbol *first;
};

Symbol_Table *initialiser();
void push_symbol(Symbol_Table *symbol_table, char * id, char * address, int profondeur, char * type);
char * pull_symbol(Symbol_Table *symbol_table);
void show_symbol_table(Symbol_Table *symbol_table);

#endif