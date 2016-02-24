IMPORT STD;
CharCount(STRING Str) := FUNCTION
  Chars := TRIM(Str,ALL);
  Len   := LENGTH(Chars);
  ds    := DATASET(Len,
                   TRANSFORM({STRING1 Char},
                             SELF.Char := STD.Str.ToUpperCase(Chars[COUNTER])));   
  RETURN TABLE(ds,{Char,Cnt := COUNT(GROUP)},Char);
END;

CharCount('HPCC Systems');