Parser p;
LineChart l;
boolean hide = false;

void setup() {
    size(1000, 600);
    background(#f2f2f2);
    p = new Parser("./nba_shooting.csv");
    l = new LineChart(width, height, p.season, p.tpa, "3-Point Attempts per Game");
    l.render();
}

void draw() {
    background(#f2f2f2);
    button();
    l.render();
    l.highlight();
    if (hide == true) {
    l.shorten_tooltip();
    } else {
        l.show_tooltip();
    }
}

void button() {
    rectMode(CORNER);
    noFill();
    rect(0.86 * width, 0.02 * height, 0.12 * width, 0.04 * height);
    textAlign(LEFT, CENTER);
    text("Show/Hide Tooltip", 0.87 * width, 0.04 * height);
}

void mouseClicked() {
    float x1 = 0.86 * width;
    float x2 = x1 + 0.13 * width;
    float y1 = 0.02 * height;
    float y2 = y1 + 0.04 * height;
    if (mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2) {
        hide = !hide;
    }
}