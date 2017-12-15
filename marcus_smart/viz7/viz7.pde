Parser p;
ScatterPlot s;

void setup() {
    size(600,600);
    p = new Parser("./viz7.csv");
    s = new ScatterPlot(0.05*width, 0, 0.95*width, height/1.5, p.creb, p.heights, p.names, "Contested Rebound %", "Height", "Weight", p.position);
}

void draw() {
    background(#f2f2f2);
    s.render();
    s.highlight();
}