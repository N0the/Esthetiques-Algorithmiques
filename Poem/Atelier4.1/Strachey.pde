/**
  Leeder Julien IMAC 1
**/

String[] first = {"Darling", "Dear", "Honey", "Jewel"};
String[] second = {"duck", "love", "moppet", "sweetheart"};

String[] adjectives = {
  "adorable", "affectionate", "amorous", "anxious", "ardent", "avid", 
  "breathless", "burning", "covetous", "craving", "curious", "darling", 
  "dear", "devoted", "eager", "erotic", "fervent", "fond", "impatient", 
  "keen", "little", "loveable", "lovesick", "loving", "passionate", 
  "precious", "sweet", "sympathetic", "tender", "unsatisfied", "wistful"
};

String[] nouns = {
  "adoration", "affection", "ambition", "appetite", "ardour", "charm", 
  "desire", "devotion", "eagerness", "enchantment", "enthusiasm", "fancy", 
  "fellow feeling", "fervour", "fondness", "heart", "hunger", "infatuation", 
  "liking", "longing", "love", "lust", "passion", "rapture", "sympathy", 
  "tenderness", "thirst", "wish", "yearning"
};

String[] adverbs = {
  "affectionately", "anxiously", "ardently", "avidly", "beautifully", 
  "breathlessly", "burningly", "covetously", "curiously", "devotedly", 
  "eagerly", "fervently", "fondly", "impatiently", "keenly", "lovingly", 
  "passionately", "seductively", "tenderly", "winningly", "wistfully"
};

String[] verbs = {
  "adores", "attracts", "cares for", "cherishes", "clings to", "desires", 
  "holds dear", "hopes for", "hungers for", "is wedded to", "likes", 
  "longs for", "loves", "lusts after", "pants for", "pines for", "prizes", 
  "sighs for", "tempts", "thirsts for", "treasures", "wants", "wishes", 
  "woos", "yearns for"
};

String maybe(String[] words){
  if(int(random(2)) == 1){ 
    return " " + words[int(random(words.length))];
  }
  return "";
}

String longer(){
  return " My" 
         + maybe(adjectives) + " "
         + nouns[int(random(nouns.length))] 
         + maybe(adverbs) + " "
         + verbs[int(random(verbs.length))] 
         + " your" 
         + maybe(adjectives) + " "
         + nouns[int(random(nouns.length))] 
         + ".";
}

String shorter(){
  return " " + adjectives[int(random(adjectives.length))] 
         + " " + nouns[int(random(nouns.length))] + ".";
}

String body(){
  String text = "";
  boolean you_are = false;
  
  for(int i = 0; i < 5; i++){
    String type = (int(random(2)) == 0) ? "longer" : "shorter";
    
    if(type.equals("longer")){
      text += longer();
      you_are = false;
    } else {
      if(you_are){
        if(text.length() > 0) text = text.substring(0, text.length() - 1);
        text += ": my" + shorter();
        you_are = false;
      } else {
        text += " You are my" + shorter();
        you_are = true;
      }
    }
  }
  
  return text;
}

String wrapText(String text, int width){
  String[] words = text.split(" ");
  StringBuilder result = new StringBuilder();
  int lineLength = 0;
  
  for(String word : words){
    if(lineLength + word.length() > width){
      result.append("\n");
      lineLength = 0;
    }
    result.append(word).append(" ");
    lineLength += word.length() + 1;
  }
  
  return result.toString().trim();
}

String letter(){
  String text = first[int(random(first.length))] + " " + second[int(random(second.length))] + "\n\n"
              + wrapText(body(), 80) + "\n\n"
              + "                            Yours " + adverbs[int(random(adverbs.length))] + "\n\n"
              + "                                  M.U.C.\n";
  
  return text;
}

void setup(){
  background(255);
  frameRate(1);
}

void draw(){
  println(letter());
  delay(12000);
}
