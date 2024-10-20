### Luisa Fernanda Castaños Arias

# Analizador Léxico de AC

## Descripción General
Este proyecto implementa un analizador léxico para el lenguaje AC (Adding Calculator) utilizando Lex/Flex. El analizador tokeniza el código fuente de AC, identificando elementos como palabras clave, identificadores, números y operadores.

## Características
- Reconoce las siguientes construcciones del lenguaje AC:
  - Comentarios
  - Declaraciones de flotantes y enteros
  - Identificadores
  - Operadores de asignación y aritméticos
  - Números enteros y flotantes
  - Declaraciones de impresión
- Preserva la estructura de líneas del archivo de entrada en la salida

## Requisitos
- Entorno Linux
- Lex/Flex
- Compilador GCC

## Instalación
1. Clone este repositorio o descargue los archivos fuente.
2. Asegúrese de tener Lex/Flex y GCC instalados en su sistema.

## Compilación
Para compilar el analizador léxico, siga estos pasos:

1. Genere el código C a partir del archivo Lex:
   ```
   lex lex_analyzer.l
   ```

2. Compile el código C generado:
   ```
   gcc lex.yy.c -o lex_analyzer
   ```

## Uso
Para utilizar el analizador léxico:

1. Cree un archivo fuente de AC (por ejemplo, `ejemplo.ac`) con su código AC.
2. Ejecute el analizador en su archivo:
   ```
   ./lex_analyzer ejemplo.ac
   ```

## Ejemplo
Archivo de entrada (`ejemplo.ac`):
```
// Esto es un comentario
f b
i a
a = 5
b = a + 3.2
p b
```

Salida:
```
COMMENT
floatdcl id 
intdcl id 
id assign inum 
id assign id plus fnum 
print id 
```
