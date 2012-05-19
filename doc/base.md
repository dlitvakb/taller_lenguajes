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

_v_ ::= **true** | **false**
_t_ ::= _v_ | **if** _t_ **then** _t_ **else** _t_

### Reglas de evaluación

if true then _t1_ else _t2_
_______________________
        _t1_

if false then _t1_ else _t2_
_______________________
        _t2_
