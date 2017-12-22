Keyword_Tree k;

void setup() {
    size(800,600);
    k = new Keyword_Tree();
}

void draw() {
    background(#f2f2f2);
    k.num_chars++;
    k.counter = 0;
    if (k.num_chars > 24) {
        k.num_chars = 0;
    }
    k.render();
    delay(750);
}