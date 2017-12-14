public class CenteredBar {
    float xPos, yPos;
    float chartWidth, chartHeight;
    float chartXCenter;
    float chartYTop, chartYBot;
    String[] names;
    float[] values;
    int numElements;
    int numTicks;
    float tickLength;
    float barInterval; //dist between two bars
    float tickInterval; //dist between each tick
    int xScale; //incremental value between each tick
    int minValue, maxValue;
    String yLabel;
    float barWidth;
    color axesColor;
    color textColor;
    color barColor;

    CenteredBar(float posx, float posy, float wid, float hgt, String[] x, float[] y, String ylbl, color c) {
        xPos = posx + .3 * wid;
        yPos = posy + .2 * hgt;
        chartWidth = .6 * wid;
        chartHeight = .7 * hgt;
        chartXCenter = xPos + chartWidth/2.0;
        chartYTop = yPos;
        chartYBot = yPos + chartHeight;
        tickLength = 0.01 * chartHeight;
        names = x;
        values = y;
        numElements = names.length;
        float left, right;
        left = abs(min(y));
        right = max(y);
        float max = max(y);
        if (left > right) {
            max = left;
        }
        maxValue = (int) (max + (10 - max % 10));
        minValue = -1 * maxValue;
        barInterval = chartHeight/numElements;
        xScale = (maxValue - minValue) / 10;
        numTicks = (maxValue - minValue) / xScale;
        tickInterval = chartWidth/numTicks;
        yLabel = ylbl;
        barWidth = barInterval/2;
        axesColor = #000000;
        textColor = #000000;
        barColor = c;
    }

    public void render() {
        setup_graph();
        draw_bars();
    }

    public void setup_graph() {
        pushStyle();
        stroke(axesColor);
        fill(textColor);
        line(chartXCenter, chartYTop, chartXCenter, chartYBot);
        line(xPos, chartYBot, xPos + chartWidth, chartYBot);
        textAlign(CENTER, BOTTOM);
        text(yLabel, chartXCenter, chartYTop - 0.05 * chartHeight);
        for (int i = 0; i <= numTicks; i++) {
            line(xPos + i*tickInterval, chartYBot, xPos + i*tickInterval, chartYBot - tickLength);
            textAlign(CENTER, TOP);
            text(minValue + i*xScale, xPos + i*tickInterval+1, chartYBot + tickLength);
        }
        for (int i = 0; i < numElements; i++) {
            textAlign(RIGHT, TOP);
            text(names[i], xPos, chartYTop + i*barInterval);
        }
    }
    
    public void draw_bars() {
        for (int i = 0; i < numElements; i++) {
            float val = (chartWidth/2) * values[i]/10;
            rectMode(CORNERS);
            fill(barColor);
            rect(chartXCenter, chartYTop + i*barInterval, chartXCenter + val, chartYTop + i*barInterval + barWidth); 
        }
    }
}