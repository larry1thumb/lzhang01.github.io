public class Parser {
  String file;
  String[] headers;
  String[] season;
  float[] tpa;
  float[] pts;
  float[] tpp;
  float[] efg;
  
  Parser(String f) {
    file = f;
    String[] lines = loadStrings(file);
    headers = split(lines[0], ",");
    season = new String[lines.length - 1];
    tpa = new float[lines.length - 1];
    pts = new float[lines.length - 1];
    tpp = new float[lines.length - 1];
    efg = new float[lines.length - 1];

    
    for(int i = 1; i < lines.length; i++) {
      String[] data = split(lines[i], ",");
      season[i - 1] = data[0];
      tpa[i - 1] = float(data[1]);
      pts[i - 1] = float(data[2]);
      tpp[i - 1] = float(data[3]);
      efg[i - 1] = float(data[4]);
    }
  } 
}