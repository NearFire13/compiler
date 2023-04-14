#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.h"

Symbol_Table *initialise()
{
    Symbol_Table *symbol_table = malloc(sizeof(*symbol_table));
    symbol_table->first = NULL;
}

void push_symbol(Symbol_Table *symbol_table, char * id, char * address, int profondeur, char * type)
{
    Symbol *new_symbol = malloc(sizeof(*new_symbol));
    if (symbol_table == NULL || new_symbol == NULL)
    {
        exit(EXIT_FAILURE);
    }

    new_symbol->id = id;
    new_symbol->address = address;
    new_symbol->profondeur = profondeur;
    new_symbol->type = type;
    new_symbol->next = symbol_table->first;
    symbol_table->first = new_symbol;
}

char * pull_symbol(Symbol_Table *symbol_table)
{
    if (symbol_table == NULL)
    {
        exit(EXIT_FAILURE);
    }

    char * idPulled;
    Symbol *symbol_to_pull = symbol_table->first;

    if (symbol_table != NULL && symbol_table->first != NULL)
    {
        idPulled = symbol_to_pull->id;
        symbol_table->first = symbol_to_pull->next;
        free(symbol_to_pull);
    }

    return idPulled;
}

void show_symbol_table(Symbol_Table *symbol_table)
{
    if (symbol_table == NULL)
    {
        exit(EXIT_FAILURE);
    }
    Symbol *actuel = symbol_table->first;

    while (actuel != NULL)
    {
        printf("%s\n", actuel->id);
        actuel = actuel->next;
    }

    printf("\n");
}