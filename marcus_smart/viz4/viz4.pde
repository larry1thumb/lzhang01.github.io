BarGraph worst;
ScatterPlot sp;
Parser p;
highlight h;
color c1, c2;
int toggle;
void setup() {
    size(1200, 600);
    background(#f2f2f2);
    p = new Parser("./viz4.csv");
    worst = new BarGraph (width/2, height, p.names, p.fg, "Field Goal %", #B01D1D);
    sp = new ScatterPlot(width/2, 0, width/2, height/2, p.fg, p.ortg, p.pm, "FG%", "On-Off Offensive Rating", "+/-"); 
    h = new highlight(worst, sp);
    c1 = color(#f2f2f2);
    c2 = c1;
    toggle = -1;
}

void draw() {
    background(#f2f2f2);
    worst.render();
    sp.render();
    h.interact();
    pushStyle();
    textAlign(LEFT, TOP);
    rectMode(CORNER);
    fill(c1);
    rect(width/2, height*3/4, 90, 15);
    fill(0, 0, 0);
    text("On-Off ORtg", width/2 + 10, 1+height*3/4);
    fill(c2);
    rect(width/2 + 103, height*3/4, 35, 15);
    fill(0, 0, 0);
    text("+/-", width/2 + 110, 1+height*3/4);
    popStyle();
    //popup();
    textAlign(LEFT);
    if (toggle == 0) {
        text("On-Off Offensive Rating is the difference between the player's teams offensive rating when", width/2, height*3/4 + 35);
        text("he is on vs when is off the court.  Offensive Rating is defined by the number of points", width/2, height*3/4 + 55);
        text("a team scores in 100 possessions.  This metric shows how a player negatively or positively", width/2, height*3/4 + 75);
        text("affects a team's offensive efficiency", width/2, height*3/4 + 95);
    } else if (toggle == 1) {
        text("+/- represents the difference between their team's total scoring vs. their opponent's", width/2, height*3/4 + 35);
        text("whent he player is in the game. It is used to measure a player's impact on the game.", width/2, height*3/4 + 55);
    }
}

void mouseClicked() {
    if (mouseX > width/2 && mouseX < width/2 + 90 && mouseY > height*3/4 && mouseY < height*3/4 + 15) {
        if (toggle == 0) {
            toggle = -1;
            c1 = c2;
            return;
        }
        c1 = color(#a0e1ff);
        c2 = color(#f2f2f2);
        toggle = 0;
    } else if (mouseX > width/2 + 103 && mouseX < width/2 + 138 && mouseY > height*3/4 && mouseY < height*3/4 + 15) {
        if (toggle == 1) {
            toggle = -1;
            c2 = c1;
            return;
        }
        c1 = color(#f2f2f2);
        c2 = color(#a0e1ff);
        toggle = 1;
    }
}
void popup() {
    if (mousePressed && mouseX > width/2 && mouseX < width/2 + 90 && mouseY > height*3/4 && mouseY < height*3/4 + 15) {
        if (toggle == 0) {
            toggle = -1;
            c1 = c2;
            return;
        }
        c1 = color(#a0e1ff);
        c2 = color(#f2f2f2);
        toggle = 0;
    } else if (mousePressed && mouseX > width/2 + 103 && mouseX < width/2 + 138 && mouseY > height*3/4 && mouseY < height*3/4 + 15) {
        if (toggle == 1) {
            toggle = -1;
            c2 = c1;
            return;
        }
        c1 = color(#f2f2f2);
        c2 = color(#a0e1ff);
        toggle = 1;
    }
}