CC=gcc
CFLAGS=-Wall -Wno-unused-function

all: lexic_analyzer syntax-calc

lexic_analyzer: lex_analyzer.l
        flex -o lex_analyzer.c lex_analyzer.l
        $(CC) $(CFLAGS) -o lexic_analyzer lex_analyzer.c

syntax-calc: syntax-calc.l
        flex -o syntax-calc.c syntax-calc.l
        $(CC) $(CFLAGS) -o syntax-calc syntax-calc.c

clean:
        rm -f lexic_analyzer syntax-calc *.c parse_tree.dot tokens.out
