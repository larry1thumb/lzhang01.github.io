Parser p;
LineChart l;
void setup() {
    size(1000, 600);
    background(#f2f2f2);
    p = new Parser("./viz2.csv");
    l = new LineChart(width, height, p.season, p.tpp, "3-Pointers Attempted per Game");
}

void draw() {
    background(#f2f2f2);
    l.render();
    l.highlight();
    l.shorten_tooltip();
}