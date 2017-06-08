void theodorusSpiralInit(PVector[] points, float innerBoundary, float outerBoundary) {
  int shapeCounter = 0;
  color c1 = color(255,255,255);
  color c2 = color(100,100,100);
  color c3 = color (0,0,0);
  for (int i = 0; i < totalSegments; i++) {
    PVector pos = new PVector(points[i].x, points[i].y);
    float radius = stepLength*3.5;
    // adjust size to innerBoundary
    float distanceToCenter = dist(pos.x, pos.y, 0, 0);
    if (distanceToCenter-innerBoundary/2 < radius/2) {
      radius = 2*(distanceToCenter-innerBoundary/2);
    }
    if (abs(distanceToCenter-outerBoundary/2) < radius/2) {
      radius = 2*(outerBoundary/2-distanceToCenter);
    } else
      radius = radius;
    if (radius >0) {
      //ellipse(pos.x, pos.y, radius, radius);
      RShape s = RShape.createCircle(pos.x, pos.y, radius);
      if (shapeCounter%2 == 0){
        s.setFill(c1);
        s.setStroke(c3);
      }
      else{
        s.setFill(c2);
        s.setStroke(c3);
      }
      mySpiral.addChild(s);
      shapeCounter ++;
    }
  }
}

PVector[] getTheodorus(int segments, int len) {
  PVector[] result = new PVector[segments];
  float radius = 0;
  float angle = 0;
  for (int i = 0; i < segments; i++) {
    radius = sqrt(i+1);
    angle += asin(1/radius);
    result[i] = new PVector(cos(angle) * radius*len, sin(angle) * radius*len);
  }
  return result;
}