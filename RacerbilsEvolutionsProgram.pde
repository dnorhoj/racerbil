//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 100;     

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
  // set framerate to 500fps
  frameRate(1000);
}

void draw() {
  clear();
  fill(255);
  rect(0,50,1000,1000);
  image(trackImage,0,80);  

  carSystem.updateAndDisplay();

  // Display text (score, generation, etc.)
  fill(0);
  textSize(12);
  text("Generation: " + carSystem.generation, 10, 70);
  text("Best score: " + carSystem.bestScore, 10, 80);
}
