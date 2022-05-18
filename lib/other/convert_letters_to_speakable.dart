class ConvertLettersToSpeakable {
  final List<String> letters;

  ConvertLettersToSpeakable({required this.letters});

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
          letters[i] =  "fer";
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
          letters[i] =  "jer";
          break;
        case 'k':
          letters[i] =  "ker";
          break;
        case 'l':
          letters[i] =  "ler";
          break;
        case 'm':
          letters[i] =  "mer";
          break;
        case 'n':
          letters[i] =  "ner";
          break;
        case 'o':
          letters[i] =  "o";
          break;
        case 'p':
          letters[i] =  "per";
          break;
        case 'q':
          letters[i] =  "kwa";
          break;
        case 'r':
          letters[i] =  "rer";
          break;
        case 's':
          letters[i] =  "ser";
          break;
        case 't':
          letters[i] =  "ter";
          break;
        case 'u':
          letters[i] =  "u";
          break;
        case 'v':
          letters[i] =  "ver";
          break;
        case 'w':
          letters[i] =  "ver";
          break;
        case 'x':
          letters[i] =  "ex";
          break;
        case 'y':
          letters[i] =  "yr";
          break;
        case 'z':
          letters[i] =  "zar";
          break;
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
          letters[i] =  "ef";
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
          letters[i] =  "ar";
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
      }

    }
    return letters;

  }
}