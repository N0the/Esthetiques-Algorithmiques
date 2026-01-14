/*
Leeder Julien IMAC 1
 */


//Import de la library pour la caméra et la navigaiton 3D
import peasy.*;
// Résolution du fractal (nombre de points par axe), plus dim est grand, plus le fractal est détaillé
int dim = 8 ;

//Nombre de répétition de la sphère contenant les fractales
int number = 50;
//Ecart entre les fractales
int translateNumber = 200;
//Caméra interactive
PeasyCam cam;
//Tableau qui va contenir les points qui forment le fractale
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

void setup()
{
  size(1000, 1000, P3D);
  windowMove(1200, 100);
  //Création d'une caméra en 3D
  cam = new PeasyCam(this, 500);
  //Changement du mode colorimétrique
  colorMode(HSB, 360, 100, 100);

  for (int i = 0; i < dim; i++) {
    for (int j = 0; j < dim; j++) {
      //Checker pour vérifier les angles et uniformiser la forme du fractal
      boolean edge = false;
      for (int k = 0; k < dim; k++) {
        //Normalisation des coordonnées x,y,z (de -1 à 1)
        float x = map(i, 0, dim, -1, 1);
        float y = map(j, 0, dim, -1, 1);
        float z = map(k, 0, dim, -1, 1);

        PVector zeta = new PVector(0, 0, 0);

        //Paramètres d'itération
        int maxiterations = 5;
        int increment = 0;
        //Puissance n de la formule z^n + c 
        int n = 8;

        //Création du fractale
        while (true) {
          //Coordonnées sphérique
          Spherical sphericalZ = spherical(zeta.x, zeta.y, zeta.z);

          // Perturbation angulaire pour casser la symétrie parfaite
          float theta2 = sphericalZ.theta * n + sin(sphericalZ.phi * 3.0);
          float phi2   = sphericalZ.phi   * n + cos(sphericalZ.theta * 3.0);

          // Formule du fractale Mandelbulb modifié
          float newx = pow(sphericalZ.r, n) * sin(theta2*n) * cos(phi2*n);
          float newy = pow(sphericalZ.r, n) * sin(theta2*n) * sin(phi2*n);
          float newz = pow(sphericalZ.r, n) * cos(theta2*n);

          // Ajout du point courant pour le Mandelbulb (formule donné : z = f(z) + c)
          zeta.x = newx + x;
          zeta.y = newy + y;
          zeta.z = newz + z;

          increment ++;

          // Condition d'échappement
          if (sphericalZ.r > 16) {
            if (edge) {
              edge = false;
            }
            break;
          }

          //On incrément jusqu'à avoir fait tous les incréments
          if (increment > maxiterations) {
            if (!edge) {
              edge = true;
              mandelbulb.add(new PVector(x*100, y*100, z*100));
            }
            break;
          }
        }
      }
    }
  }
}

class Spherical {
  float r, theta, phi; //Rayon, angle polaire et azimutal (angle dans le plan horizontal entre la direction de cet objet et une direction de référence)
  Spherical(float r, float theta, float phi) {
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
}

// Conversion cartésien → sphérique

Spherical spherical(float x, float y, float z) {
  float r = sqrt(x*x+y*y+z*z);
  float theta = atan2(sqrt(x*x+y*y), z);
  float phi = atan2(y, x);
  return new Spherical(r, theta, phi);
}

void draw()
{
  background(0);
  strokeWeight(2);
  int colorindex = 0;
  //Rayon de la sphère contenant les fractales
  float R = translateNumber * number * 0.5;
  
  // Latitude
  for (int i = 0; i < number; i++) {


    float theta = map(i, 0, number-1, 0, PI);
    
    // Longitude
    for (int j = 0; j < number; j++) {


      float phi = map(j, 0, number-1, 0, TWO_PI);

      //Génération d'une couleur, étant donné que l'index s'incrément, la couleur change pour faire un dégradé
      float hue = map(colorindex, 0, number*number, 0, 360);
      colorindex++;
      stroke(hue, 100, 100);
      pushMatrix();

      // Positionnement sur une sphère
      float x = R * sin(theta) * cos(phi);
      float y = R * sin(theta) * sin(phi);
      float z = R * cos(theta);

      translate(x, y, z);
      
      // On dessine le mandelbulb
      for (PVector v : mandelbulb) {
        point(v.x, v.y, v.z);
      }
      popMatrix();
    }
  }
}
