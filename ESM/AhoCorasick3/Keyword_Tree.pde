public class Keyword_Tree {
    String w1 = "potato";
    String w2 = "tattoo";
    String w3 = "theater";
    String w4 = "other";    
    char[] word1;
    char[] word2;
    char[] word3;
    char[] word4;
    float distance = 9;
    float xPos = 0.4 * width;
    float yPos = 0.1 * height;
    float eSize = 5;
    int num_chars = 0;
    int wordnum = 0;
    int counter = 0;
    Keyword_Tree() {
        word1 = w1.toCharArray();
        word2 = w2.toCharArray();
        word3 = w3.toCharArray();
        word4 = w4.toCharArray();
    }

    void render() {
        textAlign(CENTER);
        fill(0, 0, 0);
        ellipse(xPos, yPos, eSize, eSize);
        int i = 0;
        int num = num_chars;
        while (num > 0 && i < word1.length) {
            if (num_chars < 7 && i == 0)
                text("Adding: " + w1, xPos, .9*height);
            pushStyle();
            counter++;
            if (counter == num_chars) {
                stroke(#0dd5fc);
                fill(#0dd5fc);
            }
            line(xPos, yPos, xPos - 40 - i*40, yPos + 40 + i*40);
            ellipse(xPos - i*40 - 40, yPos + i*40 + 40, eSize, eSize);
            text(word1[i], xPos - 30 - i*40, yPos + 10 + i*40);
            popStyle();
            i++;
            num--;
        }
        i = 0;
        while (num > 0 && i < word2.length) {
            if (num_chars < 12 && i == 0) 
                text("Adding: " + w2, xPos, .9*height);
            pushStyle();
            if (num_chars < 13 && num == 1) {
                stroke(#0dd5fc);
                fill(#0dd5fc);
            }
            line(xPos, yPos, xPos + i*5 + 5, yPos + i*50 + 50);
            ellipse(xPos + i*5 + 5, yPos + i*50 + 50, eSize, eSize);
            text(word2[i], xPos - 10 + i*5, yPos + 30 + i*50);
            popStyle();
            i++;
            num--;
        }
        float xPos3 = xPos + 5;
        float yPos3 = yPos + 50;
        i = 0; 
        while (num > 0 && i < word3.length) {
            if (num_chars < 19 && i == 0)
                text("Adding: " + w3, xPos, .9*height);
            pushStyle();
            if (num_chars < 20 && num == 1) {
                stroke(#0dd5fc);
                fill(#0dd5fc);
            }
            if (i == 0) {
                line(xPos, yPos, xPos + i*5 + 5, yPos + i*50 + 50);
                ellipse(xPos + i*5 + 5, yPos + i*50 + 50, eSize, eSize);
                text(word2[i], xPos - 10 + i*5, yPos + 30 + i*50);
            } else {
                line(xPos3, yPos3, xPos3 + (i-1)*40 + 40, yPos3 + (i-1)*40 + 40);
                ellipse(xPos3 + (i-1)*40 + 40, yPos3 + (i-1)*40 + 40, eSize, eSize);
                text(word3[i], xPos3 + 30 + (i-1)*40, yPos3 + 20 + (i-1)*40);
            }
            popStyle();
            i++;
            num--;
        }

        i = 0;
        while (num > 0 && i < word4.length) {
            if (num_chars < 24 && i == 0)
                text("Adding: " + w4, xPos, .9*height);
            pushStyle();
            if (num_chars < 25 && num == 1) {
                stroke(#0dd5fc);
                fill(#0dd5fc);
            }
            line(xPos, yPos, xPos + i*52 + 52, yPos + i*10 + 10);
            ellipse(xPos + i*52 + 52, yPos + i*10 + 10, eSize, eSize);
            text(word4[i], xPos + 30 + i*52, yPos + i*10);
            popStyle();
            i++;
            num--;
        }
    }
}