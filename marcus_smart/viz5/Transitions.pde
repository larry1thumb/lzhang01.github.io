public class Transitions {
    boolean done;
    boolean sb0, sb1, sb2, sb3;
    boolean bs0, bs1, bs2, bs3;
    int lerpi = 0;
    Stacked s;
    BarGraph b;

    Transitions(Stacked sg, BarGraph bg) {
        done = false;
        sb0 = false;
        sb1 = false;
        sb2 = false;
        bs0 = false;
        bs1 = false;
        bs2 = false;
        bs3 = false;
        s = sg;
        b = bg;
    }

    void fadeout() {
        color c1 = color(0,0,0);
        color c2 = color(#f2f2f2);
        if (sb0 == true) {
            s.axes = lerpColor(c1, c2, lerpi/50.0);
            s.clabel = lerpColor(c1, c2, lerpi/50.0);
            s.render();
        } else if (bs0 == true) {
            b.axes = lerpColor(c1, c2, lerpi/50.0);
            b.clabel = lerpColor(c1, c2, lerpi/50.0);
            b.render();
        }
        if (lerpi < 50) {
            lerpi = lerpi + 4;
        } else {
            if (sb0 == true) {
                sb0 = false;
                sb1 = true;
            } else if (bs0 == true) {
                bs0 = false;
                bs1 = true;
            }
            lerpi = 0;
        }
    }

    void fadein() {
        color c1 = color(#000000);
        color c2 = color(#f2f2f2);
        if (sb1 == true) {
            b.axes = lerpColor(c2, c1, lerpi/50.0);
            b.clabel = lerpColor(c2, c1, lerpi/50.0);
            stroke(b.axes);
            line(b.x1, b.y1, b.x1, b.y2);
            line(b.x1, b.y2, b.x2, b.y2);
            for (int i = 0; i <= 7; i = i+1) {
                line(b.x1 - b.tick_length, b.y2 - i*b.y_interval, b.x1, b.y2 - i*b.y_interval);
                int txt = int(b.min_value + i*b.y_scale);
                textAlign(RIGHT);
                fill(b.axes);
                text(txt, b.x1-2*b.tick_length, b.y2 - i*b.y_interval);
            }
            rotate(-PI/2);
            pushStyle();
            textAlign(CENTER);
            fill(b.clabel);
            text(b.xlabel, (-b.y1-b.y2)/2, b.x1/4);
            popStyle();
            for (int i = 1; i <= b.num_elements; i = i+1) {
                fill(0, 0, 0);
                text(b.names[i-1], -1*b.y2 - b.tick_length, b.x1 + i*b.x_interval - b.x_interval/2);
            }
            rotate(PI/2);
            for (int i = 1; i <= b.num_elements; i++) {
                float val1 = s.ylength * s.values1[i-1]/s.max_value;
                float val2 = s.ylength * s.values2[i-1]/s.max_value;
                pushStyle();
                rectMode(CENTER);
                stroke(0, 0, 0);
                fill(#205093);
                rect(s.x1 + i*s.x_interval - s.x_interval/2, s.y2 - val1/2, s.bar_width, val1);
                fill(#b01d1d);
                rect(s.x1 + i*s.x_interval - s.x_interval/2, s.y2 - val1 - val2/2, s.bar_width, val2);
                popStyle();
            }
        } else if (bs1 == true) {
            s.axes = lerpColor(c2, c1, lerpi/50.0);
            s.clabel = lerpColor(c2, c1, lerpi/50.0);
            stroke(s.axes);
            line(s.x1, s.y1, s.x1, s.y2);
            line(s.x1, s.y2, s.x2, s.y2);
            for (int i = 0; i <= 10; i = i+1) {
                line(s.x1 - s.tick_length, s.y2 - i*s.y_interval, s.x1, s.y2 - i*s.y_interval);
                int txt = int(s.min_value + i*s.y_scale);
                textAlign(RIGHT);
                fill(s.axes);
                text(txt, s.x1-2*s.tick_length, s.y2 - i*s.y_interval);
            }
            rotate(-PI/2);
            pushStyle();
            textAlign(CENTER);
            fill(s.clabel);
            text(s.ylabel, (-s.y1-s.y2)/2, s.x1/4);
            popStyle();
            for (int i = 1; i <= s.num_elements; i = i+1) {
                fill(0, 0, 0);
                text(s.names[i-1], -1*s.y2 - s.tick_length, s.x1 + i*s.x_interval - s.x_interval/2);
            }
            rotate(PI/2);
            for (int i = 1; i <= b.num_elements; i++) {
                float val = b.ylength * b.values[i-1]/b.max_value;
                pushStyle();
                rectMode(CENTER);
                stroke(0, 0, 0);
                fill(#205093);
                rect(s.x1 + i*s.x_interval - s.x_interval/2, s.y2 - val/2, s.bar_width, val);
                popStyle();
            }
        }
        if (lerpi < 50) {
            lerpi = lerpi + 4;
        } else {
            if (sb1 == true) {
                sb1 = false;
                sb2 = true;
            } else if (bs1 == true) {
                bs1 = false;
                bs2 = true;
            }
            lerpi = 0;
        }
    }

    void normalize_vals() {
        //s.render();
        b.axes = #000000;
        b.clabel = #000000;
        stroke(b.axes);
        line(b.x1, b.y1, b.x1, b.y2);
        line(b.x1, b.y2, b.x2, b.y2);
        for (int i = 0; i <= 7; i = i+1) {
            line(b.x1 - b.tick_length, b.y2 - i*b.y_interval, b.x1, b.y2 - i*b.y_interval);
            int txt = int(b.min_value + i*b.y_scale);
            textAlign(RIGHT);
            fill(b.axes);
            text(txt, b.x1-2*b.tick_length, b.y2 - i*b.y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        fill(b.clabel);
        text(b.xlabel, (-b.y1-b.y2)/2, b.x1/4);
        popStyle();
        for (int i = 1; i <= b.num_elements; i = i+1) {
            fill(0, 0, 0);
            text(b.names[i-1], -1*b.y2 - b.tick_length, b.x1 + i*b.x_interval - b.x_interval/2);
        }
        rotate(PI/2);
        for (int i = 1; i <= b.num_elements; i++) {
            float normalized_made = s.ylength * b.values[i-1]/100.0;
            float val1 = s.ylength * s.values1[i-1]/s.max_value;
            float val2 = s.ylength * s.values2[i-1]/s.max_value;
            float tval1 = lerp(val1, normalized_made, lerpi/100.0);
            float perc = b.values[i-1]/100.0;
            float tval2 = lerp(val2, s.ylength * (s.max_value-(perc*s.max_value))/s.max_value, lerpi/100.0);
            pushStyle();
            rectMode(CENTER);
            stroke(0, 0, 0);
            fill(#205093);
            rect(s.x1 + i*s.x_interval - s.x_interval/2, s.y2 - tval1/2, s.bar_width, tval1);
            fill(#b01d1d);
            rect(s.x1 + i*s.x_interval - s.x_interval/2, s.y2 - tval1 - tval2/2, s.bar_width, tval2);
            popStyle();
        }
        if (lerpi < 100) {
            lerpi = lerpi + 4;
        } else {
            sb2 = false;
            sb3 = true;
            lerpi = 0;
        }
    }

    void fade_misses() {
        b.axes = color(0,0,0);
        b.clabel = color(0,0,0);
        stroke(b.axes);
        line(b.x1, b.y1, b.x1, b.y2);
        line(b.x1, b.y2, b.x2, b.y2);
        for (int i = 0; i <= 7; i = i+1) {
            line(b.x1 - b.tick_length, b.y2 - i*b.y_interval, b.x1, b.y2 - i*b.y_interval);
            int txt = int(b.min_value + i*b.y_scale);
            textAlign(RIGHT);
            fill(b.axes);
            text(txt, b.x1-2*b.tick_length, b.y2 - i*b.y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        fill(b.clabel);
        text(b.xlabel, (-b.y1-b.y2)/2, b.x1/4);
        popStyle();
        for (int i = 1; i <= b.num_elements; i = i+1) {
            fill(0, 0, 0);
            text(b.names[i-1], -1*b.y2 - b.tick_length, b.x1 + i*b.x_interval - b.x_interval/2);
        }
        rotate(PI/2);
        //s.render();
        for (int i = 1; i <= s.num_elements; i++) {
            float normalized_made = s.ylength * b.values[i-1]/100.0;
            float tval1 = normalized_made;
            float perc = b.values[i-1]/100.0;
            float tval2 = s.ylength * (s.max_value-(perc*s.max_value))/s.max_value;            
            pushStyle();
            rectMode(CENTER);
            stroke(0, 0, 0);
            fill(#205093);
            rect(s.x1 + i*s.x_interval - s.x_interval/2.0, s.y2 - tval1/2.0, s.bar_width, tval1);
            float rect_width = lerp(s.bar_width, 0, lerpi/100.0);
            float rect_height = lerp(tval2, 0, lerpi/100.0);
            fill(#b01d1d);
            rect(s.x1 + i*s.x_interval - s.x_interval/2.0, s.y2 - tval1 - tval2/2.0, rect_width, rect_height);
            popStyle();
        }
        if (lerpi < 100) {
            lerpi = lerpi + 4;
        } else {
            sb3 = false;
            done = true;
            lerpi = 0;
        }
    }

    void add_misses() {
        stroke(s.axes);
        line(s.x1, s.y1, s.x1, s.y2);
        line(s.x1, s.y2, s.x2, s.y2);
        for (int i = 0; i <= 10; i = i+1) {
            line(s.x1 - s.tick_length, s.y2 - i*s.y_interval, s.x1, s.y2 - i*s.y_interval);
            int txt = int(s.min_value + i*s.y_scale);
            textAlign(RIGHT);
            fill(s.axes);
            text(txt, s.x1-2*s.tick_length, s.y2 - i*s.y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        fill(s.clabel);
        text(s.ylabel, (-s.y1-s.y2)/2, s.x1/4);
        popStyle();
        for (int i = 1; i <= s.num_elements; i = i+1) {
            fill(0, 0, 0);
            text(s.names[i-1], -1*s.y2 - s.tick_length, s.x1 + i*s.x_interval - s.x_interval/2);
        }
        rotate(PI/2);
        for (int i = 1; i <= s.num_elements; i++) {
            float normalized_made = s.ylength * b.values[i-1]/100.0;
            float tval1 = normalized_made;
            float perc = b.values[i-1]/100.0;
            float tval2 = s.ylength * (s.max_value-(perc*s.max_value))/s.max_value;
            pushStyle();
            rectMode(CENTER);
            stroke(0, 0, 0);
            fill(#205093);
            rect(s.x1 + i*s.x_interval - s.x_interval/2.0, s.y2 - tval1/2.0, s.bar_width, tval1);
            rectMode(CORNERS);
            float rect_height = lerp(0, tval2, lerpi/100.0);
            fill(#b01d1d);
            //rect(s.x1 + i*s.x_interval - s.x_interval/2.0, s.y2 - tval1 - tval2/2.0, s.bar_width, rect_height);
            rect(s.x1 + i*s.x_interval - s.x_interval + s.bar_width/2, s.y2 - tval1, s.x1 + i*s.x_interval - s.bar_width/2, s.y2 - tval1 - rect_height); 
            popStyle();
        }
        if (lerpi < 100) {
            lerpi = lerpi + 4;
        } else {
            bs2 = false;
            bs3 = true;
            lerpi = 0;
        }
    }

    void unnormalize() {
        stroke(s.axes);
        line(s.x1, s.y1, s.x1, s.y2);
        line(s.x1, s.y2, s.x2, s.y2);
        for (int i = 0; i <= 10; i = i+1) {
            line(s.x1 - s.tick_length, s.y2 - i*s.y_interval, s.x1, s.y2 - i*s.y_interval);
            int txt = int(s.min_value + i*s.y_scale);
            textAlign(RIGHT);
            fill(s.axes);
            text(txt, s.x1-2*s.tick_length, s.y2 - i*s.y_interval);
        }
        rotate(-PI/2);
        pushStyle();
        textAlign(CENTER);
        fill(s.clabel);
        text(s.ylabel, (-s.y1-s.y2)/2, s.x1/4);
        popStyle();
        for (int i = 1; i <= s.num_elements; i = i+1) {
            fill(0, 0, 0);
            text(s.names[i-1], -1*s.y2 - s.tick_length, s.x1 + i*s.x_interval - s.x_interval/2);
        }
        rotate(PI/2);
        for (int i = 1; i <= b.num_elements; i++) {
            float normalized_made = s.ylength * b.values[i-1]/100.0;
            float val1 = s.ylength * s.values1[i-1]/s.max_value;
            float val2 = s.ylength * s.values2[i-1]/s.max_value;
            float perc = b.values[i-1]/100.0;
            float tval1 = lerp(normalized_made, val1, lerpi/100.0);
            float tval2 = lerp(s.ylength * (s.max_value-(perc*s.max_value))/s.max_value, val2, lerpi/100.0);
            pushStyle();
            rectMode(CENTER);
            stroke(0, 0, 0);
            fill(#205093);
            rect(s.x1 + i*s.x_interval - s.x_interval/2, s.y2 - tval1/2, s.bar_width, tval1);
            fill(#b01d1d);
            rect(s.x1 + i*s.x_interval - s.x_interval/2, s.y2 - tval1 - tval2/2, s.bar_width, tval2);
            popStyle();
        }
        if (lerpi < 100) {
            lerpi = lerpi + 4;
        } else {
            bs3 = false;
            done = true;
            lerpi = 0;
        }
    }
}