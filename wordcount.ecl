IMPORT Std;

LineLayout := RECORD
   STRING line;
END;

linesDS := DATASET
   (
      '~thor::word_list_csv',
      LineLayout, 
      CSV(heading(1),separator(''),quote(''))
   );

WordLayout := RECORD
   STRING word;
END;

LineWordsLayout := RECORD
   DATASET(WordLayout)   words;
END;

wordsTemp := PROJECT
   (
      linesDS,
      TRANSFORM
         (
            LineWordsLayout,
            SELF.words := DATASET(Std.Str.SplitWords(LEFT.line, ','), WordLayout)
         )
   );

wordsDS := wordsTemp.words;

WordCountLayout := RECORD
   wordsDS.word;
   wordCount := COUNT(GROUP);
END;

wordCountTable := TABLE(wordsDS, WordCountLayout, word);

OUTPUT(wordCountTable);