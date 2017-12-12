public class Parser {
    String file;
    String[] headers;
    String[] names;
    
    float[] steph;
    float[] klay;
    float[] damian;
    float[] james;
    float[] kyle;
    float[] jj;
    float[] kevin;
    float[] paul;
    float[] jr;
    float[] cj;
    String[] months;
    
    float[] tpm;
    float[] tpa;
    float[] cashm;
    float[] pum;
    String[] totalpercent;
    float[] atpp;
    float[] btpp;
    float[] ctpp;
    float[] dtpp;
    float[] etpp;
    String[] atpm;
    String[] btpm;
    String[] ctpm;
    String[] dtpm;
    String[] etpm;
    String[] atpa;
    String[] btpa;
    String[] ctpa;
    String[] dtpa;
    String[] etpa;
    
    float[] acash;
    float[] bcash;
    float[] ccash;
    float[] dcash;
    float[] ecash;
    float[] apu;
    float[] bpu;
    float[] cpu;
    float[] dpu;
    float[] epu;
    
    Parser(String f) {
        file = f;
        String[] lines = loadStrings(file);
        headers = split(lines[0], ",");
        names = new String[lines.length - 1];
        steph = new float[7];
        klay = new float[7];
        damian = new float[7];
        james = new float[7];
        kyle = new float[7];
        jj = new float[7];
        kevin = new float[7];
        paul = new float[7];
        jr = new float[7];
        cj = new float[7];
        months = new String[7];
        tpm = new float[lines.length - 1];
        tpa = new float[lines.length - 1];
        cashm = new float[lines.length - 1];
        pum = new float[lines.length - 1];
        totalpercent = new String[lines.length - 1];

        atpp = new float[5];
        btpp = new float[5];
        ctpp = new float[5];
        dtpp = new float[5];
        etpp = new float[5];
        atpm = new String[5];
        btpm = new String[5];
        ctpm = new String[5];
        dtpm = new String[5];
        etpm = new String[5];
        atpa = new String[5];
        btpa = new String[5];
        ctpa = new String[5];
        dtpa = new String[5];
        etpa = new String[5];
        acash = new float[7];
        bcash = new float[7];
        ccash = new float[7];
        dcash = new float[7];
        ecash = new float[7];
        apu = new float[7];
        bpu = new float[7];
        cpu = new float[7];
        dpu = new float[7];
        epu = new float[7];
        
        

        for (int i = 1; i < lines.length; i++) {
            String[] data = split(lines[i], ",");
            names[i - 1] = data[1];
            if (i < 6) {
                atpp[i-1] = float(data[47]);
                btpp[i-1] = float(data[48]);
                ctpp[i-1] = float(data[49]);
                dtpp[i-1] = float(data[50]);
                etpp[i-1] = float(data[51]);
                atpm[i-1] = data[52];
                btpm[i-1] = data[53];
                ctpm[i-1] = data[54];
                dtpm[i-1] = data[55];
                etpm[i-1] = data[56];
                atpa[i-1] = data[57];
                btpa[i-1] = data[58];
                ctpa[i-1] = data[59];
                dtpa[i-1] = data[60];
                etpa[i-1] = data[61];
            }
            if (i < 8) {
                months[i-1] = data[36];
                steph[i-1] = float(data[37]);
                klay[i-1] = float(data[38]);
                damian[i-1] = float(data[39]);
                james[i-1] = float(data[40]);
                kyle[i-1] = float(data[41]);
                jj[i-1] = float(data[42]);
                kevin[i-1] = float(data[43]);
                paul[i-1] = float(data[44]);
                jr[i-1] = float(data[45]);
                cj[i-1] = float(data[46]);
                acash[i-1] = float(data[67]);
                bcash[i-1] = float(data[68]);
                ccash[i-1] = float(data[69]);
                dcash[i-1] = float(data[70]);
                ecash[i-1] = float(data[71]);
                apu[i-1] = float(data[62]);
                bpu[i-1] = float(data[63]);
                cpu[i-1] = float(data[64]);
                dpu[i-1] = float(data[65]);
                epu[i-1] = float(data[66]);
            }
            tpm[i-1] = float(data[7]);
            tpa[i-1] = float(data[8]);
            cashm[i-1] = float(data[11]);
            pum[i-1] = float(data[16]);
            totalpercent[i-1] = data[6];
        }
        printArray(totalpercent);
    }
}