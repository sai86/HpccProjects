IMPORT STD;

WordLayout := RECORD
  STRING word;
END;

wordsDS := DATASET([
            {'hi how are'}, 
            {'i am fine'}, 
            {'how about you'} 
						{' i am good'}
                  ],WordLayout);

WordLayout XF(WordLayout L, INTEGER C, INTEGER Cnt) := TRANSFORM
  WordStart := IF(C=1,1,STD.str.Find(L.word,' ',C-1)+1); 
  WordEnd   := IF(C=Cnt,LENGTH(L.word),STD.str.Find(L.word,' ',C)-1); 
  SELF.word := L.word[WordStart .. WordEnd];
END;                  
EachWord := NORMALIZE(wordsDS,
                      STD.str.WordCount(LEFT.word),
                      XF(LEFT,COUNTER,STD.str.WordCount(LEFT.word)));

WordCountLayout := RECORD
  EachWord.word;
  wordCount := COUNT(GROUP);
END;

wordCountTable := TABLE(EachWord, WordCountLayout, word);

OUTPUT(wordCountTable);