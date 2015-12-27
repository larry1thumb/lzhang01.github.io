// Pressing Control-R will render this sketch.

int i = 0; 

void setup() {  // this is run once.   
    
    // set the background color
    background(255);
    
    // canvas size (Integers only, please.)
    size(300, 300); 
      
    // smooth edges
    smooth();
} 

static final int SCREEN_SIZE = 800;
ArrayList vertices = new ArrayList();
ArrayList upperHull = new ArrayList();
ArrayList temp = new ArrayList();
ArrayList temp2 = new ArrayList();
ArrayList lowerHull = new ArrayList();
ArrayList lines = new ArrayList();
ArrayList ConvexHull = new ArrayList();
float medianX = 0;
PVector pmin = new PVector();
PVector pmax = new PVector();
float medianSlope;
int numberOfVertices = 0;
int upperVertices = 0;
int lowerVertices = 0;
int control = 0;
int indexMax;
int bridgeFound = 0;

void draw() {  // this is run repeatedly.  

    // draw points
    if (control == 0) {
        for (int i = 0; i < numberOfVertices; ++i) {
            strokeWeight(5.0);
            PVector p = (PVector) vertices.get(i);
            point(p.x, p.y);
        }
    } else {
        background(255); 
    }
}

class Line {
    int x1, y1, x2, y2;
    float slope;
    Line (int p1x, p1y, p2x, p2y) {
        x1 = p1x;
        y1 = p1y;
        x2 = p2x;
        y2 = p2y;
        slope = 0;
    }
    void update() {
        float trueY1 = 300.0 - y1;
        float trueY2 = 300.0 - y2;
        
        slope = (trueY2-trueY1) / ((float) ((float)x2-(float)x1));
    }
}

void mouseClicked() {
    if (mouseButton == LEFT && control == 0) {
        addPoint(mouseX, mouseY);
    }
    redraw();
}

void addPoint(final float x, final float y) {
    PVector newPoint = new PVector(x,y);
    vertices.add(newPoint);
    ++numberOfVertices;
}

