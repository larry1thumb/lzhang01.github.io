public class Parser {
    String file;
    String[] headers;
    String[] names;
    float[] fg;
    float[] ortg;
    float[] pm;

    Parser(String f) {
        file = f;
        String[] lines = loadStrings(file);
        headers = split(lines[0], ",");
        names = new String[lines.length - 1];
        fg = new float[lines.length - 1];
        ortg = new float[lines.length - 1];
        pm = new float[lines.length - 1];
        
        for (int i = 1; i < lines.length; i++) {
            String[] data = split(lines[i], ",");
            names[i - 1] = data[0];
            fg[i - 1] = float(data[1]);
            ortg[i - 1] = float(data[2]);
            pm[i - 1] = float(data[3]);
        }
    }
}