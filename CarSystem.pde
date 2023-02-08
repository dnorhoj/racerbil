import java.util.*;

class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser
  
  ArrayList<CarController> carControllerList  = new ArrayList<CarController>();
  int populationSize;
  int generation = 0;
  int bestScore = 0;

  CarSystem(int populationSize) {
    populationSize = populationSize;
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      carControllerList.add(controller);
    }
  }

  void newGeneration() {
    generation++;
    //Sorter listen efter score
    Collections.sort(carControllerList, new Comparator<CarController>() {
      @Override
      public int compare(CarController o1, CarController o2) {
        return o1.getFitness() - o2.getFitness();
      }
    });

    //Find den bedste score
    bestScore = carControllerList.get(carControllerList.size()-1).getFitness();

    //Fjern de dårligste
    for (int i=0; i<populationSize/2; i++) {
      carControllerList.remove(0);
    }

    //Tilføj nye
    for (int i=0; i<populationSize/2; i++) {
      carControllerList.add(new CarController());
    }

    //Mutér de nye
    for (int i=populationSize/2; i<populationSize/2; i++) {
      carControllerList.get(i).mutate();
    }

    //Reset alle
    for (CarController controller : carControllerList) {
      controller.reset();
    }
  }

  void updateAndDisplay() {
    // New generation every 1000 frames
    if (frameCount % 1000 == 0) {
      newGeneration();
    }

    for (CarController controller : carControllerList) {
      if (controller.isDead) continue;
      controller.update();
    }

    for (CarController controller : carControllerList) {
      if (controller.isDead) continue;
      controller.display();
    }
  }
}
