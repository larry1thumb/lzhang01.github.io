public class ScatterPlot {
    float xpos, ypos;
    float spwidth, spheight;
    float x1[];
    float x2[];
    float y1[];
    int ymax, ymin;
    int x1max, x1min;
    int x2max, x2min;
    int yscale, x1scale, x2scale;
    int ynumticks, x1numticks, x2numticks;
    float tick_length;
    int num_elements;
    String ylabel;
    String x1label, x2label;
    int pointSize = 8;
    ScatterPlot(float xposition, float yposition, float w, float h, float yvals[], float x1vals[], float x2vals[], String ylbl, String x1lbl, String x2lbl) {
        xpos = 0.05 * w + xposition;
        ypos = 0.1 * h + yposition;
        spwidth = 0.9 * w;
        spheight = 0.9 * h;
        x1 = x1vals;
        x2 = x2vals;
        y1 = yvals;
        num_elements = yvals.length;
        ylabel = ylbl;
        x1label = x1lbl;
        x2label = x2lbl;
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

        diff = max(x2) - min(x2);
        diff = diff/10.0;
        x2scale = (int) Math.ceil(diff);
        x2min = (int) min(x2) - x2scale;
        x2max = (int) max(x2) + x2scale;

        ynumticks = (ymax - ymin) / yscale;
        x1numticks = (x1max - x1min) / x1scale;
        x2numticks = (x2max - x2min) / x2scale;
        tick_length = 0.01 * spwidth;
    }

    public void render() {
        pushStyle();
        fill(#f2f2f2);
        rectMode(CORNER);
        stroke(0, 0, 0);
        rect(xpos, ypos, spwidth, spheight);
        line(xpos + spwidth/2, ypos, xpos + spwidth/2, ypos + spheight);
        textAlign(CENTER);
        fill(0, 0, 0);
        text(x1label, xpos + spwidth/4, ypos - .05*spheight);
        text(x2label, xpos + 3*spwidth/4, ypos - .05*spheight);
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
            float tick_distance = spwidth/(2*x1numticks);
            line(xpos + (i * tick_distance), ypos + spheight, xpos + (i * tick_distance), ypos + spheight + tick_length);
            textAlign(CENTER, TOP);
            text(x1min + (i*x1scale), xpos + (i * tick_distance), ypos + spheight + tick_length);
        }
        for (int i = 1; i <= x2numticks; i++) {
            float tick_distance = spwidth/(2*x2numticks);
            line(xpos + spwidth/2 + (i * tick_distance), ypos + spheight, xpos + spwidth/2 + (i * tick_distance), ypos + spheight + tick_length);
            text(x2min + (i*x2scale), xpos + spwidth/2 + (i * tick_distance), ypos + spheight + tick_length);
        }
        popStyle();
        //first scatterplot
        for (int i = 0; i < num_elements; i++) {
            float yval = spheight * (y1[i] - ymin)/(ymax-ymin);
            float xval = spwidth/2 * (x1[i] - x1min)/(x1max-x1min);
            float P_x = xval + xpos;
            float P_y = ypos + spheight - yval;
            pushStyle();
            fill(0, 0, 0);
            noStroke();
            ellipseMode(CENTER);
            ellipse(P_x, P_y, pointSize, pointSize);
            popStyle();
        }
        //second scatterplot
        for (int i = 0; i < num_elements; i++) {
            float yval = spheight * (y1[i] - ymin)/(ymax-ymin);
            float xval = spwidth/2 * (x2[i] - x2min)/(x2max-x2min);
            float P_x = xval + spwidth/2 + xpos;
            float P_y = ypos + spheight - yval;
            pushStyle();
            fill(0, 0, 0);
            noStroke();
            ellipseMode(CENTER);
            ellipse(P_x, P_y, pointSize, pointSize);
            popStyle();
        }        
        
    }
}