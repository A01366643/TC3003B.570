%{
#include <stdio.h>
#include <stdlib.h>
#define YY_NO_UNPUT
#define YY_NO_INPUT
int line_empty = 1;  // Variable para rastrear si la línea está vacía
%}
%%
"//".*      { if (!line_empty) printf("\n"); printf("COMMENT\n"); line_empty = 1; }
"f"         { if (!line_empty) printf("\n"); printf("floatdcl "); line_empty = 0; }
"i"         { if (!line_empty) printf("\n"); printf("intdcl "); line_empty = 0; }
"p"         { if (!line_empty) printf("\n"); printf("print "); line_empty = 0; }
[a-eg-hj-oq-z]       { printf("id "); line_empty = 0; }
"="         { printf("assign "); line_empty = 0; }
"+"         { printf("plus "); line_empty = 0; }
"-"         { printf("minus "); line_empty = 0; }
"*"         { printf("mult "); line_empty = 0; }
"/"         { printf("div "); line_empty = 0; }
[0-9]+      { printf("inum "); line_empty = 0; }
[0-9]+\.[0-9]{1,5} { printf("fnum "); line_empty = 0; }
[ \t]+      { /* Ignorar espacios y tabs */ }
\n          { if (!line_empty) { printf("\n"); line_empty = 1; } }
.           { printf("ERROR: Unexpected character %s\n", yytext); line_empty = 0; }
%%
int yywrap() { return 1; }
int main(int argc, char **argv) {
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
    }
    yylex();
    if (!line_empty) printf("\n");  // Asegurarse de que haya un salto de línea al final
    return 0;
}
