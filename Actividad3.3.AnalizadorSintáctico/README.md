Luisa Fernanda Castaños Arias | A01366643

# Analizador Sintáctico para Calculadora Simple

Este proyecto implementa un analizador léxico y sintáctico para una calculadora simple que maneja números enteros, flotantes y operaciones básicas.

## Estructura del Proyecto

```
.
├── lex_analyzer.l     # Analizador léxico
├── syntax-calc.l      # Analizador sintáctico
└── Makefile          # Archivo de compilación
```

## Gramática

La gramática que soporta el analizador es la siguiente:

```
Program → Statement*
Statement → Declaration | Assignment | PrintStmt
Declaration → Type id
Type → floatdcl | intdcl 
Assignment → id assign Expression
PrintStmt → print id
Expression → Term ((plus | minus) Term)*
Term → Factor ((mult | div) Factor)*
Factor → id | inum | fnum
```

## Tokens Soportados

- **Tipos de datos**: `floatdcl` (f), `intdcl` (i)
- **Identificadores**: `id` (letras a-z excepto f, i, p)
- **Operadores**: 
  - `assign` (=)
  - `plus` (+)
  - `minus` (-)
  - `mult` (*)
  - `div` (/)
- **Números**: 
  - `inum` (enteros)
  - `fnum` (flotantes)
- **Comentarios**: `COMMENT` (// ...)
- **Impresión**: `print` (p)

## Compilación

```bash
make clean
make
```

## Uso

1. Crear un archivo de entrada (ejemplo.ac) con el código:
```
// basic code
f b
i a
a = 5
b = a + 3.2
p b
```

2. Ejecutar el analizador léxico:
```bash
./lexic_analyzer ejemplo.ac > tokens.out
```

3. Ejecutar el analizador sintáctico:
```bash
./syntax-calc tokens.out
```

4. Ver el contenido del árbol de derivación:
```bash
cat parse_tree.dot
```

El archivo generado tendrá una estructura similar a:
```dot
digraph ParseTree {
  node [shape=box];
  rankdir=TB;
  node0 [label="Program"];
  node1 [label="Statement"];
  node0 -> node1;
  ...
}
```

5. Visualizar el árbol de derivación:
   - Abrir el archivo `parse_tree.dot` generado
   - Visualizar en: https://dreampuf.github.io/GraphvizOnline

6. Visualizar el resultado del analizador léxico:
```bash
cat tokens.out
```

La salida mostrará los tokens identificados:
```
COMMENT
floatdcl id
intdcl id
id assign inum
id assign id plus fnum
print id
```
