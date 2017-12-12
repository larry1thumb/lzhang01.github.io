public class Parser {
  String file;
  String[] headers;
  String[] names;
  float[] ppg;
  float[] rpg;
  float[] apg;
  float[] fg;
  float[] tp;
  float[] per;
  float[] pie;
  
  Parser(String f) {
    file = f;
    String[] lines = loadStrings(file);
    headers = split(lines[0], ",");
    names = new String[lines.length - 1];
    ppg = new float[lines.length - 1];
    rpg = new float[lines.length - 1];
    apg = new float[lines.length - 1];
    fg = new float[lines.length - 1];
    tp = new float[lines.length - 1];
    per = new float[lines.length - 1];
    pie = new float[lines.length - 1];
    
    for(int i = 1; i < lines.length; i++) {
      String[] data = split(lines[i], ",");
      names[i - 1] = data[0];
      ppg[i - 1] = float(data[1]);
      rpg[i - 1] = float(data[2]);
      apg[i - 1] = float(data[3]);
      fg[i - 1] = float(data[4]);
      tp[i - 1] = float(data[5]);
      per[i - 1] = float(data[6]);
      pie[i - 1] = float(data[7]);
    }
  } 
}