void keyPressed() {
    if (control == 0 && keyCode == ENTER) {
        noLoop();
        splitHulls();
        ++control;
        return;
    }
    if (control == 1 && keyCode == ENTER) {
        medianX = findXMedian(upperHull, upperVertices);
        ++control;
        return;
    }    
    if (control == 2 && keyCode == ENTER) {
        pairVertices(upperHull, upperVertices);
        medianSlope = findSlopeMedian();
        ++control;
        return;
    }
    if (control == 3 && keyCode == ENTER) {
        indexMax = sweepLines();
        testSlope(indexMax);
        ++control;
        return;
    }
    if (control == 4 && keyCode == ENTER) {
        removeNonBridge(indexMax);
        lines.clear();
        if (bridgeFound == 1) {
            ++control;
            ++control;
            return;
        } else {
            ++control;
            return;
        }
    }
    if (control == 5 && keyCode == ENTER) {
        redraw();
        stroke(160,82,45);
        strokeWeight(2.0);
        line(pmin.x, pmin.y, pmax.x, pmax.y);
        stroke(255,165,0);
        line(medianX, 0, medianX, 300);
        stroke(0,0,0);
        strokeWeight(5.0);
        for (int i = 0; i < lowerVertices; ++i) {
            PVector p1 = (PVector) lowerHull.get(i);
            point(p1.x, p1.y);
        }
        for (int i = 0; i < upperVertices; ++i) {
            PVector p1 = (PVector) upperHull.get(i);
            point(p1.x, p1.y);
        }
        control = 2;
        return;
    }
    if (control == 6 && keyCode == ENTER) {
        // BRIDGE FOUND
        redraw();
        stroke(160,82,45);
        strokeWeight(2.0);
        line(pmin.x, pmin.y, pmax.x, pmax.y);
        stroke(0,0,0);
        strokeWeight(5.0);
        int numVertices = vertices.size();
        for (int i = 0; i < numVertices; ++i) {
            PVector p1 = (PVector) vertices.get(i);
            point(p1.x, p1.y);
        }
        strokeWeight(2.0);
        int numConvexPoints = ConvexHull.size();
        sortX(ConvexHull);
        for (int i = 0; i < numConvexPoints-1; ++i) {
            PVector p1 = ConvexHull.get(i);
            PVector p2 = ConvexHull.get(i+1);
            line(p1.x, p1.y, p2.x, p2.y);
        }
        ++control;
        return;
    }
    if (control == 7 && keyCode == ENTER) {
        upperHull.clear();
        splitHulls();
        int numPoints = upperHull.size();
        for (int i = 0; i < numPoints; ++i) {
            PVector p1 = upperHull.get(i);
            bool test = contains(p1);
            if (test == true) {
                strokeWeight(30.0);
                point(299,299);
                upperHull.remove(i);
                i--;
                numPoints--;
            }
        }
        redraw();
        stroke(160,82,45);
        strokeWeight(2.0);
        line(pmin.x, pmin.y, pmax.x, pmax.y);
        stroke(0,0,0);
        strokeWeight(5.0);
        int numUPoints = upperHull.size();
        int numLPoints = lowerHull.size();
        for (int i = 0; i < numUPoints; ++i) {
            PVector p1 = upperHull.get(i);
            point(p1.x, p1.y);
        }
        for (int i = 0; i < numLPoints; ++i) {
            PVector p1 = lowerHull.get(i);
            stroke(192,192,192);
            point(p1.x, p1.y);
        }
        stroke(0,0,0);
        strokeWeight(2.0);
        int numConvexPoints = ConvexHull.size();
        for (int i = 0; i < numConvexPoints-1; ++i) {
            PVector p1 = ConvexHull.get(i);
            PVector p2 = ConvexHull.get(i+1);
            line(p1.x, p1.y, p2.x, p2.y);
        }
        ++control;
        return;
    }
    if (control == 8 && keyCode == ENTER) {
        int numPoints = upperHull.size();
        for (int i = 0; i < numPoints; ++i) {
            PVector p1 = (PVector) upperHull.get(i);
            if (p1.x < medianX) {
                temp.add(p1);
            } else {
                temp2.add(p1);
            }
        }
        int tempSize = temp.size();
        int temp2Size = temp2.size();
        findXMedian(temp, tempSize);
        findXMedian(temp2, temp2Size);
    }
}
    
void testSlope(int index) {
    PVector p1 = (PVector) upperHull.get(index);
    strokeWeight(10.0);
    stroke(0,0,0);
    point(p1.x, p1.y);
}

void removeNonBridge(int index) {
    PVector p1 = (PVector) upperHull.get(index);
    float slope;
    int numLines = lines.size();
    for (int i = 0; i < numLines; ++i) {
        Line l1 = (Line) lines.get(i);
        if ((p1.x == l1.x1 && p1.y == l1.y1) || (p1.x == l1.x2 && p1.y == l1.y2)) {
              slope = l1.slope;
              if (medianSlope == slope) {
                  if ((l1.x1 <= medianX && l1.x2 >= medianX) || (l1.x2 <= medianX && l1.x1 >= medianX)) {
                      Line newLine = new Line(l1.x1, l1.y1, l1.x2, l1.y2);
                      newLine.update();
                      PVector cp1 = new PVector(l1.x1, l1.y1);
                      PVector cp2 = new PVector(l1.x2, l1.y2);
                      ConvexHull.add(cp1);
                      ConvexHull.add(cp2);
                      bridgeFound = 1;
                      return;
                  }
              }
              break; 
        }
    }
    int mid = floor(numLines/2);
    if (p1.x < medianX) {
        for (int i = mid; i < numLines; ++i) {
            removePoint(i, 0);
        }
    } else {
        for (int i = 0; i <= mid; ++i) {
            removePoint(i, 1);
        }
    }   
}

