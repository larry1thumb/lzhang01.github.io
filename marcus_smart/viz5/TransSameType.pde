public class TransSameType {
    Stacked s1, s2;
    BarGraph b1, b2;
    boolean done;
    boolean a, b, c;
    boolean x, y, z;
    int lerpi;
    TransSameType(Stacked sg1, Stacked sg2) {
        s1 = sg1;
        s2 = sg2;
        b1 = null;
        b2 = null;
        done = false;
        a = true;
        b = false;
        c = false;
        x = false;
        y = false;
        z = false;
        lerpi = 0;
    }

    TransSameType(BarGraph bg1, BarGraph bg2) {
        b1 = bg1;
        b2 = bg2;
        s1 = null;
        s2 = null;
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
            if (b1 == null) {
                s1.clabel = lerpColor(c1, c2, lerpi/50.0);
                s1.render();
            } else {
                b1.clabel = lerpColor(c1, c2, lerpi/50.0);
                b1.render();
            }
        } else {
            if (b1 == null) {
                s2.clabel = lerpColor(c1, c2, lerpi/50.0);
                s2.render();
            } else {
                b2.clabel = lerpColor(c1, c2, lerpi/50.0);
                b2.render();
            }
        }
        if (lerpi < 50) {
            lerpi = lerpi + 4;
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
            if (b1 == null) {
                s2.clabel = lerpColor(c2, c1, lerpi/50.0);
                s2.render();
            } else {
                b2.clabel = lerpColor(c2, c1, lerpi/50.0);
                b2.render();
            }
        } else {
            if (b1 == null) {
                s1.clabel = lerpColor(c2, c1, lerpi/50.0);
                s1.render();
            } else {
                b1.clabel = lerpColor(c2, c1, lerpi/50.0);
                b1.render();
            }
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
        stroke(0, 0, 0);
        line(s1.x1, s1.y1, s1.x1, s1.y2);
        line(s1.x1, s1.y2, s1.x2, s1.y2);
        for (int i = 0; i <= 10; i = i+1) {
            line(s1.x1 - s1.tick_length, s1.y2 - i*s1.y_interval, s1.x1, s1.y2 - i*s1.y_interval);
            int txt = int(s1.min_value + i*s1.y_scale);
            textAlign(RIGHT);
            fill(0, 0, 0);
            text(txt, s1.x1-2*s1.tick_length, s1.y2 - i*s1.y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        popStyle();
        for (int i = 1; i <= s1.num_elements; i = i+1) {
            stroke(0, 0, 0);
            fill(0, 0, 0);
            text(s1.names[i-1], -1*s1.y2 - s1.tick_length, s1.x1 + i*s1.x_interval - s1.x_interval/2);
            stroke(s1.axes);
            fill(s1.axes);
        }
        rotate(PI/2);
        for (int i = 1; i <= s1.num_elements; i++) {
            float s1val1 = s1.ylength * s1.values1[i-1]/s1.max_value;
            float s1val2 = s1.ylength * s1.values2[i-1]/s1.max_value;
            float s2val1 = s2.ylength * s2.values1[i-1]/s2.max_value;
            float s2val2 = s2.ylength * s2.values2[i-1]/s2.max_value;
            float tval1 = lerp(s1val1, s2val1, lerpi/100.0);
            float tval2 = lerp(s1val2, s2val2, lerpi/100.0);
            pushStyle();
            rectMode(CENTER);
            stroke(0, 0, 0);
            fill(#205093);
            rect(s2.x1 + i*s2.x_interval - s2.x_interval/2, s2.y2 - tval1/2, s2.bar_width, tval1);
            fill(#b01d1d);
            rect(s2.x1 + i*s2.x_interval - s2.x_interval/2, s2.y2 - tval1 - tval2/2, s2.bar_width, tval2);
            popStyle();
        }
        if (lerpi < 100) {
            lerpi = lerpi + 4;
        } else {
            b = false;
            c = true;
            lerpi = 0;
        }
    }
    void to3b() {
        line(b1.x1, b1.y1, b1.x1, b1.y2);
        line(b1.x1, b1.y2, b1.x2, b1.y2);
        for (int i = 0; i < 8; i = i+1) {
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
        if (b1 == null) {
            line(s2.x1, s2.y1, s2.x1, s2.y2);
            line(s2.x1, s2.y2, s2.x2, s2.y2);
            for (int i = 0; i < 8; i = i+1) {
                line(s2.x1 - s2.tick_length, s2.y2 - i*s2.y_interval, s2.x1, s2.y2 - i*s2.y_interval);
                int txt = int(s2.min_value + i*s2.y_scale);
                textAlign(RIGHT);
                fill(0, 0, 0);
                text(txt, s2.x1-2*s2.tick_length, s2.y2 - i*s2.y_interval);
            }
            rotate(-PI/2);
            pushStyle();
            textAlign(CENTER);
            popStyle();
            for (int i = 1; i <= s2.num_elements; i = i+1) {
                stroke(0, 0, 0);
                fill(0, 0, 0);
                text(s2.names[i-1], -1*s2.y2 - s2.tick_length, s2.x1 + i*s2.x_interval - s2.x_interval/2);
                stroke(s2.axes);
                fill(s2.axes);
            }
            rotate(PI/2);

            for (int i = 1; i <= s2.num_elements; i++) {
                float s1val1 = s1.ylength * s1.values1[i-1]/s1.max_value;
                float s1val2 = s1.ylength * s1.values2[i-1]/s1.max_value;
                float s2val1 = s2.ylength * s2.values1[i-1]/s2.max_value;
                float s2val2 = s2.ylength * s2.values2[i-1]/s2.max_value;
                float tval1 = lerp(s2val1, s1val1, lerpi/100.0);
                float tval2 = lerp(s2val2, s1val2, lerpi/100.0);
                pushStyle();
                rectMode(CENTER);
                stroke(0, 0, 0);
                fill(#205093);
                rect(s2.x1 + i*s2.x_interval - s2.x_interval/2, s2.y2 - tval1/2, s2.bar_width, tval1);
                fill(#b01d1d);
                rect(s2.x1 + i*s2.x_interval - s2.x_interval/2, s2.y2 - tval1 - tval2/2, s2.bar_width, tval2);
                popStyle();
            }
            if (lerpi < 100) {
                lerpi = lerpi + 4;
            } else {
                y = false;
                z = true;
                lerpi = 0;
            }
        } else {
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
}