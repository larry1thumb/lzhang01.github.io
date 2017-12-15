public class NBA_Arc {
    float pos_x, pos_y;
    float chart_width, chart_height;
    String player;
    float left;
    float top;
    float lc_y, rc_x, rc_y;
    float corner_width, corner_height;
    float rw_x;
    float wing_width, wing_height;
    float center_x;
    float center_width, center_height;
    float arc_x, arc_y;
    float percents[];
    String makes[];
    String attempts[];
    String lc, lw, c, rw, rc;
    String perc;

    NBA_Arc(float px, float py, float wid, float hgt, float tpp[], String tpm[], String tpa[], String total_percent, String name) {
        pos_x = px;
        pos_y = py;
        chart_width = wid;
        chart_height = hgt;
        player = name;
        perc = total_percent;
        left = pos_x;
        top = pos_y;
        lc_y = 0.67*chart_height + pos_y;
        rc_x = 0.9*chart_width + pos_x;
        rc_y = 0.67*chart_height + pos_y;
        corner_width = 0.1*chart_width;
        corner_height = 0.33*chart_height;
        rw_x = 0.67 * chart_width + pos_x;
        wing_width = 0.33 * chart_width;
        wing_height = 0.67 * chart_height;
        center_x = 0.33 * chart_width + pos_x;
        center_width = 0.34 * chart_width;
        center_height = 0.33 * chart_height;
        arc_x = chart_width/2 + pos_x;
        arc_y = pos_y + chart_height + 292;
        percents = tpp;
        makes = tpm;
        attempts = tpa;
        lc = makes[0] + "/" + attempts[0];
        lw = makes[1] + "/" + attempts[1];
        c = makes[2] + "/" + attempts[2];
        rw = makes[3] + "/" + attempts[3];
        rc = makes[4] + "/" + attempts[4];
    }

    public void render() {
        pushStyle();
        rectMode(CORNER);
        stroke(0, 0, 0);
        noFill();
        fill(percent_to_color(percents[0]));
        rect(left, lc_y, corner_width, corner_height);
        fill(percent_to_color(percents[4]));
        rect(rc_x, rc_y, corner_width, corner_height);
        fill(percent_to_color(percents[1]));
        rect(left, top, wing_width, wing_height);
        fill(percent_to_color(percents[3]));
        rect(rw_x, top, wing_width, wing_height);
        fill(percent_to_color(percents[2]));
        rect(center_x, top, center_width, center_height);
        fill(255, 255, 255);
        arc(arc_x, arc_y, 790, 1200, PI + PI/4, TWO_PI - PI/4);
        fill(0, 0, 0);
        textAlign(CENTER, CENTER);
        text(player, arc_x, pos_y + chart_height/1.5);
        text(perc, arc_x, pos_y + chart_height/1.5 + 10);
        text(String.format("%.1f", percents[0]) + "%", pos_x + 0.05 * chart_width, pos_y + 0.80 * chart_height);
        text(lc, pos_x + 0.05 * chart_width, pos_y + 0.84 * chart_height);
        text(String.format("%.1f", percents[1]) + "%", pos_x + 0.16 * chart_width, pos_y + 0.25 * chart_height);
        text(lw, pos_x + 0.16 * chart_width, pos_y + 0.29 * chart_height);
        text(String.format("%.1f", percents[2]) + "%", pos_x + 0.5 * chart_width, pos_y + 0.10 * chart_height);
        text(c, pos_x + 0.5 * chart_width, pos_y + 0.14 * chart_height);
        text(String.format("%.1f", percents[3]) + "%", pos_x + 0.84 * chart_width, pos_y + 0.25 * chart_height);
        text(rw, pos_x + 0.84 * chart_width, pos_y + 0.29 * chart_height);
        text(String.format("%.1f", percents[4]) + "%", pos_x + 0.95 * chart_width, pos_y + 0.80 * chart_height);
        text(rc, pos_x + 0.95 * chart_width, pos_y + 0.84 * chart_height);
        popStyle();
    }

    color percent_to_color(float perc) {
        if (perc < 30.0) {
            return color(#0091FF);
        } else if (perc < 35.0) {
            return color(#39C5F3);
        } else if (perc < 40) {
            return color(#FDEF6D);
        } else if (perc < 45) {
            return color(#FF9100);
        } else if (perc < 50) {
            return color(#FFBF00);
        } else {
            return color(#FF4800);
        }
    }

    void highlight() {
        pushStyle();
        rectMode(CORNER);

        if (mouseX > left && mouseX < pos_x + corner_width && mouseY < lc_y + corner_height && mouseY > lc_y) {
            fill(212, 115, 19);
            rect(left, lc_y, corner_width, corner_height);
            fill(0, 0, 0);
            textAlign(CENTER, CENTER);        
            text(nfc(percents[0], 1) + "%", pos_x + 0.05 * chart_width, pos_y + 0.80 * chart_height);
            text(lc, pos_x + 0.05 * chart_width, pos_y + 0.84 * chart_height);
        } else if (mouseX > left && mouseX < pos_x + wing_width && mouseY < wing_height + pos_y && mouseY > top) {
            fill(212, 115, 19);
            rect(left, top, wing_width, wing_height);
            fill(0, 0, 0);
            textAlign(CENTER, CENTER);
            text(nfc(percents[1], 1) + "%", pos_x + 0.16 * chart_width, pos_y + 0.25 * chart_height);
            text(lw, pos_x + 0.16 * chart_width, pos_y + 0.29 * chart_height);
        } else if (mouseX > center_x && mouseX < center_x + center_width && mouseY < center_height + pos_y && mouseY > top) {
            fill(212, 115, 19);
            rect(center_x, top, center_width, center_height);
            fill(0, 0, 0);
            textAlign(CENTER, CENTER);
            text(nfc(percents[2], 1) + "%", pos_x + 0.5 * chart_width, pos_y + 0.10 * chart_height);
            text(c, pos_x + 0.5 * chart_width, pos_y + 0.14 * chart_height);
        } else if (mouseX > rw_x && mouseX < rw_x + wing_width && mouseY < wing_height + pos_y && mouseY > top) {
            fill(212, 115, 19);
            rect(rw_x, top, wing_width, wing_height);
            fill(0, 0, 0);
            textAlign(CENTER, CENTER);
            text(nfc(percents[3], 1) + "%", pos_x + 0.84 * chart_width, pos_y + 0.25 * chart_height);
            text(rw, pos_x + 0.84 * chart_width, pos_y + 0.29 * chart_height);
        } else if (mouseX > rc_x && mouseX < rc_x + corner_width && mouseY < rc_y + corner_height && mouseY > rc_y) {
            fill(212, 115, 19);
            rect(rc_x, rc_y, corner_width, corner_height);
            fill(0, 0, 0);
            textAlign(CENTER, CENTER);
            text(nfc(percents[4], 1) + "%", pos_x + 0.95 * chart_width, pos_y + 0.80 * chart_height);
            text(rc, pos_x + 0.95 * chart_width, pos_y + 0.84 * chart_height);
        }

        fill(255, 255, 255);
        arc(arc_x, arc_y, 790, 1200, PI + PI/4, TWO_PI - PI/4);
        fill(0, 0, 0);
        textAlign(CENTER, CENTER);
        text(player, arc_x, pos_y + chart_height/1.5);
        text("Total 3P%: " + perc, arc_x, pos_y + chart_height/1.5 + 15);
        popStyle();
    }
}