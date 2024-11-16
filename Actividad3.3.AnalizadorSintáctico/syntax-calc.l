%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define YY_NO_INPUT
#define YY_NO_UNPUT

// Declaraciones de funciones
int Program(void);
int Statement(void);
int Declaration(void);
int Assignment(void);
int PrintStmt(void);
int Expression(void);
int Term(void);
int Factor(void);

FILE* dotFile;
int nodeCount = 0;
char token[256];
char nextToken[256];

// Funciones de utilidad
void getNextToken() {
    if (scanf("%s", nextToken) != 1) {
        strcpy(nextToken, "EOF");
    }
}

int createNode(const char* label) {
    int currentNode = nodeCount++;
    fprintf(dotFile, "  node%d [label=\"%s\"];\n", currentNode, label);
    return currentNode;
}

void connect(int parent, int child) {
    if (parent >= 0 && child >= 0) {
        fprintf(dotFile, "  node%d -> node%d;\n", parent, child);
    }
}

void match(const char* expected) {
    if (strcmp(nextToken, expected) == 0) {
        strcpy(token, nextToken);
        getNextToken();
    } else {
        fprintf(stderr, "Error de sintaxis: se esperaba '%s', se encontró '%s'\n", 
                expected, nextToken);
        exit(1);
    }
}

// Factor → id | inum | fnum
int Factor() {
    int factorNode = createNode("Factor");
    
    if (strcmp(nextToken, "id") == 0 ||
        strcmp(nextToken, "inum") == 0 ||
        strcmp(nextToken, "fnum") == 0) {
        int valueNode = createNode(nextToken);
        connect(factorNode, valueNode);
        match(nextToken);
    }
    
    return factorNode;
}

// Term → Factor ((mult | div) Factor)*
int Term() {
    int termNode = createNode("Term");
    int factorNode = Factor();
    connect(termNode, factorNode);
    
    while (strcmp(nextToken, "mult") == 0 || strcmp(nextToken, "div") == 0) {
        int opNode = createNode(strcmp(nextToken, "mult") == 0 ? "mult" : "div");
        connect(termNode, opNode);
        match(nextToken);
        factorNode = Factor();
        connect(termNode, factorNode);
    }
    
    return termNode;
}

// Expression → Term ((plus | minus) Term)*
int Expression() {
    int exprNode = createNode("Expression");
    int termNode = Term();
    connect(exprNode, termNode);
    
    while (strcmp(nextToken, "plus") == 0 || strcmp(nextToken, "minus") == 0) {
        int opNode = createNode(strcmp(nextToken, "plus") == 0 ? "plus" : "minus");
        connect(exprNode, opNode);
        match(nextToken);
        termNode = Term();
        connect(exprNode, termNode);
    }
    
    return exprNode;
}

// Declaration → floatdcl id | intdcl id
int Declaration() {
    int declNode = createNode("Declaration");
    
    if (strcmp(nextToken, "floatdcl") == 0 || strcmp(nextToken, "intdcl") == 0) {
        int typeNode = createNode(nextToken);
        connect(declNode, typeNode);
        match(nextToken);
        
        if (strcmp(nextToken, "id") == 0) {
            int idNode = createNode("id");
            connect(declNode, idNode);
            match("id");
        }
    }
    
    return declNode;
}

// Assignment → id assign Expression
int Assignment() {
    int assignNode = createNode("Assignment");
    
    if (strcmp(nextToken, "id") == 0) {
        int idNode = createNode("id");
        connect(assignNode, idNode);
        match("id");
        
        if (strcmp(nextToken, "assign") == 0) {
            int opNode = createNode("assign");
            connect(assignNode, opNode);
            match("assign");
            
            int exprNode = Expression();
            connect(assignNode, exprNode);
        }
    }
    
    return assignNode;
}

// PrintStmt → print id
int PrintStmt() {
    int printNode = createNode("Print");
    match("print");
    
    if (strcmp(nextToken, "id") == 0) {
        int idNode = createNode("id");
        connect(printNode, idNode);
        match("id");
    }
    
    return printNode;
}

// Statement → Declaration | Assignment | PrintStmt
int Statement() {
    int stmtNode = createNode("Statement");
    
    if (strcmp(nextToken, "COMMENT") == 0) {
        match("COMMENT");
        return stmtNode;
    }
    
    if (strcmp(nextToken, "floatdcl") == 0 || strcmp(nextToken, "intdcl") == 0) {
        int declNode = Declaration();
        connect(stmtNode, declNode);
    }
    else if (strcmp(nextToken, "id") == 0) {
        int assignNode = Assignment();
        connect(stmtNode, assignNode);
    }
    else if (strcmp(nextToken, "print") == 0) {
        int printNode = PrintStmt();
        connect(stmtNode, printNode);
    }
    
    return stmtNode;
}

// Program → Statement*
int Program() {
    int progNode = createNode("Program");
    
    while (strcmp(nextToken, "EOF") != 0) {
        int stmtNode = Statement();
        if (stmtNode >= 0) {
            connect(progNode, stmtNode);
        }
    }
    
    return progNode;
}

%}

%%
. { }
%%

int yywrap() { return 1; }

int main(int argc, char** argv) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s tokens.out\n", argv[0]);
        return 1;
    }
    
    freopen(argv[1], "r", stdin);
    dotFile = fopen("parse_tree.dot", "w");
    fprintf(dotFile, "digraph ParseTree {\n  node [shape=box];\n  rankdir=TB;\n");
    
    getNextToken();
    Program();
    
    fprintf(dotFile, "}\n");
    fclose(dotFile);
    
    return 0;
}
