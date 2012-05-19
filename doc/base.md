# Definicion de un lenguaje

## Sintaxis **Abstracta**

## Semántica operacional 
**Forma de relacionar un programa con su acción de a pequeños pasos**
  * Evaluación

## Semántica denotacional 
**Definir la relacion entre un programa con su acción en grandes pasos**

## Implementar
  * Parser
  * Interprete/Evaluador

## Chequeo de Tipos

## Definición de términos

* _v_ ::= **true** | **false**
* _t_ ::= _v_ | **if** _t_ **then** _t_ **else** _t_

### Reglas de evaluación

* E-IFTRUE
`if true then **t1** else **t2** --> **t1**`

* E-IFFALSE
`if false then **t1** else **t2** --> **t2**`

* E-IF
```
**t1** --> **t1'**
------------------------------------------------------------------------
if **t1** then **t2** else **t3** --> if **t1'** then **t2** else **t3**
```

Ejemplo:
```
1. if (if false then false else false) then false else (if true then true else true)
2. E-IF -> if false then false else (if true then true else true)
3. E-IFFALSE -> if true then true else true
4. E-IFTRUE -> true
```
