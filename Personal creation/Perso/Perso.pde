/**
 Leeder Julien
 **/

// Bibliothèque Minim pour lire la musique et récupérer son amplitude
import ddf.minim.*;
import ddf.minim.analysis.*;

// Import pour afficher une boîte de dialogue (choix de la musique)
import javax.swing.JOptionPane;

Minim minim;           // Gestionnaire audio
AudioPlayer song;      // Lecteur de musique
float amplitude;       // Amplitude sonore (volume instantané)

float x = 100;         // Longueur de base des branches
float y = 100;         // Position verticale de certains éléments
float angle = 10;      // Angle de rotation global
float bold = 20;       // Taille des cercles


// Seuil d’amplitude pour déclencher le fractal
int value = 100;

int color1 = 255;
int color2 = 255;
int color3 = 255;

// Chemins des fichiers audio
String[] songlist = {
  "Sounds/HEAVENLY_JUMPSTYLE.mp3",
  "Sounds/Ado_show.mp3",
  "Sounds/CVLTE_realitYhurts.mp3",
  "Sounds/RagnBone_Man_Human.mp3"
};

// Noms affichés pour l’utilisateur
String[] songlistName = {
  "HEAVENLY JUMPSTYLE",
  "Ado show",
  "CVLTE realitYhurts",
  "RagnBoneMan Human"
};

boolean checkerMusique = false;   // Vérifie si une musique a été choisie
boolean colorTriggered = false;   // Empêche le changement de couleur multiple

void setup() {
  size(1000, 1000);
  fill(0);
  colorMode(HSB, 360, 100, 100);
  // Boucle tant qu’aucune musique n’est choisie
  while (checkerMusique == false) {

    println("Veuillez choisir la musique que vous voulez lancer : ");

    // Affichage de la liste des musiques
    for (int i = 0; i < songlist.length; i++) {
      println("Musique " + i + " : " + songlistName[i]);
    }

    // Boîte de dialogue pour entrer le numéro
    String input = JOptionPane.showInputDialog(
      "Veuillez entrer le numéro de la musique : "
      );
    //Conversion de l'input en int
    int choix = int(input);

    // Vérification de la validité du choix
    if (choix >= 0 && choix <= songlist.length - 1) {
      checkerMusique = true;

      println("Vous avez choisi la musique : "
        + songlistName[choix]
        + ", bonne écoute !");

      minim = new Minim(this);
      song = minim.loadFile(songlist[choix], 2048);
      //Baisser le son de 20 décibel
      song.setGain(-20);
      song.play();
    } else {
      println("Valeur invalide ! Veuillez recommencer.");
    }
  }
}

//Fonction fractale pour générer les branches (utilisation de la récursivité)
void drawBranch(float len, int level) {

  // Condition d’arrêt de la récursion
  if (level == 0) return;

  // Dessin de la branche principale
  line(0, 0, 0, -len);
  translate(0, -len);
  ellipse(0, 0, bold, bold);

  // Branche droite
  pushMatrix();
  rotate(radians(30));
  drawBranch(len * 0.7, level - 1);
  popMatrix();

  // Branche gauche
  pushMatrix();
  rotate(radians(-30));
  drawBranch(len * 0.7, level - 1);
  popMatrix();
}

void draw() {

  background(0);

  // Calcul de l’amplitude sonore
  amplitude = song.mix.level() * 1000;

  // Couleur du trait basée sur l’amplitude
  stroke(amplitude, amplitude, amplitude);

  // Placement au centre
  translate(width / 2, height / 2);
  rotate(radians(angle / 2));

  // Création en cercle
  for (float i = 0; i < 360; i += 20) {

    pushMatrix();
    rotate(radians(i));
    strokeWeight(5);

    // Lignes et points fixes
    line(0, y, bold, 0);
    ellipse(0, y, bold, bold);

    // Ligne dépendante de l’amplitude
    line(0, amplitude, 0, 0);

    float checker = amplitude;

    // Si l’amplitude dépasse le seuil
    if (checker > value) {

      // Changement de couleur une seule fois
      if (!colorTriggered) {
        color1 = int(random(150, 255));
        color2 = int(random(150, 255));
        color3 = int(random(150, 255));
        colorTriggered = true;
      }

      // Calcul du nombre de branches
      int increment = int(checker / value);
      int growth = value / 2;

      // Dessin du fractal
      for (int j = 0; j < increment; j++) {
        fill(255);
        drawBranch(x, j);
        ellipse(0, x + growth, bold, bold);
        growth += growth;
      }
    } else {
      // Réinitialisation si le son redescend
      colorTriggered = false;
    }

    popMatrix();
  }

  // Rotation dynamique selon le volume
  float speedFactor = amplitude / 1000.0;
  angle += min(speedFactor * 10, 20);

  // Si la musique est terminée : musique aléatoire
  if (!song.isPlaying()) {
    playRandomSong();
  }
}
//Fonction pour jouer des musiques aléatoires, parmis celle présente dans le tableau

void playRandomSong() {

  if (song != null) {
    song.close();
  }

  int randomSong = int(random(0, songlist.length));
  song = minim.loadFile(songlist[randomSong], 2048);
  song.setGain(-20);
  song.play();

  println("Nouvelle musique : " + songlistName[randomSong]);
}

void keyPressed() {

  // ESPACE permet de choisir une musique aléatoire
  if (key == ' ') {
    if (song != null) {
      song.close();
    }
    playRandomSong();
  }

  // R permet de rechoisir une musique
  if (key == 'r') {

    if (song != null) {
      song.close();
    }

    checkerMusique = false;

    while (checkerMusique == false) {

      println("Veuillez choisir la musique que vous voulez lancer : ");

      for (int i = 0; i < songlist.length; i++) {
        println("Musique " + i + " : " + songlistName[i]);
      }

      String input = JOptionPane.showInputDialog(
        "Veuillez entrer le numéro de la musique : "
        );

      int choix = int(input);
      if (choix >= 0 && choix <= songlist.length - 1) {
        checkerMusique = true;
        println("Vous avez choisi la musique : "
          + songlistName[choix]
          + ", bonne écoute !");

        minim = new Minim(this);
        song = minim.loadFile(songlist[choix], 2048);
        song.setGain(-20);
        song.play();
      } else {
        println("Valeur invalide ! Veuillez recommencer.");
      }
    }
  }
}
