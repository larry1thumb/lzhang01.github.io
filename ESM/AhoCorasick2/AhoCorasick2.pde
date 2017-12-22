Keyword_Tree k;

void setup() {
    size(800,600);
    k = new Keyword_Tree();
}

void draw() {
    background(#f2f2f2);
    k.render();
    k.highlight();
}