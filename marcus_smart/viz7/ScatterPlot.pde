public class ScatterPlot {
    float xpos, ypos;
    float spwidth, spheight;
    float x1[];
    String names[];
    float y1[];
    String positions[];
    int ymax, ymin;
    int x1max, x1min;
    int yscale, x1scale;
    int ynumticks, x1numticks;
    float tick_length;
    int num_elements;
    String ylabel;
    String x1label;
    int pointSize = 8;
    ScatterPlot(float xposition, float yposition, float w, float h, float yvals[], float x1vals[], String nms[], String ylbl, String x1lbl, String x2lbl, String pos[]) {
        xpos = 0.05 * w + xposition;
        ypos = 0.1 * h + yposition;
        spwidth = 0.9 * w;
        spheight = 0.9 * h;
        x1 = x1vals;
        names = nms;
        y1 = yvals;
        positions = pos;
        num_elements = yvals.length;
        ylabel = ylbl;
        x1label = x1lbl;
        float diff = max(y1) - min(y1);
        diff = diff/10.0;
        yscale = (int) Math.ceil(diff);
        ymin = (int) min(y1) - yscale;
        ymax = (int) max(y1) + yscale;

        diff = max(x1) - min(x1);
        diff = diff/10.0;
        x1scale = (int) Math.ceil(diff);
        x1min = (int) min(x1) - x1scale;
        x1max = (int) max(x1) + x1scale;

        ynumticks = (ymax - ymin) / yscale;
        x1numticks = (x1max - x1min) / x1scale;
        tick_length = 0.01 * spwidth;
    }

    public void render() {
        pushStyle();
        fill(#f2f2f2);
        rectMode(CORNER);
        stroke(0, 0, 0);
        rect(xpos, ypos, spwidth, spheight);
        line(xpos + spwidth, ypos, xpos + spwidth, ypos + spheight);
        textAlign(CENTER);
        fill(0, 0, 0);
        text(x1label, xpos + spwidth/2, ypos - .05*spheight);
        rotate(-PI/2);
        text(ylabel, -1*(ypos+spheight/2), xpos-.075*spwidth);
        rotate(PI/2);        
        for (int i = 0; i <= ynumticks; i++) {
            float tick_distance = spheight/ynumticks;
            stroke(0, 0, 0);
            line(xpos - tick_length, ypos + spheight - (i* tick_distance), xpos, ypos + spheight - (i* tick_distance));
            textAlign(RIGHT);
            text(ymin + i*yscale, xpos - 2*tick_length, ypos + spheight - (i * tick_distance));
        }
        for (int i = 0; i < x1numticks; i++) {
            float tick_distance = spwidth/(x1numticks);
            line(xpos + (i * tick_distance), ypos + spheight, xpos + (i * tick_distance), ypos + spheight + tick_length);
            textAlign(CENTER, TOP);
            text(x1min + (i*x1scale), xpos + (i * tick_distance), ypos + spheight + tick_length);
        }
        popStyle();
        //first scatterplot
        for (int i = 0; i < num_elements; i++) {
            float yval = spheight * (y1[i] - ymin)/(ymax-ymin);
            float xval = spwidth * (x1[i] - x1min)/(x1max-x1min);
            float P_x = xval + xpos;
            float P_y = ypos + spheight - yval;
            pushStyle();
            fill(0, 0, 0);
            noStroke();
            ellipseMode(CENTER);
            if (isSmart(i) == true) {
                ellipse(P_x, P_y, pointSize*2, pointSize*2);
            } else {
                ellipse(P_x, P_y, pointSize, pointSize);
            }
            popStyle();
        }
    }


    boolean isSmart(int i) {
        if (y1[i] == 37.4) {
            return true;
        } else
            return false;
    }

    void highlight() {
        for (int i = 1; i <= num_elements; i++) {
            float yval = spheight * (y1[i-1] - ymin)/(ymax-ymin);
            float xval = spwidth * (x1[i-1] - x1min)/(x1max-x1min);
            float P_x = xval + xpos;
            float P_y = ypos + spheight - yval;
            float psize = pointSize;
            if (isSmart(i-1)) {
                psize = psize * 2;
            }
            if (mouseX < P_x + psize/2 && mouseX > P_x - psize/2 && mouseY < P_y + psize/2 && mouseY > P_y - psize/2) {
                fill(#0dd5fc);
                ellipseMode(CENTER);
                noStroke();
                ellipse(P_x, P_y, psize, psize);
                fill(0, 0, 0);
                text(names[i-1], P_x + 10, P_y);
            }
        }
    }
}