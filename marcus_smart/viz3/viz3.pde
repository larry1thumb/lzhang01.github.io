Parser p1;
BarGraph bad;
int bad_stat = 0;
color c = color(#003399);

void setup() {
    size(800, 600);
    background(#ffffff);
    p1 = new Parser("./viz3.csv");
    bad = new BarGraph(800, 600, p1.names, p1.ppg, "Points Per Game", c);
}

void draw() {
    background(#f2f2f2);
    bad.render();
    bad.highlight();
    change();
    if (bad_stat == 0) {
        bad = new BarGraph(800, 600, p1.names, p1.ppg, "Points Per Game", c);
    } else if (bad_stat == 1) {
        bad = new BarGraph(800, 600, p1.names, p1.rpg, "Rebounds Per Game", c);
    } else if (bad_stat == 2) {
        bad = new BarGraph(800, 600, p1.names, p1.apg, "Assists Per Game", c);
    } else if (bad_stat == 3) {
        bad = new BarGraph(800, 600, p1.names, p1.fg, "Field Goal Percentage", c);
        stroke(#000000);
        for (float dashValue = bad.x1; dashValue < bad.x2; dashValue = dashValue + 20) {
            line(dashValue, bad.y2 - (bad.ylength * 45.5/bad.max_value), dashValue+10, bad.y2 - (bad.ylength * 45.5/bad.max_value));
        }
    } else if (bad_stat == 4) {
        bad = new BarGraph(800, 600, p1.names, p1.tp, "3 Point Percentage", c);
        stroke(#000000);
        for (float dashValue = bad.x1; dashValue < bad.x2; dashValue = dashValue + 20) {
            line(dashValue, bad.y2 - (bad.ylength * 36.0/bad.max_value), dashValue+10, bad.y2 - (bad.ylength * 36.0/bad.max_value));
        }
    } else if (bad_stat == 5) {
        bad = new BarGraph(800, 600, p1.names, p1.pie, "Player Impact Estimate", c);
        stroke(#000000);
        for (float dashValue = bad.x1; dashValue < bad.x2; dashValue = dashValue + 20) {
            line(dashValue, bad.y2 - (bad.ylength * 10.0/bad.max_value), dashValue+10, bad.y2 - (bad.ylength * 10.0/bad.max_value));
        }
        pushStyle();
        noFill();
        stroke(#000000);
        textAlign(LEFT);
        rectMode(CORNER);
        rect(bad.x2, bad.y1 + 165, 0.15*bad.xlength, 20);
        text("What is PIE?", bad.x2+bad.tick_length, bad.y1 + 180);
        popStyle();
    } else if (bad_stat == 6) {
        bad = new BarGraph(800, 600, p1.names, p1.per, "Player Efficiency Rating", c);
        stroke(#000000);
        for (float dashValue = bad.x1; dashValue < bad.x2; dashValue = dashValue + 20) {
            line(dashValue, bad.y2 - (bad.ylength * 15.0/bad.max_value), dashValue+10, bad.y2 - (bad.ylength * 15.0/bad.max_value));
        }
        pushStyle();
        noFill();
        stroke(#000000);
        textAlign(LEFT);
        rectMode(CORNER);
        rect(bad.x2, bad.y1 + 165, 0.15*bad.xlength, 20);
        text("What is PER?", bad.x2+bad.tick_length, bad.y1 + 180);
        popStyle();
    }
    helper();
}

void change() {
    if (mousePressed && mouseX < bad.x2 + 0.25*bad.xlength && mouseX > bad.x2) {
        if (mouseY > bad.y1 && mouseY < bad.y1 + 20) {
            bad_stat = 0;
        } else if (mouseY > bad.y1 + 20 && mouseY < bad.y1 + 40) {
            bad_stat = 1;
        } else if (mouseY > bad.y1 + 40 && mouseY < bad.y1 + 60) {
            bad_stat = 2;
        } else if (mouseY > bad.y1 + 60 && mouseY < bad.y1 + 80) {
            bad_stat = 3;
        } else if (mouseY > bad.y1 + 80 && mouseY < bad.y1 + 100) {
            bad_stat = 4;
        } else if (mouseY > bad.y1 + 100 && mouseY < bad.y1 + 120) {
            bad_stat = 5;
        } else if (mouseY > bad.y1 + 120 && mouseY < bad.y1 + 140) {
            bad_stat = 6;
        }
    }
}

void helper() {
    if (bad_stat == 5 || bad_stat == 6) {
        if (mousePressed && mouseX < bad.x2 + 0.15*bad.xlength && mouseX > bad.x2 && mouseY < bad.y1 + 185 && mouseY > bad.y1 + 165) {
            pushStyle();
            fill(#cccccc);
            stroke(#000000);
            rectMode(CORNER);
            rect(bad.x2 - 0.75*bad.xlength, bad.y1 + 165, 0.7*bad.xlength, 100);
            fill(#000000);
            textAlign(LEFT);
            if (bad_stat == 5) {
                fill(#cccccc);
                stroke(#000000);
                rectMode(CORNER);
                rect(bad.x2 - 0.75*bad.xlength, bad.y1 + 165, 0.7*bad.xlength, 100);
                fill(#000000);
                textAlign(LEFT);
                text("Player Impact Estimate is a metric that shows what percent of", bad.x2 - 0.74*bad.xlength, bad.y1 + 180);
                text("game events a player achieves. An average player will acheive", bad.x2 - 0.74*bad.xlength, bad.y1 + 200);
                text("about 10% of game events. The NBA uses PIE as a tool to", bad.x2 - 0.74*bad.xlength, bad.y1 + 220);
                text("measure performance", bad.x2 - 0.74*bad.xlength, bad.y1 + 240);
            } else {
                fill(#cccccc);
                stroke(#000000);
                rectMode(CORNER);
                rect(bad.x2 - 0.75*bad.xlength, bad.y1 + 165, 0.7*bad.xlength, 100);
                fill(#000000);
                textAlign(LEFT);
                text("Player Efficiency Rating is a per-minute rating that sums", bad.x2 - 0.74*bad.xlength, bad.y1 + 180);
                text("up all a player's positive accomplishments and subtracts", bad.x2 - 0.74*bad.xlength, bad.y1 + 200);
                text("negative accomplishments. It is used to summarize a", bad.x2 - 0.74*bad.xlength, bad.y1 + 220);
                text("players statistical accomplishments in one number.", bad.x2 - 0.74*bad.xlength, bad.y1 + 240);
                /*
                text("PER reference:", bad.x2 - 0.74*bad.xlength, bad.y1 + 260);
                text("MVP Candidate: 25+", bad.x2 - 0.74*bad.xlength, bad.y1 + 280);
                text("NBA Allstar: 20-25+", bad.x2 - 0.74*bad.xlength, bad.y1 + 300);
                text("Strong Player: 17-20", bad.x2 - 0.74*bad.xlength, bad.y1 + 320);
                text("Average Player: 13-17", bad.x2 - 0.74*bad.xlength, bad.y1 + 340);
                text("Below Average Player: 13-17", bad.x2 - 0.74*bad.xlength, bad.y1 + 360);
                text("Fringe roster player: 9-11", bad.x2 - 0.74*bad.xlength, bad.y1 + 380);
                text("Player won't stick in the league: 0-9", bad.x2 - 0.74*bad.xlength, bad.y1 + 400);
                */
            }

            popStyle();
        }
    }
    if (bad_stat == 6) {
        textAlign(LEFT);
        text("PER reference:", bad.x2, bad.y1 + 260);
        text("MVP Candidate: 25+", bad.x2, bad.y1 + 280);
        text("NBA Allstar: 20-25", bad.x2, bad.y1 + 300);
        text("Strong Player: 17-20", bad.x2, bad.y1 + 320);
        text("Average: 13-17", bad.x2, bad.y1 + 340);
        text("Below Average: 13-17", bad.x2, bad.y1 + 360);
        text("Fringe Player: 9-11", bad.x2, bad.y1 + 380);
        text("Unsigned: 0-9", bad.x2, bad.y1 + 400);
    }
}