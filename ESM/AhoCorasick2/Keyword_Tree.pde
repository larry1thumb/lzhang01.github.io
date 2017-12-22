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
        text("Hover over nodes to see how we find failure links", xPos, height*0.97);
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

        //root
        if (mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2) {
            bezier(xPos, yPos, xPos-100, 0, xPos+100, 0, xPos, yPos);
            text("Trivial: Links back to root", xPos, 0.75*height);
        }
        //1Potato
        x1 = xPos-40;
        y1 = yPos+40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            bezier(x1, y1, xPos-120, 0, xPos+55, 0, xPos, yPos);
            text("Trivial: Links back to root", xPos, 0.75*height);
        }

        //1pOtato
        x1 = xPos-80-eSize/2;
        x2 = x1 + eSize;
        y1 = yPos+80-eSize/2;
        y2 = y1 + eSize;
        if (mouseX > x1 && mouseX < x2 && mouseY > y1 && mouseY < y2) {
            strokeWeight(4);
            bezier(xPos-2*40, yPos+2*40, xPos-120, -25, xPos+75, -25, xPos+52, yPos+10);
            strokeWeight(1);
            bezier(xPos-40, yPos+40, xPos-80, 0, xPos, 0, xPos, yPos);
            bezier(xPos, yPos, xPos+25, 0, xPos+50, 25, xPos+52, yPos+10);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 'o'", xPos, 0.75*height+40);
        }

        //1poTato
        x1 = xPos-3*40;
        y1 = yPos+3*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos-120, -25, xPos+75, -25, xPos+2*52, yPos+2*10);
            strokeWeight(1);
            bezier(xPos-2*40, yPos+2*40, xPos-120, 0, xPos+75, 0, xPos+52, yPos+10);
            bezier(xPos+52, yPos+10, xPos+70, 30, xPos+80, 30, xPos+2*52, yPos+2*10);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 't'", xPos, 0.75*height+40);
        }

        //1potAto
        x1 = xPos-4*40;
        y1 = yPos+4*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            line(x1, y1, xPos+2*5, yPos+2*50);
            strokeWeight(1);
            bezier(x1+40, y1-40, xPos-120, -25, xPos+75, -25, xPos+2*52, yPos+2*10);
            line(xPos+2*52, yPos+2*10, xPos+5, yPos+50);
            bezier(xPos+5, yPos+50, xPos-20, yPos + 65, xPos-20, yPos+85, xPos+10, yPos+100);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'a', continue on to n(n(v'))", xPos, 0.75*height+40);
            text("Check outgoing edges and we find a match with 'a'", xPos, 0.75*height+60);
        }

        //1potaTo
        x1 = xPos-5*40;
        y1 = yPos+5*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            line(x1, y1, xPos+3*5, yPos+3*50);
            strokeWeight(1);
            line(x1+40, y1-40, xPos+2*5, yPos+2*50);
            bezier(xPos+2*5, yPos+2*50, xPos-20, yPos + 115, xPos-20, yPos+135, xPos+3*5, yPos+3*50);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 't'", xPos, 0.75*height+40);
        }

        //1potatO
        x1 = xPos-6*40;
        y1 = yPos+6*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos-120, 0, xPos+75, 0, xPos+52, yPos+10);
            strokeWeight(1);
            line(x1+40, y1-40, xPos+3*5, yPos+3*50);
            bezier(xPos+3*5, yPos+3*50, xPos-50, yPos+125, xPos-50, yPos+75, xPos+5, yPos+50);
            bezier(xPos+5, yPos+50, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);
            bezier(xPos+52, yPos+10, xPos+35, 25, xPos+15, 25, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'o', continue on to n(n(v'))", xPos, 0.75*height+40);
            text("Check outgoing edges and still no match with 'o'", xPos, 0.75*height+60);
            text("Continue on to n(n(n(v'))), match found with 'o'", xPos, 0.75*height+80);
        }

        //2Tattoo
        x1 = xPos+1*5;
        y1 = yPos+1*50;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            bezier(x1, y1, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);            
            text("Trivial: Links back to root", xPos, 0.75*height);
        }

        //2tAttoo
        x1 = xPos+2*5;
        y1 = yPos+2*50;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos-50, yPos+75, xPos-50, yPos + 25, xPos, yPos);
            strokeWeight(1);
            bezier(x1-5, y1-50, xPos+50, yPos+35, xPos+50, yPos + 15, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'a'", xPos, 0.75*height+40);
            text("n(v') is root, failure link to root.", xPos, 0.75*height+60);
        }

        //2taTtoo
        x1 = xPos+3*5;
        y1 = yPos+3*50;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos-50, yPos+125, xPos-50, yPos + 75, xPos+1*5, yPos+1*50);
            strokeWeight(1);
            bezier(x1-5, y1-50, xPos+50, yPos+75, xPos+50, yPos + 25, xPos, yPos);
            bezier(x1-10, y1-100, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);   
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 't'", xPos, 0.75*height+40);
        }

        //2tatToo
        x1 = xPos+4*5;
        y1 = yPos+4*50;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos-50, yPos+140, xPos-50, yPos + 80, xPos+1*5, yPos+1*50);
            strokeWeight(1);
            bezier(x1-5, y1-50, xPos+50, yPos+125, xPos+50, yPos + 75, xPos+1*5, yPos+1*50);
            bezier(xPos+5, yPos+50, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);    
            bezier(xPos+5, yPos+50, xPos+50, yPos+35, xPos+50, yPos + 15, xPos, yPos);    
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 't', continue on to n(n(v'))", xPos, 0.75*height+40);
            text("Check outgoing edges and we find a match with 't'", xPos, 0.75*height+60);
        }

        //2tattOo
        x1 = xPos+5*5;
        y1 = yPos+5*50;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+150, yPos+200, xPos+150, yPos + 100, xPos+52, yPos+1*10);
            strokeWeight(1);
            bezier(x1-5, y1-50, xPos-50, yPos+140, xPos-50, yPos + 80, xPos+1*5, yPos+1*50);
            bezier(xPos+5, yPos+50, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);
            bezier(xPos+52, yPos+10, xPos+35, 25, xPos+15, 25, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'o', continue on to n(n(v'))", xPos, 0.75*height+40);
            text("Check outgoing edges and we find a match with 'o'", xPos, 0.75*height+60);
        }

        //2tattoO
        x1 = xPos+6*5;
        y1 = yPos+6*50;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+150, yPos+225, xPos+150, yPos + 125, xPos+52, yPos+10);
            strokeWeight(1);
            bezier(x1-5, y1-50, xPos-100, yPos+200, xPos-100, yPos + 100, xPos+52, yPos+1*10);
            bezier(xPos+52, yPos+10, xPos+35, yPos+40, xPos+15, yPos+50, xPos, yPos);
            bezier(xPos+52, yPos+10, xPos+35, 25, xPos+15, 25, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'o', continue on to n(n(v'))", xPos, 0.75*height+40);
            text("Check outgoing edges and we find a match with 'o'", xPos, 0.75*height+60);
        }

        //3tHeater
        x1 = xPos+5+40;
        y1 = yPos+50+40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+100, yPos+70, xPos+125, yPos + 60, xPos, yPos);
            strokeWeight(1);
            bezier(xPos+5, yPos+50, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);   
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'h'", xPos, 0.75*height+40);
            text("n(v') is root, failure link to root.", xPos, 0.75*height+60);
        }

        //3thEater
        x1 = xPos+5+2*40;
        y1 = yPos+50+2*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+100, yPos+70, xPos+125, yPos + 60, xPos, yPos);
            strokeWeight(1);
            bezier(x1-40, y1-40, xPos+40, yPos+70, xPos+50, yPos + 60, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'e'", xPos, 0.75*height+40);
            text("n(v') is root, failure link to root.", xPos, 0.75*height+60);
        }

        //3theAter
        x1 = xPos+5+3*40;
        y1 = yPos+50+3*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+150, yPos+80, xPos+175, yPos + 60, xPos, yPos);
            strokeWeight(1);
            bezier(x1-40, y1-40, xPos+75, yPos+70, xPos+100, yPos + 60, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'a'", xPos, 0.75*height+40);
            text("n(v') is root, failure link to root.", xPos, 0.75*height+60);
        }

        //3theaTer
        x1 = xPos+5+4*40;
        y1 = yPos+50+4*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+200, yPos+150, xPos+225, yPos + 80, xPos+5, yPos+50);
            strokeWeight(1);
            bezier(x1-40, y1-40, xPos+150, yPos+80, xPos+175, yPos + 60, xPos, yPos);
            bezier(xPos+5, yPos+50, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 't'", xPos, 0.75*height+40);
        }


        //3theatEr
        x1 = xPos+5+5*40;
        y1 = yPos+50+5*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+180, yPos+70, xPos+200, yPos + 60, xPos, yPos);
            strokeWeight(1);
            bezier(x1-40, y1-40, xPos+150, yPos+150, xPos+175, yPos + 80, xPos+5, yPos+50);
            bezier(xPos+5, yPos+50, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'e', continue on to n(n(v'))", xPos, 0.75*height+40);
            text("No match found with 'e', n(n(v')) is root, failure link to root", xPos, 0.75*height+60);
        }

        //3theateR
        x1 = xPos+5+6*40;
        y1 = yPos+50+6*40;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, xPos+250, yPos+70, xPos+250, yPos + 60, xPos, yPos);
            strokeWeight(1);
            bezier(x1-40, y1-40, xPos+180, yPos+60, xPos+200, yPos + 60, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'r'", xPos, 0.75*height+40);
            text("n(v') is root, failure link to root.", xPos, 0.75*height+60);
        }

        //4Other
        x1 = xPos+1*52;
        y1 = yPos+1*10;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            bezier(x1, y1, x1-18, 0, x1-36, 0, xPos, yPos);
            text("Trivial: Links back to root", xPos, 0.75*height);
        }

        //4oTher
        x1 = xPos+2*52;
        y1 = yPos+2*10;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            line(x1, y1, xPos+5, yPos+50);
            strokeWeight(1);
            bezier(x1-52, y1-10, xPos+35, 0, xPos+15, 0, xPos, yPos);
            bezier(xPos+5, yPos+50, xPos-50, yPos+35, xPos-50, yPos + 15, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 't'", xPos, 0.75*height+40);
        }

        //4otHer
        x1 = xPos+3*52;
        y1 = yPos+3*10;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            line(x1, y1, xPos+5+40, yPos+50+40);
            strokeWeight(1);
            line(x1-52, y1-10, xPos+5, yPos+50);
            bezier(xPos+5, yPos+50, xPos+58, yPos+40, xPos+71, yPos+60, xPos+5+40, yPos+50+40);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 'h'", xPos, 0.75*height+40);
        }

        //4othEr
        x1 = xPos+4*52;
        y1 = yPos+4*10;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            line(x1, y1, xPos+5+2*40, yPos+50+2*40);
            strokeWeight(1);
            line(x1-52, y1-10, xPos+5+40, yPos+50+40);
            bezier(xPos+5+40, yPos+50+40, xPos+80, yPos+70, xPos+100, yPos+90, xPos+5+2*40, yPos+50+2*40);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("Found match with 'e'", xPos, 0.75*height+40);
        }

        //4otheR
        x1 = xPos+5*52;
        y1 = yPos+5*10;
        if (mouseX > x1-s && mouseX < x1+s && mouseY > y1-s && mouseY < y1+s) {
            strokeWeight(4);
            bezier(x1, y1, x1, 0, x1-250, 0, xPos, yPos);
            strokeWeight(1);
            line(x1-52, y1-10, xPos+5+2*40, yPos+50+2*40);
            bezier(xPos+5+2*40, yPos+50+2*40, xPos+100, yPos+70, xPos+125, yPos + 60, xPos, yPos);
            text("Start at parent node v'", xPos, 0.75*height);
            text("Follow failure link to n(v') and check outgoing edges", xPos, 0.75*height+20);
            text("No match found with 'r', continue on to n(n(v'))", xPos, 0.75*height+40);
            text("No match found with 'r', n(n(v')) is root, failure link to root", xPos, 0.75*height+60);
        }
    }
}