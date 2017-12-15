public class Parser {
    String file;
    String[] headers;
    String[] names;
    String[] position;
    float[] heights;
    float[] weights;
    float[] creb;

    Parser(String f) {
        file = f;
        String[] lines = loadStrings(file);
        headers = split(lines[0], ",");
        names = new String[lines.length - 1];
        position = new String[lines.length - 1];
        heights = new float[lines.length - 1];
        weights = new float[lines.length - 1];
        creb = new float[lines.length - 1];
        
        for (int i = 1; i < lines.length; i++) {
            String[] data = split(lines[i], ",");
            names[i - 1] = data[0];
            position[i - 1] = data[1];
            heights[i - 1] = float(data[2]);
            weights[i - 1] = float(data[3]);
            creb[i - 1] = float(data[4]);
        }
    }
}