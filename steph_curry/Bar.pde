public class Bar {
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
    String ylabel;
    float bar_width;
    color axes = color(0, 0, 0);
    int player = 1;
    int shottype = 0;
    color barcolor;
    Bar (float w, float h, String x[], float y[], String labels[], color c) {
        x1 = 0.1 * w;
        x2 = 0.8 * w;
        y1 = 0.1 * h;
        y2 = 0.8 * h;
        barcolor = c;
        xlength = w * 0.7;
        ylength = h * 0.7;
        names = x;
        values = y;

        min_value = 0;//min(y) - min(y) % 10;
        max_value = max(y) + (10 - max(y) % 10);

        num_elements = 5;
        x_interval = xlength/num_elements;
        y_interval = ylength/10;
        y_scale = (max_value-min_value)/10;
        tick_length = xlength * .01;

        xlabel = labels[0];
        ylabel = labels[1];
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
        text("Number of 3P Field Goals Made", (-y1-y2)/2, x1/4);
        popStyle();
        for (int i = 1; i <= num_elements; i = i+1) {
            text(names[i-1], -1*y2 - tick_length, x1 + i*x_interval - x_interval/2);
        }
        rotate(PI/2);
        rectMode(CENTER);
        for (int i = 1; i <= num_elements; i = i+1) {
            float val = ylength * values[i-1]/max_value;
            pushStyle();
            stroke(0, 0, 0);
            fill(barcolor);
            rect(x1 + i*x_interval - x_interval/2, y2 - val/2, bar_width, val);
            popStyle();
        }
        stroke(0, 0, 0);
        pushStyle();
        textAlign(LEFT, CENTER);
        rectMode(CORNER);
        noFill();
        rect(x2, y1, 0.25*(xlength), 30);

        if (barcolor == color(#4682b4)) {
            fill(#4682b4);
            rect(x2 + tick_length, y1 + 10, tick_length, tick_length);
            fill(0, 0, 0);
            text("Catch and Shoot", x2 + tick_length*3, y1 + 10);
        } else {
            fill(#1e90ff);
            rect(x2 + tick_length, y1 + 10, tick_length, tick_length); 
            fill(0, 0, 0);
            text("Pullup", x2 + tick_length*3, y1 + 10);
        }
        popStyle();
    }

    void highlight() {
        for (int i = 1; i <= num_elements; i++) {
            float val1 = ylength * values[i-1]/max_value;
            float xx1 = x1 + i*x_interval - x_interval/2 - x_interval/4;
            float xx2 = x1 + i*x_interval - x_interval/4;
            float yy1 = y2 - val1;
            float yy2 = y2;

            if (mouseX < xx2 && mouseX > xx1 && mouseY < yy2 && mouseY > yy1) {
                String desc_int = nfc(values[i-1], 0);
                
                String desc = names[i-1] + ", " + desc_int;
                //text(desc, x1 + i*x_interval, yy1 - tick_length);
                fill(#87cefa);
                rect(x1 + i*x_interval - x_interval/2, y2 - val1/2, x_interval/2, val1);
                fill(#000000);
                textAlign(LEFT);
                text(desc, mouseX + tick_length, mouseY);
                player = i-1;
            }
        }
        return;
    }

    void change_back() {
        for (int i = 1; i <= num_elements; i++) {
            float val1 = ylength * values[i-1]/max_value;
            float xx1 = x1 + i*x_interval - x_interval/2 - x_interval/4;
            float xx2 = x1 + i*x_interval - x_interval/4;
            float yy1 = y2 - val1;
            float yy2 = y2;

            if (mousePressed && mouseButton == RIGHT && mouseX < xx2 && mouseX > xx1 && mouseY < yy2 && mouseY > yy1) {
                shottype = 1;
            }
        }
    }
}