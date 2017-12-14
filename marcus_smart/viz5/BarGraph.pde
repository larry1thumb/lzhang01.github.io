public class BarGraph {
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
    color axes;
    color clabel;
    int player = 1;
    int shottype = 0;
    color barcolor;

    BarGraph (float w, float h, String x[], float y[], String label, color c) {
        axes = color(0,0,0);
        clabel = color(0,0,0);
        x1 = 0.1 * w;
        x2 = 0.8 * w;
        y1 = 0.1 * h;
        y2 = 0.8 * h;
        barcolor = c;
        xlength = w * 0.7;
        ylength = h * 0.7;
        names = x;
        values = y;

        min_value = 0;
        max_value = 100;//max(y) + (10 - max(y) % 10);
        num_elements = x.length;
        x_interval = xlength/num_elements;
        y_interval = ylength/7;
        y_scale = (max_value-min_value)/7;
        tick_length = xlength * .01;

        xlabel = label;
        bar_width = x_interval/2.0;
    }


    public void render() {
        stroke(axes);
        line(x1, y1, x1, y2);
        line(x1, y2, x2, y2);
        for (int i = 0; i <= 7; i = i+1) {
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
        text(xlabel, (-y1-y2)/2, x1/4);
        popStyle();
        for (int i = 1; i <= num_elements; i = i+1) {
            fill(0,0,0);
            stroke(0,0,0);
            text(names[i-1], -1*y2 - tick_length, x1 + i*x_interval - x_interval/2);
        }
        rotate(PI/2);
        rectMode(CENTER);
        for (int i = 1; i <= num_elements; i = i+1) {
            //float val = ylength * values[i-1]/(max_value+min_value);
            float val = ylength * (values[i-1]-min_value)/(max_value-min_value);
            pushStyle();
            stroke(0,0,0);
            fill(barcolor);
            rect(x1 + i*x_interval - x_interval/2, y2 - val/2, bar_width, val);
            popStyle();
        }
        pushStyle();
        stroke(0, 0, 0);
        line(x1, y2, x2, y2);
        popStyle();
    }

    void highlight() {
        for (int i = 1; i <= num_elements; i++) {
            float val1 = ylength * (values[i-1]-min_value)/(max_value-min_value);
            float xx1 = x1 + i*x_interval - x_interval/2 - x_interval/4;
            float xx2 = x1 + i*x_interval - x_interval/4;
            float yy1 = y2 - val1;
            float yy2 = y2;

            if (mouseX < xx2 && mouseX > xx1 && mouseY < yy2 && mouseY > yy1) {
                float desc_fl = (values[i-1]);
                String desc = String.format("%.01f", desc_fl);
                desc += " fg%";

                fill(#99ffcc);
                rect(x1 + i*x_interval - x_interval/2, y2 - val1/2, x_interval/2, val1);
                fill(#000000);
                textAlign(LEFT);
                text(desc, mouseX + tick_length, mouseY);
                player = i-1;
                pushStyle();
                textAlign(CENTER);
                if (player == 0) {
                    text("2011-12 NBA Season", x1*5, y1/2.0);
                } else if (player == 1) {
                    text("2014-15 NBA Season", x1*5, y1/2.0);
                } else if (player == 2) {
                    text("2000-01 NBA Season", x1*5, y1/2.0);
                } else if (player == 3) {
                    text("2001-02 NBA Season", x1*5, y1/2.0);
                } else if (player == 4) {
                    text("2006-07 NBA Season", x1*5, y1/2.0);
                } else if (player == 5) {
                    text("1989-90 NBA Season", x1*5, y1/2.0);
                } else if (player == 6) {
                    text("2008-09 NBA Season", x1*5, y1/2.0);
                } else if (player == 7) {
                    text("2017-2018 NBA Season", x1*5, y1/2.0);
                    text("* Worst FG% in NBA history", x1*5, 20+y1/2.0);
                }

                popStyle();
            }
        }
        return;
    }
}