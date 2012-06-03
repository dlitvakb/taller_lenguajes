import Control.Monad

data Term = T | F | If Term Term Term 
          | Z | Succ Term | Prev Term | IsZero Term

eval1 (If T t1 _) = Just t1
eval1 (If F _ t2) = Just t2
eval1 (If t1 t2 t3) = Just (If t1' t2 t3)
        where Just t1' = eval1 t1

eval1 _ = Nothing

eval t = case eval1 t of
        Just t' -> do 
                eval t'
        Nothing -> return t

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
