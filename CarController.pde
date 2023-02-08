class CarController {
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();
  boolean       isDead       = false;

  void update() {
    if (!isDead && sensorSystem.whiteSensorFrameCount > 0) {
      isDead = true;
    }

    if (isDead) return;

    bil.update();

    sensorSystem.updateSensorsignals(bil.pos, bil.vel);
    float turnAngle = 0;
    float x1 = int(sensorSystem.leftSensorSignal);
    float x2 = int(sensorSystem.frontSensorSignal);
    float x3 = int(sensorSystem.rightSensorSignal);    
    turnAngle = hjerne.getOutput(x1, x2, x3);    

    bil.turnCar(turnAngle);
  }
  
  void display(){
    bil.displayCar();
    sensorSystem.displaySensors();
  }

  int getFitness(){
    if (isDead) return 0;
    return sensorSystem.laps;
  }

  void mutate(){
    hjerne.mutate();
  }

  void reset() {
    isDead = false;
    bil.pos = new PVector(60, 232);
    sensorSystem.laps = 0;
    sensorSystem.lapTimeInFrames = 0;
    sensorSystem.whiteSensorFrameCount = 0;
  }
}
