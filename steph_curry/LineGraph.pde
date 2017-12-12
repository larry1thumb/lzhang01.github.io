public class LineGraph {
    float x1, x2, y1, y2;
    float point_size;
    float xlength; //length of x-axis
    float ylength; //length of y-axis
    String names[];
    float values0[];
    float values1[];
    float values2[];
    float values3[];
    float values4[];

    float x_interval; //distance between two points
    float y_interval; //distance between each tick
    float y_scale;
    float tick_length;
    float min_value;
    float max_value;
    int num_elements;
    String xlabel;
    String ylabel;
    color cline = color(0, 0, 0);
    color cpoint = color(0, 0, 0);
    int player = -1;
    int stroke0 = 1;
    int stroke1 = 1;
    int stroke2 = 1;
    int stroke3 = 1;
    int stroke4 = 1;
    boolean show0;
    boolean show1;
    boolean show2;
    boolean show3;
    boolean show4;

    LineGraph (float init_x, float init_y, float w, float h, String x[], float steph[], float klay[], float damian[], float james[], float kyle[], String labels[]) {
        x1 = 0.1 * w + init_x;
        x2 = 0.8 * w + init_x;
        y1 = 0.1 * h;
        y2 = 0.8 * h;
        point_size = 0.01 * w;
        xlength = w * 0.7;
        ylength = h * 0.7;
        names = x;
        values0 = steph;
        values1 = klay;
        values2 = damian;
        values3 = james;
        values4 = kyle;

        min_value = 0;//min(james) - min(james) % 10;
        max_value = max(steph) + (10 - max(steph) % 10);

        num_elements = x.length;
        x_interval = xlength/num_elements;
        y_interval = ylength/10;
        y_scale = (max_value-min_value)/10;
        tick_length = xlength * .01;

        xlabel = labels[0];
        ylabel = labels[1];
    }
    
    void change_array(float a[], float b[], float c[], float d[], float e[]) {
        values0 = a;
        values1 = b;
        values2 = c;
        values3 = d;
        values4 = e;
    }

    public void render() {
        line(x1, y1, x1, y2);
        line(x1, y2, x2, y2);
        for (int i = 0; i <= 10; i = i+1) {
            line(x1 - tick_length, y2 - i*y_interval, x1, y2 - i*y_interval);
            int txt = int(min_value + i*y_scale);
            textAlign(RIGHT);
            fill(#000000);
            text(txt, x1-2*tick_length, y2 - i*y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        text("3P Field Goal Percent", (-y1-y2)/2, x1-40);
        popStyle();
        for (int i = 1; i <= num_elements; i = i+1) {
            text(names[i-1], -1*y2 - tick_length, x1 + i*x_interval - x_interval/2);
        }
        rotate(PI/2);
        for (int i = 1; i <= num_elements; i = i+1) {
            float val0 = ylength * values0[i-1]/(max_value);
            float val1 = ylength * values1[i-1]/(max_value);
            float val2 = ylength * values2[i-1]/(max_value);
            float val3 = ylength * values3[i-1]/(max_value);
            float val4 = ylength * values4[i-1]/(max_value);

            if (i > 1) {
                pushStyle();
                float val0_2 = ylength * values0[i-2]/(max_value);
                float val1_2 = ylength * values1[i-2]/(max_value);
                float val2_2 = ylength * values2[i-2]/(max_value);
                float val3_2 = ylength * values3[i-2]/(max_value);
                float val4_2 = ylength * values4[i-2]/(max_value);
                if (show1 == true) {
                    stroke(34, 130, 245);
                    strokeWeight(stroke1);
                    line(x1 + (i-1)*x_interval - x_interval/2, y2-val1_2, x1+i*x_interval - x_interval/2, y2-val1);
                }
                if (show2 == true) {
                    stroke(255, 0, 0);
                    strokeWeight(stroke2);
                    line(x1 + (i-1)*x_interval - x_interval/2, y2-val2_2, x1+i*x_interval - x_interval/2, y2-val2);
                }
                if (show3 == true) {
                    stroke(215, 74, 242);
                    strokeWeight(stroke3);
                    line(x1 + (i-1)*x_interval - x_interval/2, y2-val3_2, x1+i*x_interval - x_interval/2, y2-val3);
                }
                if (show4 == true) {
                    stroke(250, 197, 37);
                    strokeWeight(stroke4);
                    line(x1 + (i-1)*x_interval - x_interval/2, y2-val4_2, x1+i*x_interval - x_interval/2, y2-val4);
                }
                if (show0 == true) {
                    stroke(195, 65, 119);
                    strokeWeight(stroke0);
                    line(x1 + (i-1)*x_interval - x_interval/2, y2-val0_2, x1+i*x_interval - x_interval/2, y2-val0);
                }
                popStyle();
            }
        }

        pushStyle();
        textAlign(LEFT, CENTER);
        rectMode(CORNER);
        noFill();
        rect(x2, y1, 0.25*(xlength), 100);
        fill(195, 65, 119);
        rect(x2 + tick_length, y1 + 10, tick_length, tick_length);
        fill(0, 0, 0);
        text("S. Curry", x2 + tick_length*3, y1 + 10);
        fill(34, 130, 245);
        rect(x2 + tick_length, y1 + 30, tick_length, tick_length); 
        fill(0, 0, 0);
        text("K. Thompson", x2 + tick_length*3, y1 + 30);
        fill(255, 0, 0);
        rect(x2 + tick_length, y1 + 50, tick_length, tick_length); 
        fill(0, 0, 0);
        text("D. Lillard", x2 + tick_length*3, y1 + 50);
        fill(215, 74, 242);
        rect(x2 + tick_length, y1 + 70, tick_length, tick_length); 
        fill(0, 0, 0);
        text("J. Harden", x2 + tick_length*3, y1 + 70);
        fill(250, 197, 37);
        rect(x2 + tick_length, y1 + 90, tick_length, tick_length); 
        fill(0, 0, 0);
        text("K. Lowry", x2 + tick_length*3, y1 + 90);
        popStyle();
    }

    public void set_cline(color c) {
        cline = c;
    }

    void choose_player(int player) {
        stroke0 = 1;
        stroke1 = 1;
        stroke2 = 1;
        stroke3 = 1;
        stroke4 = 1;
        if (player == 0)
            stroke0 = 3;
        else if (player == 1) 
            stroke1 = 3;
        else if (player == 2)
            stroke2 = 3;
        else if (player == 3)
            stroke3 = 3;
        else if (player == 4)
            stroke4 = 3;
    }

    void select_all() {
        show0 = true;
        show1 = true;
        show2 = true;
        show3 = true;
        show4 = true;
    }
    
    void select() {
        if (mousePressed && mouseButton == LEFT && mouseX > x2 && mouseX < x2+0.25*xlength && mouseY > y1 && mouseY < y1+20) {
            show0 = true;
            show1 = false;
            show2 = false;
            show3 = false;
            show4 = false;
            choose_player(0);
            player = 0;
        } else if (mousePressed && mouseButton == LEFT && mouseX > x2 && mouseX < x2+0.25*xlength && mouseY > y1+20 && mouseY < y1+40) {
            show0 = true;
            show1 = true;
            show2 = false;
            show3 = false;
            show4 = false;
            choose_player(1);
            player = 1;
        } else if (mousePressed && mouseButton == LEFT && mouseX > x2 && mouseX < x2+0.25*xlength && mouseY > y1+40 && mouseY < y1+60) {
            show0 = true;
            show1 = false;
            show2 = true;
            show3 = false;
            show4 = false;
            choose_player(2);
            player = 2;
        } else if (mousePressed && mouseButton == LEFT && mouseX > x2 && mouseX < x2+0.25*xlength && mouseY > y1+60 && mouseY < y1+80) {
            show0 = true;
            show1 = false;
            show2 = false;
            show3 = true;
            show4 = false;
            choose_player(3);
            player = 3;
        } else if (mousePressed && mouseButton == LEFT && mouseX > x2 && mouseX < x2+0.25*xlength && mouseY > y1+80 && mouseY < y1+100) {
            show0 = true;
            show1 = false;
            show2 = false;
            show3 = false;
            show4 = true;
            choose_player(4);
            player = 4;
        } else if (mousePressed && mouseButton == RIGHT && mouseX > x2 && mouseX < x2+0.25*xlength && mouseY > y1 && mouseY < y1+100) {
            select_all();
            player = -1;
        }
    }
}