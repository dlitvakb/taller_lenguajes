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

* _nv_ ::= **0** | **succ** _nv_
* _v_ ::= **true** | **false** | _nv_
* _t_ ::= _v_ | **if** _t_ **then** _t_ **else** _t_ | **0** | **succ** _t_ | **pred** _t_ | **isZero** _t_
* _T_ ::= **Nat** | **Bool**

* **true** : **Bool**
* **false** : **Bool**
* **0** : **Nat**

```
**t** : **Nat**
--------------------
**succ t** : **Nat**
```

```
**t** : **Nat**
--------------------
**prev t** : **Nat**
```

```
**t** : **Nat**
----------------------
**isZero t** : **Bool**
```

```
**t1** : **Bool**, **t2** : **T**, **t3** : **T**
-------------------------------------------------
if **t1** then **t2** else **t3** : **T**
```

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

* E-ISZEROZERO
`isZero 0 --> true`

* E-ISZERONV
`isZero (succ **nv**) --> false`

* E-ISZERO
```
**t** --> **t'**
--------------------------------
isZero(**t**) --> isZero(**t'**)
```

* E-PREDZERO
`pred(0) --> 0`

* E-PREDNV
`pred(succ **nv**) --> **nv**`

* E-PRED
```
**t** --> **t'**
----------------------------
pred(**t**) --> pred(**t'**)
```

* E-SUCC
```
**t** --> **t'**
----------------------------
succ(**t**) --> succ(**t'**)
```

* E-SUM0RIGHT
`suma nv 0 --> nv`

* E-SUMSUCC
`suma nv1 (succ nv2) --> succ(suma nv1 nv2)`

* E-SUMLEFT
```
**t1** --> **t1'**
------------------------------------------
suma **t1** **t2** --> suma **t1'** **t2**
```

* E-SUMRIGHT
```
**t2** --> **t2'**
----------------------------------
suma nv **t2** --> suma nv **t2'**
```


Ejemplo:
```
1.              if (if false then false else false) then false else (if true then true else true)
                -> if false then false else false -> false
2. E-IF ->      if false then false else (if true then true else true)
3. E-IFFALSE -> if true then true else true
4. E-IFTRUE ->  true
```
