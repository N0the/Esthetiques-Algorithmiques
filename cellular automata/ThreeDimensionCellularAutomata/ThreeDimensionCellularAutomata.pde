/** Leeder Julien IMAC 1
**/

//Import d'un library pour utiliser une camera bougeable dans la scene
import peasy.*;
PeasyCam cam;

//taille du cube de la simulation
int sSize = 80;
//dimension du cube
int dim = 1;
//taille de la grille
int T = sSize/dim;
boolean [][][] CA; //automate cellulaire
int z = 0;
boolean play = true;
int speed = 24;
int color1 = 255;
int color2 = 0;
int color3 = 0;

/**Creation des prerequis, mise en place de la scene, de la camera, et des limitations de celle-ci (deux axes de rotation possible)
**/
void setup(){
  size(800,800, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  cam.setSuppressRollRotationMode();
  reset();
}

void randomColor(){
  color1 = int(random(128,255));
  color2 = int(random(128,255));
  color3 = int(random(128,255));
}

//Reset la génération

void reset()
{
 CA = new boolean[T][T][T];
 for (int i = 0; i<T ; i++)
 {
   for (int j = 0; j<T ; j++)
   {
     if(random(1) < 0.5)
     {
       CA[i][j][0] = true;
     }
     else 
     {
       CA[i][j][0] = false;
     }
   }
 }
}

void draw()
{
background(0);
lights();
ambientLight(128,0,0,0,0,1);
pointLight(0,255,0,1,1,1);
if(play){
  if(frameCount%speed == 0)
  {
    z++;
    if(z%2 ==0){
      randomColor();
    }
    update();
  }
}
for (int i = 0; i<T ; i++)
 {
   for (int j = 0; j<T ; j++)
   {
     for (int k = 0; k<T ; k++)
     {
       if(CA[i][j][k])
       {
         showBox(i,j,k);
       }
     }
   }
 }
  showSimulationBox();
}
//Actualisation de l'état supérieur des cellules sur la hauteur
void update(){
  if(z >=T)
  {
    reset();
    z=0;
    return;
  }
  for (int i = 0; i<T ; i++)
   {
   for (int j = 0; j<T ; j++)
     {
       int c = getNeighborCount(i,j,z-1);
       if (CA[i][j][z-1])
       {
         if (c<2){
           CA[i][j][z] = false;
         }else if (c > 2 && c<5){
           CA[i][j][z] = true;
         }else{
           CA[i][j][z] = false;
         }

       }
       else
       {
         if(c==3)
         {
           CA[i][j][z] = true;
         }
         else{
           CA[i][j][z] = false;
         }
       }
   }
  }
}
int getNeighborCount(int i, int j, int k){
  int count = 0;
  //Conditions qui permettent de voir s'il y a un voisin
  
  if(CA[(i-1+T)%T][j][k]) count++; //checker gauche
  if(CA[(i-1+T)%T][(j+1+T)%T][k]) count++; //checker haut gauche
  if(CA[(i-1+T)%T][(j-1+T)%T][k]) count++; //checker bas gauche
  if(CA[i][(j+1)%T][k])count++; //checker haut
  if(CA[i][(j-1+T)%T][k])count++; //checker bas
  if(CA[(i+1)%T][j][k]) count++; //checker droit
  if(CA[(i+1)%T][(j+1+T)%T][k]) count++; //checker haut droit
  if(CA[(i+1)%T][(j-1+T)%T][k]) count++; //checker bas droit
  
  return count;
}

void showSimulationBox(){
  //Permet d'enregistrer les coordonnees actuelles
  pushMatrix();
  //Création du cube, avec sa position, sa taille
  translate(sSize/2, sSize/2, sSize/2);
  scale(sSize,sSize,sSize);
  stroke(255);
  strokeWeight(0.9/sSize);
  noFill();
  box(1,1,1);
  popMatrix();
}

//Génération des cellules
void showBox(int x, int y, int z){
  pushMatrix();
  translate(x*dim+dim/2,y*dim+dim/2,z*dim+dim/2);
  scale(dim,dim,dim);
  fill(color1,color2,color3);
  stroke(0,0,0);
  strokeWeight(1.0/dim);
  box(1,1,1);
  popMatrix();
}

//Permet de modifier la dimension des cubes générés
void dimInput(int input){
    dim = input;
    T = sSize/dim;
    randomColor();
    play = false;
    z=0;
    reset();
}

void keyPressed()
{
  //changer le dimensionnement
  switch(key)
  {
    case '1':
    dimInput(1);
    break;
    
    case '2':
    dimInput(2);
    break;
    
    case '3':
    dimInput(3);
    break;
    
    case '4':
    dimInput(4);
    break;
    
    case'5':
    dimInput(5);
    break;
    
    case '6':
    dimInput(6);
    break;
    
    case '7':
    dimInput(7);
    break;
    
    case '8':
    dimInput(8);
    break;
    
    case '9':
    dimInput(9);
    break;
    
    case ' ':
    play = !play;
    break;
    
    case '-':
    if(speed <50)
    {
      speed+=2;
    }
    break;
    
    case '+':
    if(speed >5)
    {
      speed-=2;
    }
    break;
  }
  
}
