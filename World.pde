class World {
  Lake lake;
  Icon i;
  Particle [] p;
  Electron[] el;
  int lakeX, lakeY;
  int cols, rows, w = 800, h = 900;
  int posX = 0, posY = 0, cell = 10;
  int drillDeeper = -50, drillDepth = -350, actualStream = 0;
  boolean isDrilling = false;
  boolean bottom = false;
  World() {
    cols = w / cell;
    rows = h / cell;
    lakeX = w / 2;
    lakeY = int(h * 0.75);    
    lake = new Lake (lakeX, lakeY, r);
    i = new Icon(lakeX, 100);
    //float posX, float posY, float posZ, float trX, float trY, float trZ
    p = new Particle[10];
    for (int i = 0; i < p.length; i++) {
      float angle = map( i, 0, p.length, 0, TWO_PI);
      float x = lakeX + (cos(angle) * random(0, r / 5));
      float y = lakeY + (sin(angle) * random(0, r / 5));
      p[i] = new Particle(x, y, random(0, 200), lakeX, lakeY, 50);
    }
    //electrons
    el = new Electron[13];
    for (int i = 0; i < el.length; i++) {
      float angle = map(i, 0, el.length, 0, TWO_PI);
      float x = lakeX + (cos(angle) * random(r * .75, r));
      float y = lakeY + (sin(angle) * random(r * .75, r));
      el[i] = new Electron(5.0, x, y, random(0, 200), lakeX, lakeY, 50);
    }
  }

  void update() {
    for (Particle part : p) {
      part.update();
    }
    for (Electron e : el) {
      PVector force = e.attract(e);
      e.applyForce(force);
      e.update();
    }
    //if (drill != null) {
    //  Stream d = drill.get(actualStream);
    //  d.drillDrill(posX * cell, posY * cell, drillDeeper);
    //  //Stream d = drill.get(actualStream);
    //  if (bottom) {
    //    drill.add(new Stream(posX * cell, posY * cell, -50, drilling));        
    //    bottom = false;
    //    actualStream++;
    //    drillDeeper = -50;
    //  }
    //  if (drillDeeper <= drillDepth) {
    //    //drillDeeper = drillDepth;
    //    isDrilling = false;
    //    bottom = true;
    //    for (int i = 0; i < lake.waterStream.length; i++) {
    //      d.crossingStream(d, lake.waterStream[i]);
    //    }
    //  }
    //  for (Stream dd : drill) {
    //    dd.update();
    //    lake.update(dd.pollution);
    //  }
    //}

    //if (isDrilling)drillDeeper -= 50;
  }


  void show() {
    noFill();
    ortho();
    background(0);
    worldRotation();    
    beginShape(TRIANGLE);
    float inc = 0.1, yOff = 0;
    for (int y = 0; y < rows; y++) {
      float xOff = 0;
      for (int x = 0; x < cols; x++) {
        int index = x + cols * y;
        float steepness = map(index, 0, rows * cols, 25, 0);
        float n = map(noise(xOff, yOff), 0, 1, 0, steepness);
        float amp = noise(xOff, yOff) > 0.5 ? 0 : 1;
        strokeWeight(1);
        color c = lerpColor(land, grass, amp);
        noStroke();
        //stroke(c);
        fill(c);
        vertex(x * cell, y * cell, n);
        vertex(x * cell, (y + 1) * cell, n);
        vertex((x + 1) * cell, (y + 1) * cell, n);
        //vertex((x + 1) * cell, y  * cell, n);
        xOff += inc;
      }
      yOff += inc;
    }
    endShape();
    lake.show();   
    i.show();
    for (Particle part : p) {
      part.show();
    }
    for (Electron e : el) {
      e.show();
    }
    //if (drill != null) {
    //  for (Stream d : drill) {
    //    d.show();
    //  }
    //}
  }
  void worldRotation() {
    //translate(width / 2, height / 2.3); // turn on if peasyCam is off
    rotateX(PI / 3);
    rotateZ( -PI / 3);
    translate(-w / 2, -h / 2);
  }

  void mouseClicked() {
    isDrilling = true;
    //drillDeeper -= 50;
    //Stream d = drill.get(actualStream);
    //if (d.bottom) {
    //  drill.add(new Stream(posX * cell, posY * cell, -50, drilling));        
    //  d.bottom = false;
    //  actualStream++;
    //  drillDeeper = -50;
    //}
    //if (drillDeeper < drillDepth) {
    //  drillDeeper = drillDepth;
    //  d.bottom = true;
    //  for (int i = 0; i < lake.waterStream.length; i++) {
    //    d.crossingStream(d, lake.waterStream[i]);
    //  }
    //}
  }

  void keyPressed() {
    ///inverted//
    if (key == CODED) {
      if (keyCode == UP) {
        posX++;
        if (posX > rows)posX = rows;
      }
      if (keyCode == DOWN) {
        posX--;
        if (posX < 0)posX = 0;
      }
      if (keyCode == LEFT) {
        posY--;
        if (posY < 0)posX = 0;
      }
      if (keyCode == RIGHT) {
        posY++;
        if (posY > cols)posY = cols;
      }
    }
  }
}