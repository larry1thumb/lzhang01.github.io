Parser p;
LineChart l;

void setup() {
    size(1000,600);
    background(#f2f2f2);
    p = new Parser("./nba_shooting.csv");
    l = new LineChart(width, height, p.season, p.tpa, "3-Point Attempts per Game");
}

void draw() {
    background(#f2f2f2);
    l.render();
    l.highlight();
    l.shorten_tooltip();
}