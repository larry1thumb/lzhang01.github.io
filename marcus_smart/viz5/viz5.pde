BarGraph b;
Stacked s1, s2;
BarGraph b1, b2;
CenteredBar c1, c2;
Parser p;
Transitions t, t2;
TransSameType tst, tst2;
int mode;
boolean init;

void setup() {
    size(1200, 600);
    background(#f2f2f2);
    mode = 0;
    p = new Parser("./viz5.csv");
    s1 = new Stacked(width/2, height, p.names, p.fgm, p.fga, "Players", "Field Goals Made/Attempted");
    s2 = new Stacked(width/2, height, p.names, p.tpm, p.tpa, "Players", "3P Made/Attempted");
    b1 = new BarGraph(width/2, height, p.names, p.fg, "Field Goal %", color(#205093));
    b2 = new BarGraph(width/2, height, p.names, p.tp, "3 Point %", color(#205093));
    c1 = new CenteredBar(width/2, 0, width/2, height/2, p.names, p.ortg, "On-Off Offensive Rating", color(#205093));
    c2 = new CenteredBar(width/2, height/2, width/2, height/2, p.names, p.opportg, "On-Off Opponent Offensive Rating", color(#205093));
    t = new Transitions(s1, b1);
    t2 = new Transitions(s2, b2);
    tst = new TransSameType(s1, s2);
    tst2 = new TransSameType(b1, b2);
    init = true;
}

void draw() {
    background(#f2f2f2);
    if (mode == 0) {
        if (t.done == true || init == true || tst.done == true) {
            s1.render();
        } else {
            if (t.bs0 == true) {
                t.fadeout();
            } else if (t.bs1 == true) {
                t.fadein();
            } else if (t.bs2 == true) {
                t.add_misses();
            } else if (t.bs3 == true) {
                t.unnormalize();
            }
            if (tst.x == true) {
                tst.fadeout();
            } else if (tst.y == true) {
                tst.tofg();
            } else if (tst.z == true) {
                tst.fadein();
            }
        }
    } else if (mode == 1) {
        if (t2.done == true || tst.done == true) {
            s2.render();
        } else {
            if (t2.bs0 == true) {
                t2.fadeout();
            } else if (t2.bs1 == true) {
                t2.fadein();
            } else if (t2.bs2 == true) {
                t2.add_misses();
            } else if (t2.bs3 == true) {
                t2.unnormalize();
            }
            if (tst.a == true) {
                tst.fadeout();
            } else if (tst.b == true) {
                tst.to3();
            } else if (tst.c == true) {
                tst.fadein();
            }
        }
    } else if (mode == 2) {
        if (t.done == true || tst2.done == true) {
            b1.axes = #000000;
            b1.render();
        } else {
            if (t.sb0 == true) {
                t.fadeout();
            } else if (t.sb1 == true) {
                t.fadein();
            } else if (t.sb2 == true) {
                t.normalize();
            } else if (t.sb3 == true) {
                t.fade_misses();
            }
            if (tst2.x == true) {
                tst2.fadeout();
            } else if (tst2.y == true) {
                tst2.tofg();
            } else if (tst2.z == true) {
                tst2.fadein();
            }
        }
    } else if (mode == 3) {
        if (t2.done == true || tst2.done == true) {
            b2.axes = #000000;
            b2.render();
        } else {
            if (t2.sb0 == true) {
                t2.fadeout();
            } else if (t2.sb1 == true) {
                t2.fadein();
            } else if (t2.sb2 == true) {
                t2.normalize();
            } else if (t2.sb3 == true) {
                t2.fade_misses();
            }
            if (tst2.a == true) {
                tst2.fadeout();
            } else if (tst2.b == true) {
                tst2.to3b();
            } else if (tst2.c == true) {
                tst2.fadein();
            }
        }
    }
    pushStyle();
    stroke(0, 0, 0);
    rectMode(CORNER);
    noFill();
    rect(500, 25, 100, 120);
    fill(0, 0, 0);
    textAlign(LEFT);

    pushStyle();
    if (mode == 3) {
        fill(#696969);
        rect(500, 25, 100, 30);
    }
    popStyle();
    rect(510, 35, 6, 6);    
    text("FGM/FGA", 525, 42);


    pushStyle();
    if (mode == 2) {
        fill(#696969);
        rect(500, 55, 100, 30);
    }    
    popStyle();
    rect(510, 65, 6, 6);
    text("3PM/3PA", 525, 72);


    pushStyle();
    if (mode == 1) {
        fill(#696969);
        rect(500, 85, 100, 30);
    }
    popStyle();
    rect(510, 95, 6, 6);
    text("FG%", 525, 102);


    pushStyle();
    if (mode == 0) {
        fill(#696969);
        rect(500, 115, 100, 30);
    }
    popStyle();
    rect(510, 125, 6, 6);
    text("3P%", 525, 132);

    c1.render();
    c2.render();
}

void mouseClicked() {
    if (mouseX > 500 && mouseX < 600 && mouseY > 25 && mouseY < 55) {
        if (mode == 2) {
            t.bs0 = true;
            t.done = false;
            tst.done = false;
            mode = 0;
        } else if (mode == 1) {
            mode = 0;
            tst.x = true;
            t.done = false;
            tst.done = false;
        }
    } else if (mouseX > 500 && mouseX < 600 && mouseY > 55 && mouseY < 85) {
        if (mode == 3) {
            t2.bs0 = true;
            t2.done = false;
            tst.done = false;
            mode = 1;
        } else if (mode == 0) {
            mode = 1;
            tst.a = true;
            tst.done = false;
            t2.done = false;
            init = false;
        }
    } else if (mouseX > 500 && mouseX < 600 && mouseY > 85 && mouseY < 115) {
        if (mode == 0) {
            mode = 2;
            init = false;
            t.sb0 = true;
            t.done = false;
            tst2.done = false;
        }
        if (mode == 3) {
            mode = 2;
            t.done = false;
            tst2.done = false;
            tst2.x = true;
        }
    } else if (mouseX > 500 && mouseX < 600 && mouseY > 115 && mouseY < 145) {
        if (mode == 1) {
            mode = 3;
            t2.sb0 = true;
            t2.done = false;
            tst2.a = false;
            tst2.done = false;
        }
        if (mode == 2) {
            mode = 3;
            t.done = false;
            t2.done = false;
            tst2.done = false;
            tst2.a = true;
        }
    }
}