Keyword_Tree k;

void setup() {
    size(800,600);
    k = new Keyword_Tree();
}

void draw() {
    background(#f2f2f2);
    noFill();
    rect(0.9*width, 0.01*height, 0.09*width, 0.09*height);
    text("Next", 0.9*width+0.045*width, 0.01*height+0.045*height);
    k.counter = 0;
    if (k.num_chars > 24) {
        k.num_chars = 0;
    }
    k.render();
}

void mouseClicked() {
    if (mouseX > 0.9 * width && mouseX < 0.9*width + 0.09*width && mouseY > 0.01*height && mouseY < 0.01*height+0.09*height) {
        k.num_chars++;
    }
}