void removePoint(int i, int side) {
    Line l1 = (Line) lines.get(i);
    int x, y;
    if (l1.x1 > l1.x2) {
        if (side == 0) {
            x = l1.x2;
            y = l1.y2;
        } else {
            x = l1.x1;
            y = l1.y1;
        }
    } else {
        if (side == 0) {
            x = l1.x1;
            y = l1.y1;
        } else {
            x = l1.x2;
            y = l1.y2;
        }
    }

    for (int j = 0; j < upperVertices; ++j) {
        PVector p1 = (PVector) upperHull.get(j);
        if (x == p1.x && y == p1.y) {
            strokeWeight(10.0);
            stroke(255, 204, 255);
            point(x,y);
            upperHull.remove(j);
            --upperVertices;
            return;
        }
    }
}

void splitHulls() {
    sortX(vertices);
    int numVertices = vertices.size();
    pmin = (PVector) vertices.get(0);
    pmax = (PVector) vertices.get(numVertices-1);
    ConvexHull.add(pmin);
    ConvexHull.add(pmax);
    stroke(160,82,45);
    strokeWeight(2.0);
    line(pmin.x, pmin.y, pmax.x, pmax.y);
    for (int i = 0; i < numVertices; ++i) {
        PVector p1 = (PVector) vertices.get(i);
        PVector newPoint = new PVector(p1.x, p1.y);
        float check = ((pmax.x - pmin.x) * (p1.y - pmin.y) - (pmax.y - pmin.y)*(p1.x - pmin.x));
        if (check <= 0) {
            upperHull.add(newPoint);
            ++upperVertices;
        } else {
            lowerHull.add(newPoint);
            ++lowerVertices;
        }
    }
}

float findXMedian(ArrayList hull, int numVertices) {
    float med = 0;
    sortX(hull);
    int mid = floor(numVertices/2);
    if (numVertices % 2 != 0) {
        PVector p1 = hull.get(mid);
        med = p1.x;
    } else {
        PVector p1 = hull.get(mid);
        PVector p2 = hull.get(mid-1);
        med = (p1.x + p2.x)/2.0;
    }
    strokeWeight(2.0);
    stroke(255,165,0);
    line(med, 0, med, 300);
    return med;
}
        

void pairVertices(ArrayList hull, int numVertices) {
    for (int i = 0; i < floor(numVertices/2); ++i) {
        PVector p1 = (PVector) hull.get(i);
        PVector p2 = (PVector) hull.get(numVertices - i - 1);
        strokeWeight(1.0);
        stroke(0,0,255);
        line(p1.x, p1.y, p2.x, p2.y);
        Line newLine = new Line(p1.x, p1.y, p2.x, p2.y);
        newLine.update();
        lines.add(newLine);
    }
}

float findSlopeMedian() {
    float medSlope;
    sortSlope(lines);
    int numLines = lines.size();
    int mid = floor(numLines/2);
    for (int i = 0; i < numLines; ++i) {
        Line l1 = (Line) lines.get(i);
        if (i < mid) {
            stroke(0, 255 ,0);
        } else if (i == mid) {
            stroke (0, 0, 255);
            medSlope = l1.slope;
        } else {
            stroke (255, 0, 0);
        }
        line(l1.x1, l1.y1, l1.x2, l1.y2);
    }
    return medSlope;
    
}

int sweepLines() {
    int index;
    float theta = atan(medianSlope);
    float c = cos(theta);
    float s = sin(theta);
    float maxY = 0.0;
    for (int i = 0; i < upperVertices; ++i) {
        PVector p1 = (PVector) upperHull.get(i);
        float y1 = -p1.x*s + (300.0-p1.y)*c;
        if (y1 > maxY) {
            maxY = y1;
            index = i;
        }
    }
    return index;
}

