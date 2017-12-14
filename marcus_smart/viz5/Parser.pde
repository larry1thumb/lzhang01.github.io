public class Parser {
    String file;
    String[] headers;
    String[] names;
    float[] ortg;
    float[] opportg;
    float[] fg;
    float[] fgm;
    float[] fga;
    float[] tpm;
    float[] tpa;
    float[] tp;
    float[] pm;
    float[] top5pm;
    float[] top5fg;

    Parser(String f) {
        file = f;
        String[] lines = loadStrings(file);
        headers = split(lines[0], ",");
        names = new String[lines.length - 1];
        ortg = new float[lines.length - 1];
        opportg = new float[lines.length - 1];
        fg = new float[lines.length - 1];
        fgm = new float[lines.length - 1];
        fga = new float[lines.length - 1];
        tpm = new float[lines.length - 1];
        tpa = new float[lines.length - 1];
        tp = new float[lines.length - 1];
        pm = new float[lines.length - 1];
        top5pm = new float[lines.length - 1];
        top5fg = new float[lines.length - 1];
        
        for (int i = 1; i < lines.length; i++) {
            String[] data = split(lines[i], ",");
            names[i - 1] = data[0];
            ortg[i - 1] = float(data[1]);
            opportg[i - 1] = float(data[2]);
            fg[i - 1] = float(data[3]);
            fgm[i - 1] = float(data[4]);
            fga[i - 1] = float(data[5]);
            tpm[i - 1] = float(data[6]);
            tpa[i - 1] = float(data[7]);
            tp[i - 1] = 100.0 * tpm[i-1]/tpa[i-1];
            pm[i - 1] = float(data[8]);
            top5pm[i - 1] = float(data[9]);
            top5fg[i - 1] = float(data[10]);
            
        }
    }
}