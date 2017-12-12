public class LineChart {
    float x1, x2, y1, y2;
    float xlength; //length of x-axis
    float ylength; //length of y-axis
    String names[];
    float values[];
    float x_interval; //distance between two bars
    float y_interval; //distance between each tick
    float y_scale; //
    float tick_length;
    float min_value;
    float max_value;
    int num_elements;
    String xlabel;
    float bar_width;
    color axes = color(0, 0, 0);
    int shottype = 0;

    LineChart (float w, float h, String x[], float y[], String label) {
        x1 = 0.1 * w;
        x2 = 0.95 * w;
        y1 = 0.1 * h;
        y2 = 0.8 * h;
        xlength = w * 0.85;
        ylength = h * 0.7;
        names = x;
        values = y;

        min_value = 20;
        max_value = max(y) + (10 - max(y) % 10);

        num_elements = x.length;
        x_interval = xlength/num_elements;
        y_interval = ylength/10;
        y_scale = (max_value-min_value)/10;
        tick_length = xlength * .01;

        xlabel = label;
        bar_width = x_interval/2.0;
    }


    public void render() {
        stroke(axes);
        line(x1, y1, x1, y2);
        line(x1, y2, x2, y2);
        textSize(24);
        textAlign(CENTER);
        text("Three Point Percentage Time Series", (x1+x2)/2, 0.1*height);
        textSize(12);
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
        text(xlabel, (-y1-y2)/2, x1/4);
        popStyle();
        for (int i = 1; i <= num_elements; i = i+1) {
            text(names[i-1], -1*y2 - tick_length, x1 + i*x_interval - x_interval/4);
        }
        rotate(PI/2);
        rectMode(CENTER);
        for (int i = 1; i <= num_elements; i = i+1) {
            float val = ylength * (values[i-1]-min_value)/(max_value-min_value);
            pushStyle();
            fill(#000000);
            //rect(x1 + i*x_interval - x_interval/2, y2 - val/2, bar_width, val);
            ellipse(x1 + i*x_interval - x_interval/2, y2 - val, 5, 5);

            if (i < num_elements) {
                float val2 = ylength * (values[i]-min_value)/(max_value-min_value);
                line(x1 + i*x_interval - x_interval/2, y2 - val, x1 + (i+1)*x_interval - x_interval/2, y2 - val2);
            }
            popStyle();
        }
    }

    void highlight() {
        for (int i = 1; i <= num_elements; i++) {
            float val1 = ylength * (values[i-1]-min_value)/(max_value-min_value);
            float xx1 = x1 + i*x_interval - x_interval/2 - 2.5;
            float xx2 = x1 + i*x_interval - x_interval/2 + 2.5;
            float yy1 = y2 - val1 - 2.5;
            float yy2 = y2 - val1 + 2.5;

            if (mouseX < xx2 && mouseX > xx1 && mouseY < yy2 && mouseY > yy1) {
                float desc_fl = (values[i-1]);
                String desc = Float.toString(desc_fl);
                desc += " 3P%";
                fill(#87cefa);
                ellipse(x1 + i*x_interval - x_interval/2, y2 - val1, 5, 5);                
                fill(#000000);
                textAlign(RIGHT);
                text(desc, mouseX - tick_length, mouseY);
            }
        }
        return;
    }

    void shorten_tooltip() {
        float px1 = x1 + 17*x_interval - x_interval/2 - 25;
        float px2 = x1 + 17*x_interval - x_interval/2 + 25;
        float py1 = y2 - (ylength * (values[16]-min_value)/(max_value-min_value)) - 50;
        float py2 = py1 + 100;

        if (mouseX < px2 && mouseX > px1 && mouseY < py2 && mouseY > py1) {
            textAlign(LEFT);
            text("The NBA shortened the 3 point arc between", x1 + 17*x_interval - x_interval/2, 2*height/4);
            text("the 1994-95 and 1997-98 seasons", x1 + 17*x_interval - x_interval/2, 15 + 2*height/4);
            noFill();
            ellipse(x1 + 17*x_interval - x_interval/2, y2 - (ylength * (values[16]-min_value)/(max_value-min_value)), 75, 75);
        }
    }
}