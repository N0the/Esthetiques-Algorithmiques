/** Leeder Julien IMAC 1
**/

float x=0;
int y=1;
int lstyle =0;

void setup()
{
  size(640,400);
  background(255);
}
//Fonction qui permet de modifier le style des lignes
void setLineStyle(int s) {
  switch(s) {
    case 0:
      stroke(255,0,0);
      strokeWeight(4);
      break;
    case 1:
      stroke(0,0,255);
      strokeWeight(2);
      break;
    case 2:
      stroke(255, 0, 0);
      strokeWeight(0.5);
      break;
  }
}
void draw (){
  //Permet de changer de style
      if (x==0){
        setLineStyle(lstyle);
      }
      //Dessin de la forme à partir du code donné
      int Resolution = int(height * 0.4);
      //création du dessin
      if (x <=1000)
      {
        line(90*sin(x/100)+2*Resolution,70*sin(x/80)+Resolution,80*sin(x/70)+2*Resolution,50*sin(x/90)+Resolution);
        //permet d'accélérer l'incrémentation par dessin
        x+=1*y;
      }
      //après avoir fait le dessin, nous le refaisons mais avec un autre style de ligne
      else 
      {
        lstyle++;
        x = 0;
        y++;
      }
      //après avoir fait trois fois le dessin, nous sortons de la boucle, ce qui stop le programme sans effacer le dessin
      if (lstyle == 3)
      {
        noLoop();
      }
}
