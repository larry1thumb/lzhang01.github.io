Parser p;
BarGraph b;
Bar bar1;
Bar bar2;
LineGraph l;
NBA_Arc sc;
NBA_Arc other;

void setup() {
    size(1400, 800);
    background(#ffffff);
    surface.setResizable(true);
    p = new Parser("./15-16.csv");
    b = new BarGraph(700, 350, p.names, p.tpm, p.cashm, p.pum, p.headers);
    color c1 = #4682b4;
    color c2 = #1e90ff;
    bar1 = new Bar(700, 350, p.names, p.cashm, p.headers, c1);
    bar2 = new Bar(700, 350, p.names, p.pum, p.headers, c2);
    l = new LineGraph(width/2.0, 0.0, width/2.0, 350.0, p.months, p.steph, p.klay, p.damian, p.james, p.kyle, p.headers);
    l.select_all();
    sc = new NBA_Arc(0, height/2, width/2, height/2, p.atpp, p.atpm, p.atpa, p.totalpercent[0], "Stephen Curry");
}

void draw() {
    background(#ffffff);
    pushStyle();
    stroke(0, 0, 0);
    line(0, height/2, width, height/2);
    line(width/2, 0, width/2, height/2);
    popStyle();
    if (b.shottype == 0) {
        l.change_array(p.steph, p.klay, p.damian, p.james, p.kyle);
        b.render();
        b.highlight();
        b.choose_shot();
    } else if (b.shottype == 1) {
        l.change_array(p.acash, p.bcash, p.ccash, p.dcash, p.ecash);
        bar1.render();
        bar1.highlight();
        bar1.change_back();
        if (bar1.shottype == 1) {
            b.shottype = 0;
            bar1.shottype = 0;
        }
    } else if (b.shottype == 2) {
        l.change_array(p.apu, p.bpu, p.cpu, p.dpu, p.epu);
        bar2.render();
        bar2.highlight();
        bar2.change_back();
        if (bar2.shottype == 1) {
            b.shottype = 0;
            bar2.shottype = 0;
        }
    }
    sc.render();
    int player = 1;
    if (b.shottype == 0) {
        player = b.player;
    } else if (b.shottype == 1) {
        player = bar1.player;
    } else {
        player = bar2.player;
    }
    if (l.player != -1) {
        player = l.player;
    }
    if (player == 0) {
        other = new NBA_Arc(width/2, height/2, width/2, height/2, p.atpp, p.atpm, p.atpa, p.totalpercent[0], "Stephen Curry");
        l.choose_player(0);
    } else if (player == 1) {
        other = new NBA_Arc(width/2, height/2, width/2, height/2, p.btpp, p.btpm, p.btpa, p.totalpercent[1], "Klay Thompson");
        l.choose_player(1);
    } else if (player == 2) {
        other = new NBA_Arc(width/2, height/2, width/2, height/2, p.ctpp, p.ctpm, p.ctpa, p.totalpercent[2], "Damian Lillard");
        l.choose_player(2);
    } else if (player == 3) {
        other = new NBA_Arc(width/2, height/2, width/2, height/2, p.dtpp, p.dtpm, p.dtpa, p.totalpercent[3], "James Harden");
        l.choose_player(3);
    } else if (player == 4) {
        other = new NBA_Arc(width/2, height/2, width/2, height/2, p.etpp, p.etpm, p.etpa, p.totalpercent[4], "Kyle Lowry");
        l.choose_player(4);
    }
    l.render();
    l.select();
    other.render();
    other.highlight();
    sc.highlight();
}