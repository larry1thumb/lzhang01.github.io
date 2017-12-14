public class Stacked {
    float x1, x2, y1, y2;
    float xlength; //length of x-axis
    float ylength; //length of y-axis
    String names[];
    float values1[];
    float values2[];
    float x_interval; //distance between two bars
    float y_interval; //distance between each tick
    float y_scale;
    float tick_length;
    float min_value;
    float max_value;
    int num_elements;
    String xlabel;
    String ylabel;
    float bar_width;
    color axes;
    color clabel;
    int player = 1;

    Stacked (float w, float h, String x[], float xstack1[], float xstack2[], String xlbl, String ylbl) {
        axes = color(0,0,0);
        clabel = color(0,0,0);
        x1 = 0.1 * w;
        x2 = 0.8 * w;
        y1 = 0.1 * h;
        y2 = 0.8 * h;

        xlength = w * 0.7;
        ylength = h * 0.7;
        names = x;
        values1 = xstack1;
        values2 = xstack2;
        for (int i = 0; i < xstack1.length; i++) {
            values2[i] = values2[i] - values1[i];
        }
        
        min_value = 0;//min(y) - min(y) % 10;
        float max = max(values1) + max(values2);
        max_value = 410;//max + (10 - max % 10);

        num_elements = names.length;
        x_interval = xlength/num_elements;
        y_interval = ylength/10;
        y_scale = (max_value-min_value)/10;
        tick_length = xlength * .01;

        xlabel = xlbl;
        ylabel = ylbl;
        bar_width = x_interval/2.0;
    }
    public void render() {
        stroke(axes);
        line(x1, y1, x1, y2);
        line(x1, y2, x2, y2);
        for (int i = 0; i <= 10; i = i+1) {
            line(x1 - tick_length, y2 - i*y_interval, x1, y2 - i*y_interval);
            int txt = int(min_value + i*y_scale);
            textAlign(RIGHT);
            fill(axes);
            text(txt, x1-2*tick_length, y2 - i*y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        fill(clabel);
        text(ylabel, (-y1-y2)/2, x1/4);
        popStyle();
        for (int i = 1; i <= num_elements; i = i+1) {
            stroke(0,0,0);
            fill(0,0,0);
            text(names[i-1], -1*y2 - tick_length, x1 + i*x_interval - x_interval/2);
            stroke(axes);
            fill(axes);
        }
        rotate(PI/2);
        rectMode(CENTER);

        for (int i = 1; i <= num_elements; i = i+1) {
            float val1 = ylength * values1[i-1]/max_value;
            float val2 = ylength * values2[i-1]/max_value;

            pushStyle();
            stroke(0, 0, 0);
            fill(#205093);
            rect(x1 + i*x_interval - x_interval/2, y2 - val1/2, bar_width, val1);
            fill(#b01d1d);
            rect(x1 + i*x_interval - x_interval/2, y2 - val1 - val2/2, bar_width, val2);
            popStyle();
        }
    }
}