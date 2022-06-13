class ConvertLettersToSpeakable {
  final List<String> letters;

  ConvertLettersToSpeakable({required this.letters});

   List<String> convertSoundBased() {
    for (int i=0; i<letters.length; i++){
      switch (letters[i]) {
        case 'A':
          letters[i] = "a";
          break;
        case 'B':
          letters[i] =  "bee";
          break;
        case 'C':
          letters[i] =  "cee";
          break;
        case 'D':
          letters[i] =  "dee";
          break;
        case 'E':
          letters[i] =  "e";
          break;
        case 'F':
          letters[i] =  "f";
          break;
        case 'G':
          letters[i] =  "gee";
          break;
        case 'H':
          letters[i] =  "aitch";
          break;
        case 'I':
          letters[i] =  "i";
          break;
        case 'J':
          letters[i] =  "jay";
          break;
        case 'K':
          letters[i] =  "kay";
          break;
        case 'L':
          letters[i] =  "el";
          break;
        case 'M':
          letters[i] =  "em";
          break;
        case 'N':
          letters[i] =  "en";
          break;
        case 'O':
          letters[i] =  "o";
          break;
        case 'P':
          letters[i] =  "pee";
          break;
        case 'Q':
          letters[i] =  "cue";
          break;
        case 'R':
          letters[i] =  "are";
          break;
        case 'S':
          letters[i] =  "ess";
          break;
        case 'T':
          letters[i] =  "tee";
          break;
        case 'U':
          letters[i] =  "u";
          break;
        case 'V':
          letters[i] =  "vee";
          break;
        case 'W':
          letters[i] =  "doubliu";
          break;
        case 'X':
          letters[i] =  "ex";
          break;
        case 'Y':
          letters[i] =  "wy";
          break;
        case 'Z':
          letters[i] =  "zed";
          break;
        case 'a':
          letters[i] = "a";
          break;
        case 'b':
          letters[i] =  "bee";
          break;
        case 'c':
          letters[i] =  "cee";
          break;
        case 'd':
          letters[i] =  "dee";
          break;
        case 'e':
          letters[i] =  "e";
          break;
        case 'f':
          letters[i] =  "ef";
          break;
        case 'g':
          letters[i] =  "gee";
          break;
        case 'h':
          letters[i] =  "aitch";
          break;
        case 'i':
          letters[i] =  "i";
          break;
        case 'j':
          letters[i] =  "jay";
          break;
        case 'k':
          letters[i] =  "kay";
          break;
        case 'l':
          letters[i] =  "el";
          break;
        case 'm':
          letters[i] =  "em";
          break;
        case 'n':
          letters[i] =  "en";
          break;
        case 'o':
          letters[i] =  "o";
          break;
        case 'p':
          letters[i] =  "pee";
          break;
        case 'q':
          letters[i] =  "cue";
          break;
        case 'r':
          letters[i] =  "are";
          break;
        case 's':
          letters[i] =  "ess";
          break;
        case 't':
          letters[i] =  "tee";
          break;
        case 'u':
          letters[i] =  "u";
          break;
        case 'v':
          letters[i] =  "vee";
          break;
        case 'w':
          letters[i] =  "doubliu";
          break;
        case 'x':
          letters[i] =  "ex";
          break;
        case 'y':
          letters[i] =  "wy";
          break;
        case 'z':
          letters[i] =  "zed";
      }

    }
    return letters;

  }
}

class ConvertSimpleLettersToSpeakable {
  final List<String> letters;

  ConvertSimpleLettersToSpeakable({required this.letters});

   List<String> convertSoundBased() {
    for (int i=0; i<letters.length; i++){
      switch (letters[i]) {
        case 'a':
          letters[i] = "ae";
          break;
        case 'b':
          letters[i] =  "ba";
          break;
        case 'c':
          letters[i] =  "ka";
          break;
        case 'd':
          letters[i] =  "da";
          break;
        case 'e':
          letters[i] =  "a";
          break;
        case 'f':
          letters[i] =  "far";
          break;
        case 'g':
          letters[i] =  "ger";
          break;
        case 'h':
          letters[i] =  "her";
          break;
        case 'i':
          letters[i] =  "e";
          break;
        case 'j':
          letters[i] =  "jar";
          break;
        case 'k':
          letters[i] =  "kar";
          break;
        case 'l':
          letters[i] =  "ler";
          break;
        case 'm':
          letters[i] =  "mar";
          break;
        case 'n':
          letters[i] =  "nar";
          break;
        case 'o':
          letters[i] =  "o";
          break;
        case 'p':
          letters[i] =  "per";
          break;
        case 'q':
          letters[i] =  "qua";
          break;
        case 'r':
          letters[i] =  "ra";
          break;
        case 's':
          letters[i] =  "sa";
          break;
        case 't':
          letters[i] =  "ta";
          break;
        case 'u':
          letters[i] =  "u";
          break;
        case 'v':
          letters[i] =  "var";
          break;
        case 'w':
          letters[i] =  "var";
          break;
        case 'x':
          letters[i] =  "ex";
          break;
        case 'y':
          letters[i] =  "yar";
          break;
        case 'z':
          letters[i] =  "zar";
      }

    }
    return letters;

  }
}