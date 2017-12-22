public class Keyword_Tree {
  char[] word1;
  char[] word2;
  char[] word3;
  char[] word4;
  float distance = 9;
  float xPos = 0.4 * width;
  float yPos = 0.1 * height;
  float eSize = 5;
  Keyword_Tree() {
    String w1 = "potato";
    String w2 = "tattoo";
    String w3 = "theater";
    String w4 = "other";
    word1 = w1.toCharArray();
    word2 = w2.toCharArray();
    word3 = w3.toCharArray();
    word4 = w4.toCharArray();
  }

  void render() {
    textAlign(CENTER);
    text("Hover over nodes to see failure links", xPos, height*0.9);
    fill(0, 0, 0);
    ellipse(xPos, yPos, eSize, eSize);
    for (int i = 0; i <= word1.length; i++) {
      line(xPos, yPos, xPos - i*40, yPos + i*40);
      ellipse(xPos - i*40, yPos + i*40, eSize, eSize);
      if (i < word1.length) {
        text(word1[i], xPos - 30 - i*40, yPos + 10 + i*40);
      } else {
        text("1", xPos - i*40, yPos + 20 + i*40);
      }
    }
    for (int i = 0; i <= word2.length; i++) {
      line(xPos, yPos, xPos + i*5, yPos + i*50);
      ellipse(xPos + i*5, yPos + i*50, eSize, eSize);
      if (i < word2.length) {
        text(word2[i], xPos - 10 + i*5, yPos + 30 + i*50);
      } else {
        text("2", xPos + i*5, yPos + i*50 + 20);
      }
    }
    float xPos3 = xPos + 5;
    float yPos3 = yPos + 50;
    for (int i = 0; i <= word3.length-1; i++) {
      line(xPos3, yPos3, xPos3 + i*40, yPos3 + i*40);
      ellipse(xPos3 + i*40, yPos3 + i*40, eSize, eSize);
      if (i < word3.length-1) {
        text(word3[i+1], xPos3 + 30 + i*40, yPos3 + 20 + i*40);
      } else {
        text("3", xPos3 + i*40, yPos3 + i*40 + 20);
      }
    }
    for (int i = 0; i <= word4.length; i++) {
      line(xPos, yPos, xPos + i*52, yPos + i*10);
      ellipse(xPos + i*52, yPos + i*10, eSize, eSize);
      if (i < word4.length) {
        text(word4[i], xPos + 30 + i*52, yPos + i*10);
      } else {
        text("4", xPos + i*52, yPos + i*10 + 20);
      }
    }
  }

  void highlight() {
    noFill();
    float s = eSize;
    float x1 = xPos - eSize;
    float x2 = x1 + 2*eSize;
    float y1 = yPos - eSize;
    float y2 = y1 + 2*eSize;
    if (mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2) {
      bezier(xPos, yPos, xPos-100, 0, xPos+100, 0, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }
    x1 = xPos-40;
    y1 = yPos+40;

    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-120, 0, xPos+55, 0, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }
    x1 = xPos-80-eSize/2;
    x2 = x1 + eSize;
    y1 = yPos+80-eSize/2;
    y2 = y1 + eSize;

    if (mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2) {
      bezier(xPos-2*40, yPos+2*40, xPos-120, 0, xPos+75, 0, xPos+52, yPos+10);
      text("lp(v) = 1", xPos, 0.75*height);
    }
    x1 = xPos-3*40;
    y1 = yPos+3*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-120, 0, xPos+75, 0, xPos+2*52, yPos+2*10);
      text("lp(v) = 2", xPos, 0.75*height);
    }

    x1 = xPos-4*40;
    y1 = yPos+4*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      line(x1, y1, xPos+2*5, yPos+2*50);
      text("lp(v) = 2", xPos, 0.75*height);
    }

    x1 = xPos-5*40;
    y1 = yPos+5*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      line(x1, y1, xPos+3*5, yPos+3*50);
      text("lp(v) = 3", xPos, 0.75*height);
    }

    x1 = xPos-6*40;
    y1 = yPos+6*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-120, 0, xPos+75, 0, xPos+52, yPos+10);
      text("lp(v) = 1", xPos, 0.75*height);
    }

    x1 = xPos+1*5;
    y1 = yPos+1*50;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }

    x1 = xPos+2*5;
    y1 = yPos+2*50;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-50, yPos+75, xPos-50, yPos + 25, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }

    x1 = xPos+3*5;
    y1 = yPos+3*50;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-50, yPos+125, xPos-50, yPos + 75, xPos+1*5, yPos+1*50);
      text("lp(v) = 1", xPos, 0.75*height);
    }

    x1 = xPos+4*5;
    y1 = yPos+4*50;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-50, yPos+140, xPos-50, yPos + 80, xPos+1*5, yPos+1*50);
      text("lp(v) = 1", xPos, 0.75*height);
    }

    x1 = xPos+4*5;
    y1 = yPos+4*50;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos-50, yPos+140, xPos-50, yPos + 80, xPos+1*5, yPos+1*50);
      text("lp(v) = 1", xPos, 0.75*height);
    }

    x1 = xPos+5*5;
    y1 = yPos+5*50;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+150, yPos+200, xPos+150, yPos + 100, xPos+52, yPos+1*10);
      text("lp(v) = 1", xPos, 0.75*height);
    }

    x1 = xPos+6*5;
    y1 = yPos+6*50;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+150, yPos+225, xPos+150, yPos + 125, xPos+52, yPos+10);
      text("lp(v) = 1", xPos, 0.75*height);
    }

    x1 = xPos+5+40;
    y1 = yPos+50+40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+100, yPos+70, xPos+125, yPos + 60, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }

    x1 = xPos+5+2*40;
    y1 = yPos+50+2*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+100, yPos+70, xPos+125, yPos + 60, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }

    x1 = xPos+5+3*40;
    y1 = yPos+50+3*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+100, yPos+70, xPos+125, yPos + 60, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }

    x1 = xPos+5+4*40;
    y1 = yPos+50+4*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+200, yPos+150, xPos+225, yPos + 80, xPos+5, yPos+50);
      text("lp(v) = 1", xPos, 0.75*height);
    }
    
    x1 = xPos+5+5*40;
    y1 = yPos+50+5*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+180, yPos+70, xPos+200, yPos + 60, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }
    
    x1 = xPos+5+6*40;
    y1 = yPos+50+6*40;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, xPos+200, yPos+70, xPos+225, yPos + 60, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }
    
    x1 = xPos+1*52;
    y1 = yPos+1*10;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, x1-18, 0, x1-36, 0, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }
    
    x1 = xPos+2*52;
    y1 = yPos+2*10;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      line(x1, y1, xPos+5, yPos+50);
      text("lp(v) = 1", xPos, 0.75*height);
    }
    
    x1 = xPos+3*52;
    y1 = yPos+3*10;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      line(x1, y1, xPos+5+40, yPos+50+40);
      text("lp(v) = 2", xPos, 0.75*height);
    }
    
    x1 = xPos+4*52;
    y1 = yPos+4*10;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      line(x1, y1, xPos+5+2*40, yPos+50+2*40);
      text("lp(v) = 3", xPos, 0.75*height);
    }
    
    x1 = xPos+5*52;
    y1 = yPos+5*10;
    if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
      bezier(x1, y1, x1-125, 0, x1-250, 0, xPos, yPos);
      text("lp(v) = 0", xPos, 0.75*height);
    }
  }
}