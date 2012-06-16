import Control.Monad
import Maybe

-- Valores

data Term = T | F | If Term Term Term
          | Z | Succ Term | Prev Term | IsZero Term
          | Suma Term Term


-- Reglas

Eval1 (If T t1 _) = Just t1
Eval1 (If F _ t2) = Just t2
Eval1 (If t1 t2 t3) = Just (If t1' t2 t3)
        where Just t1' = Eval1 t1

Eval1 (IsZero Z) = Just T
Eval1 (IsZero (Succ nv)) | IsValue nv = Just F
Eval1 (IsZero t) | isJust (Eval t) = Just (IsZero t') where Just t' = Eval t

Eval1 (Prev Z) = Just Z
Eval1 (Prev (Succ t)) = Just t
Eval1 (Succ t) | isJust (Eval t) = Just (Succ t') where Just t' = Eval t
Eval1 (Prev t) | isJust (Eval t) = Just (Prev t') where Just t' = Eval t

Eval1 _ = Nothing

Eval t = case Eval1 t of
        Just t' -> do
                Eval t'
        Nothing -> return t


-- Tipado

data Type = Bool | Nat deriving (Eq)

typeof :: Term -> Maybe Type
typeof T = Just Bool
typeof F = Just Bool
typeof Z = Just Nat

typeof (If c t f) = do
  Bool <- typeof c
  ty1  <- typeof t
  ty2  <- typeof f
  guard $ ty1 == ty2
  return ty2

typeof (Succ v) = typeof' (typeof v) where
    typeof' (Just Nat) = Just Nat
    typeof' _          = Nothing

typeof (Prev v) = typeof' (typeof v) where
    typeof' (Just Nat) = Just Nat
    typeof' _          = Nothing

typeof (IsZero v) = typeof' (typeof v) where
    typeof' (Just Nat) = Just Bool
    typeof' _          = Nothing


-- Auxiliares

IsValue Z = T
IsValue (Prev _) = F
IsValue (Succ t) = IsValue t
