/** Leeder Julien IMAC 1
**/
//angle de rotation du cube
float angle = 0;
//taille du cube adapté à l'écran
float size = width/2;
//couleur rgb du cube
float color1 = 128;
float color2 = 128;
float color3 = 128;
int increment = 0;
//checker pour regarder si l'utilisateur a mis en pause
boolean paused = false;

void setup()
{
  //le P3D permet de définir à la scène un certain moteur de rendu, ici le P3D
  size(640,400, P3D);
  background(0);
  strokeWeight(1);
  stroke(255);
}

void CubeSpin(int number)
{
  background(0);
  //permet de définir la position au milieu de l'écran
  translate(width/2, height/2, 0);
  //Méthodes pour faire des rotations sur les axes X Y en fonction d'un angle que l'on incrémente après
  rotateY(angle);
  rotateX(angle);
  //Permet de rendre le cube transparent
  noFill();
  //Définir la taille de notre cube, que l'on va faire varier avec la fonction cosinus
  box(size);
  /**Boucle qui va générer n nombre de cube en fonction de l'incrémentation de l'utilisateur, à noter que plus on a de cube, plus les incréments augmentent, comme la taille ou l'angle, 
  qui va influencer tout le code**/
  for (int i = 0; i < number; i++)
  {
    angle+=0.001;
    /**
    Nous générons les couleurs grâce à un pseudo aléatoire issu de l'angle. On utilise trois fonctions trigos distinctent afin d'avoir une couleur RGB qui n'est pas un nuancier de gris 
    (du moins pour la plupart du temps)
    **/
    color1+=cos(angle);
    color2+=sin(angle);
    color3+=tan(angle);
    //On change la couleur des segments du cube
    stroke(color1,color2,color3);
    // On fait varier la taille du cube grâce à la fonction cosinus, qui nous permet de faire un semblant d'aléatoire, mais qui ne va sortir de l'encadrement de base
    size += cos(angle);
    //et l'on refait tourner et afficher le cube !
    rotateY(angle);
    rotateX(angle);
    noFill();
    box(size);
  }

}

//Appel de fonction avec le nombre de cube que l'on veut afficher

void draw ()
{
  //permet de vérifier si nous sommes en pause
  if (!paused) {
    CubeSpin(increment);
  }
}

/*

UTILISER LES TOUCHES + ET - POUR AUGMENTER OU BAISSER LE NOMBRE DE CUBE 

*/

void keyPressed(){
  //permet d'augmenter le nombre de cube généré
  if(key=='+')
  {
    if (increment != 50 && paused == false)
    {
      increment++;
    }
  }
  //permet de réduire le nombre de cube généré
  if(key=='-')
  {
    if (increment != 0 && paused == false){
      
      increment--;
    }
  }
  //permet de mettre en pause le code
  if (key == ' ') 
  {
    paused = !paused;
  }
}
