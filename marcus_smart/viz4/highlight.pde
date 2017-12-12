public class highlight {
    BarGraph b;
    ScatterPlot s;

    highlight(BarGraph bg, ScatterPlot sp) {
        b = bg;
        s = sp;
    }

    public void interact() {
        for (int i = 1; i <= b.num_elements; i++) {
            float val1 = b.ylength * (b.values[i-1]-b.min_value)/(b.max_value-b.min_value);
            float xx1 = b.x1 + i*b.x_interval - b.x_interval/2 - b.x_interval/4;
            float xx2 = b.x1 + i*b.x_interval - b.x_interval/4;
            float yy1 = b.y2 - val1;
            float yy2 = b.y2;

            float yval = s.spheight * (s.y1[i-1] - s.ymin)/(s.ymax-s.ymin);
            float xval = s.spwidth/2 * (s.x1[i-1] - s.x1min)/(s.x1max-s.x1min);
            float x2val = s.spwidth/2 * (s.x2[i-1] - s.x2min)/(s.x2max-s.x2min);
            float P_x = xval + s.xpos;
            float P_y = s.ypos + s.spheight - yval;
            float P_x2 = x2val + s.xpos + s.spwidth/2;

            if ((mouseX < xx2 && mouseX > xx1 && mouseY < yy2 && mouseY > yy1) || 
                (mouseX < P_x + 8 && mouseX > P_x && mouseY < P_y + 8 && mouseY > P_y) ||
                (mouseX < P_x2 + 8 && mouseX > P_x2 && mouseY < P_y + 8 && mouseY > P_y)) {
                int mode = -1;
                if (mouseX < xx2 && mouseX > xx1 && mouseY < yy2 && mouseY > yy1) {
                    mode = 0;
                } else if (mouseX < P_x + 8 && mouseX > P_x && mouseY < P_y + 8 && mouseY > P_y) {
                    mode = 1;
                } else if (mouseX < P_x2 + 8 && mouseX > P_x2 && mouseY < P_y + 8 && mouseY > P_y) {
                    mode = 1;
                }
                float desc_fl = (b.values[i-1]);
                String desc = nfc(desc_fl, 1);
                desc += " fg%";

                fill(#ff3333);
                rect(b.x1 + i*b.x_interval - b.x_interval/2, b.y2 - val1/2, b.x_interval/2, val1);
                fill(#000000);
                if (mode == 0) {
                    textAlign(LEFT);
                    text(desc, mouseX + b.tick_length, mouseY);
                } else if (mode == 1) {
                    //textAlign(RIGHT);
                    //text(b.names[i-1], mouseX - 2*b.tick_length, mouseY);
                    textAlign(CENTER);
                    text(b.names[i-1] + ":", s.xpos + s.spwidth/2, s.ypos + s.spheight + 50);
                    text("FG%: " + b.values[i-1], s.xpos + s.spwidth/2, s.ypos + s.spheight + 70);
                    if (s.x1[i-1] > 0) {
                        text("On-Off Offensive Rating: +" + s.x1[i-1], s.xpos + s.spwidth/2, s.ypos + s.spheight + 90);
                    } else {
                        text("On-Off Offensive Rating: " + s.x1[i-1], s.xpos + s.spwidth/2, s.ypos + s.spheight + 90);
                    }
                    if (s.x2[i-1] > 0) {
                        text("+/- (per 36 minutes): +" + s.x2[i-1], s.xpos + s.spwidth/2, s.ypos + s.spheight + 110);
                    } else {
                        text("+/- (per 36 minutes): " + s.x2[i-1], s.xpos + s.spwidth/2, s.ypos + s.spheight + 110);
                    }
                }
                b.player = i-1;
                pushStyle();
                textAlign(CENTER);
                if (b.player == 0) {
                    text("2011-12 NBA Season", b.x1*5, b.y1/2.0);
                } else if (b.player == 1) {
                    text("2014-15 NBA Season", b.x1*5, b.y1/2.0);
                } else if (b.player == 2) {
                    text("2000-01 NBA Season", b.x1*5, b.y1/2.0);
                } else if (b.player == 3) {
                    text("2001-02 NBA Season", b.x1*5, b.y1/2.0);
                } else if (b.player == 4) {
                    text("2006-07 NBA Season", b.x1*5, b.y1/2.0);
                } else if (b.player == 5) {
                    text("1989-90 NBA Season", b.x1*5, b.y1/2.0);
                } else if (b.player == 6) {
                    text("2008-09 NBA Season", b.x1*5, b.y1/2.0);
                } else if (b.player == 7) {
                    text("2017-2018 NBA Season", b.x1*5, b.y1/2.0);
                    text("* Worst FG% in NBA history", b.x1*5, 20+b.y1/2.0);
                }
                fill(#ff3333);
                ellipseMode(CENTER);
                noStroke();
                ellipse(P_x, P_y, s.pointSize, s.pointSize);
                ellipse(P_x2, P_y, s.pointSize, s.pointSize);
                popStyle();
            }
        }
        return;
    }
}