void swap(ArrayList list, int a, int b) {
    PVector tmp = (PVector) list.get(a);
    list.set(a, list.get(b));
    list.set(b, tmp);
}

int partitionY(ArrayList list, int left, int right) {    
    int pivotIndex = floor((left + right)/2);    
    PVector pivotValue = (PVector) list.get(pivotIndex);    
    final int value = pivotValue.y;
    swap(list, pivotIndex, right);    
    
    int storedIndex = left;    
    for (int i=left; i<right; ++i) {      
        PVector currentValue = (PVector) list.get(i);
        int curVal = currentValue.y;   
        if (curVal < value) {        
            swap(list, storedIndex, i);        
            ++storedIndex;      
        }    
    }    
    swap(list, right, storedIndex);    
    return storedIndex;  
}    

ArrayList QuickSortY(ArrayList list, int left, int right) {    
    if (left < right) {      
        final int pivot = partitionY(list, left, right);      
        QuickSortY(list, left, pivot-1);      
        QuickSortY(list, pivot+1, right);    
    }    
    return list;  
}

ArrayList sortY(ArrayList list) {
    return QuickSortY(list, 0, list.size()-1);
}


int partitionX(ArrayList list, int left, int right) {    
    int pivotIndex = floor((left + right)/2);    
    PVector pivotValue = (PVector) list.get(pivotIndex);    
    final int value = pivotValue.x;
    swap(list, pivotIndex, right);    
    
    int storedIndex = left;    
    for (int i=left; i<right; ++i) {      
        PVector currentValue = (PVector) list.get(i);
        int curVal = currentValue.x;   
        if (curVal < value) {        
            swap(list, storedIndex, i);        
            ++storedIndex;      
        }    
    }    
    swap(list, right, storedIndex);    
    return storedIndex;  
}    

ArrayList QuickSortX(ArrayList list, int left, int right) {    
    if (left < right) {      
        final int pivot = partitionX(list, left, right);      
        QuickSortX(list, left, pivot-1);      
        QuickSortX(list, pivot+1, right);    
    }    
    return list;  
}

ArrayList sortX(ArrayList list) {
    return QuickSortX(list, 0, list.size()-1);
}


int partitionSlope(ArrayList list, int left, int right) {    
    int pivotIndex = floor((left + right)/2);    
    Line pivotValue = (Line) list.get(pivotIndex);    
    final float value = pivotValue.slope;
    swapLine(list, pivotIndex, right);    
    
    int storedIndex = left;    
    for (int i=left; i<right; ++i) {      
        Line currentValue = (Line) list.get(i);
        float curVal = currentValue.slope;   
        if (curVal < value) {        
            swap(list, storedIndex, i);        
            ++storedIndex;      
        }    
    }    
    swap(list, right, storedIndex);    
    return storedIndex;  
}    

ArrayList QuickSortSlope(ArrayList list, int left, int right) {    
    if (left < right) {      
        final int pivot = partitionSlope(list, left, right);      
        QuickSortSlope(list, left, pivot-1);      
        QuickSortSlope(list, pivot+1, right);    
    }    
    return list;  
}

ArrayList sortSlope(ArrayList list) {
    return QuickSortSlope(list, 0, list.size()-1);
}

void swapLine(ArrayList list, int a, int b) {
    Line tmp = (Line) list.get(a);
    list.set(a, list.get(b));
    list.set(b, tmp);
}

boolean contains(PVector test) {
    int i;
    int j;
    boolean result = false;
    int numCPoints = ConvexHull.size();
    for (i = 0, j = numCPoints - 1; i < numCPoints; j = i++) {
        PVector p1 = (PVector) ConvexHull.get(i);
        PVector p2 = (PVector) ConvexHull.get(j);
        if ( ((p1.y > test.y) != (p2.y > test.y)) && (test.x < (p2.x - p1.x) * (test.y - p1.y) / (p2.y - p1.y) + p1.x)) {
                result = !result;
        } 
    } 
    return result;
}

