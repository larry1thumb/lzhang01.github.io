public class TransSameType2 {
    BarGraph b1, b2;
    boolean done;
    boolean a, b, c;
    boolean x, y, z;
    int lerpi;

    TransSameType2(BarGraph bg1, BarGraph bg2) {
        b1 = bg1;
        b2 = bg2;
        done = false;
        a = true;
        b = false;
        c = false;
        x = false;
        y = false;
        z = false;
    }
    void fadeout() {
        color c1 = #000000;
        color c2 = #f2f2f2;
        if (a == true) {
            b1.clabel = lerpColor(c1, c2, lerpi/50.0);
            b1.render();
        } else {
            b2.clabel = lerpColor(c1, c2, lerpi/50.0);
            b2.render();
        }
        if (lerpi < 50) {
            lerpi = lerpi + 5;
        } else {
            if (a == true) {
                a = false;
                b = true;
            } else {
                x = false;
                y = true;
            }
            lerpi = 0;
        }
    }

    void fadein() {
        color c1 = #000000;
        color c2 = #f2f2f2;
        if (c == true) {
            b2.clabel = lerpColor(c2, c1, lerpi/50.0);
            b2.render();
        } else {
            b1.clabel = lerpColor(c2, c1, lerpi/50.0);
            b1.render();
        }
        if (lerpi < 50) {
            lerpi = lerpi + 5;
        } else {
            if (c == true) {
                c = false;
                done = true;
            } else {
                z = false;
                done = true;
            }
            lerpi = 0;
        }
    }

    void to3() {
        line(b1.x1, b1.y1, b1.x1, b1.y2);
        line(b1.x1, b1.y2, b1.x2, b1.y2);
        for (int i = 0; i <= 10; i = i+1) {
            line(b1.x1 - b1.tick_length, b1.y2 - i*b1.y_interval, b1.x1, b1.y2 - i*b1.y_interval);
            int txt = int(b1.min_value + i*b1.y_scale);
            textAlign(RIGHT);
            fill(0, 0, 0);
            text(txt, b1.x1-2*b1.tick_length, b1.y2 - i*b1.y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        popStyle();
        for (int i = 1; i <= b1.num_elements; i = i+1) {
            stroke(0, 0, 0);
            fill(0, 0, 0);
            text(b1.names[i-1], -1*b1.y2 - b1.tick_length, b1.x1 + i*b1.x_interval - b1.x_interval/2);
            stroke(b1.axes);
            fill(b1.axes);
        }
        rotate(PI/2);
        for (int i = 1; i <= b1.num_elements; i++) {
            float b1val1 = b1.ylength * b1.values[i-1]/b1.max_value;
            float b2val1 = b2.ylength * b2.values[i-1]/b2.max_value;
            float tval1 = lerp(b1val1, b2val1, lerpi/50.0);
            pushStyle();
            rectMode(CENTER);
            stroke(0, 0, 0);
            fill(#205093);
            rect(b2.x1 + i*b2.x_interval - b2.x_interval/2, b2.y2 - tval1/2, b2.bar_width, tval1);
            popStyle();
        }
        if (lerpi < 50) {
            lerpi = lerpi + 4;
        } else {
            b = false;
            c = true;
            lerpi = 0;
        }
    }


    void tofg() {
        stroke(0, 0, 0);
        line(b2.x1, b2.y1, b2.x1, b2.y2);
        line(b2.x1, b2.y2, b2.x2, b2.y2);
        for (int i = 0; i < 10; i = i+1) {
            line(b2.x1 - b2.tick_length, b2.y2 - i*b2.y_interval, b2.x1, b2.y2 - i*b2.y_interval);
            int txt = int(b2.min_value + i*b2.y_scale);
            textAlign(RIGHT);
            fill(0, 0, 0);
            text(txt, b2.x1-2*b2.tick_length, b2.y2 - i*b2.y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        popStyle();
        for (int i = 1; i <= b2.num_elements; i = i+1) {
            stroke(0, 0, 0);
            fill(0, 0, 0);
            text(b2.names[i-1], -1*b2.y2 - b2.tick_length, b2.x1 + i*b2.x_interval - b2.x_interval/2);
            stroke(b2.axes);
            fill(b2.axes);
        }
        rotate(PI/2);
        for (int i = 1; i <= b1.num_elements; i++) {
            float b1val1 = b1.ylength * b1.values[i-1]/b1.max_value;
            float b2val1 = b2.ylength * b2.values[i-1]/b2.max_value;
            float tval1 = lerp(b2val1, b1val1, lerpi/50.0);
            pushStyle();
            rectMode(CENTER);
            stroke(0, 0, 0);
            fill(#205093);
            rect(b1.x1 + i*b1.x_interval - b1.x_interval/2, b1.y2 - tval1/2, b1.bar_width, tval1);
            popStyle();
        }
        if (lerpi < 50) {
            lerpi = lerpi + 4;
        } else {
            y = false;
            z = true;
            lerpi = 0;
        }
    }
}