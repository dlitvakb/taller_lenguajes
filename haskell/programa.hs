data Term = T | F | If Term Term Term deriving Show

instance Show Term where
         show T = "true"
         show If t1 t2 t3 = "(if " ++ show t1
                            ++ " then " ++ show t2
                            ++ " else " ++ show t3 ++ ")"

eval1 (If T t1 _) = Just t1
eval1 (If F _ t2) = Just t2
eval1 (If t1 t2 t3) = Just If t1' t2 t3
      where Just t1' = eval1 t1

eval1 _ = Nothing

eval t = case eval1 t of
     Just t' -> do putStrLn (show t); eval t'
     Nothing -> return t
