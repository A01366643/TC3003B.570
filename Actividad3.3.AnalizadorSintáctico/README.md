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

## Requisitos

- Linux
- GCC Compiler
- Flex (analizador léxico)
- GraphViz (para visualización)

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

4. Visualizar el árbol de derivación:
   - Abrir el archivo `parse_tree.dot` generado
   - Visualizar en: https://dreampuf.github.io/GraphvizOnline

## Formato de Salida

### Tokens (tokens.out)
```
COMMENT
floatdcl id
intdcl id
id assign inum
id assign id plus fnum
print id
```

### Árbol de Derivación (parse_tree.dot)
El archivo generado contiene la representación del árbol en formato DOT de GraphViz.

## Manejo de Errores

El analizador detecta y reporta:
- Tokens inválidos
- Errores de sintaxis
- Secuencias de tokens inválidas

## Ejemplos Adicionales

### Ejemplo 1: Operaciones Aritméticas
```
// Arithmetic operations
i x
f y
x = 10
y = 3.14
x = x * y + 5
p x
```

### Ejemplo 2: Múltiples Variables
```
// Multiple variables
f pi
f radius
pi = 3.14159
radius = 5.0
radius = radius * radius * pi
p radius
```

## Limitaciones

- No soporta expresiones entre paréntesis
- No realiza verificación de tipos
- No maneja múltiples operaciones en una misma línea sin asignación
- Los identificadores deben ser una sola letra

## Solución de Problemas

1. Si hay errores de compilación:
   - Verificar la instalación de flex y gcc
   - Ejecutar `make clean` antes de `make`

2. Si hay errores en tiempo de ejecución:
   - Verificar el formato del archivo de entrada
   - Asegurarse de que los identificadores sean válidos
   - Revisar la sintaxis de las operaciones

## Referencias

- [Documentación de Flex](https://westes.github.io/flex/manual/)
- [Documentación de GraphViz](https://graphviz.org/documentation/)
