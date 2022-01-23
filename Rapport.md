![](RackMultipart20220123-4-1lfzf1b_html_f0d75ad5e54ad746.png)

| HES-SO // Valais - Wallis |
| --- |
|
# Projet : Cursor
 |
| Commande de moteur par FPGA |

| Simon Donnet-Monay &amp; Rémi Heredero23/01/2022
 |
| --- |

# Table des matières

[1 Introduction](#1Introduction)

[2 Design général](#_Toc93790565)

[2.1 "PositionBlock"](#_Toc93790566)

[2.2 "ButtonBlock"](#_Toc93790567)

[2.3 "Driver"](#_Toc93790568)

[2.4 "Main"](#_Toc93790569)

[3 Vérification et validation](#_Toc93790570)

[3.1 Simulation Position](#_Toc93790571)

[3.2 Simulation Boutons](#_Toc93790572)

[3.3 Simulation Main](#_Toc93790573)

[3.4 Simulation Driver](#_Toc93790574)

[4 Intégration](#_Toc93790575)

[4.1 HDL-Designer](#_Toc93790576)

[4.2 Test Design](#_Toc93790577)

[4.3 Préparation pour la synthèse](#_Toc93790578)

[4.4 Synthèse](#_Toc93790579)

[4.5 Configuration](#_Toc93790580)

[5 Conclusion](#_Toc93790581)


[Figure 1 Top level](#_Toc93790582)

[Figure 2 Architecture "PositionBlock"](#_Toc93790583)

[Figure 3 Signaux du codeur incrémental](#_Toc93790584)

[Figure 4 FSM encoder](#_Toc93790585)

[Figure 5 Counter 1 bit](#_Toc93790586)

[Figure 6 Counter 4 bits](#_Toc93790587)

[Figure 7 Counter 24 bits](#_Toc93790588)

[Figure 8 Blocage pour éviter le dépassement](https://hessoit-my.sharepoint.com/personal/remi_heredero_hes-so_ch/Documents/S1fb/electricity/1-EIN/project/cursor/Rapport.docx#_Toc93790589)

[Figure 9 Filtrage de 24 bit à 16 bit](#_Toc93790590)

[Figure 10 Stand by des boutons](#_Toc93790591)

[Figure 11 Bypass du button4](#_Toc93790592)

[Figure 12 Architecture "Driver"](#_Toc93790593)

[Figure 13 Bloc "Counter_Controller"](#_Toc93790594)

[Figure 14 Architecture "Main&quot"](https://hessoit-my.sharepoint.com/personal/remi_heredero_hes-so_ch/Documents/S1fb/electricity/1-EIN/project/cursor/Rapport.docx#_Toc93790595)

[Figure 15 Root view pour la simulation](#_Toc93790596)

[Figure 16 ModelSim Flow](https://hessoit-my.sharepoint.com/personal/remi_heredero_hes-so_ch/Documents/S1fb/electricity/1-EIN/project/cursor/Rapport.docx#_Toc93790597)

[Figure 17 Prepare for Synthesis](https://hessoit-my.sharepoint.com/personal/remi_heredero_hes-so_ch/Documents/S1fb/electricity/1-EIN/project/cursor/Rapport.docx#_Toc93790598)

[Figure 18 Xilinx Project Navigator](https://hessoit-my.sharepoint.com/personal/remi_heredero_hes-so_ch/Documents/S1fb/electricity/1-EIN/project/cursor/Rapport.docx#_Toc93790599)

[Figure 19 Buttons on ucf file](#_Toc93790600)

[Figure 20 Hierarchy in ISE](https://hessoit-my.sharepoint.com/personal/remi_heredero_hes-so_ch/Documents/S1fb/electricity/1-EIN/project/cursor/Rapport.docx#_Toc93790601)

[Figure 21 Processes ISE](https://hessoit-my.sharepoint.com/personal/remi_heredero_hes-so_ch/Documents/S1fb/electricity/1-EIN/project/cursor/Rapport.docx#_Toc93790602)

[Figure 22 iMPACT](#_Toc93790603)

#


# 1 Introduction

Dans le cadre des cours d&#39;électronique numérique nous devons en fin de semestre réaliser un projet. Ce projet consiste à réaliser le design d&#39;un curseur. Celui-ci-doit se déplacer à une position pré-enregistré avec une certaine accélération et un certaine décélération. Nous devons réaliser le design de la partie logique de notre système. Pour ce faire, nous utilisons le logiciel « HDL Designer ». Les instructions et la documentation complète se trouve sur Cyberlearn dans la section « Cursor ».

Nous avons réalisé ce projet en binôme et avons utilisé GIT afin d&#39;optimiser notre collaboration. Nous avons réalisé ensemble le design général décrit un peu plus bas, puis avons travaillé chacun sur des parties spécifiques du schéma général.

# 2Design général

Pour le design général, nous avons décidé de séparer notre top level (Figure 1) en 4 blocs. Un bloc qui gère la position du curseur en fonction des entrées de l&#39;encodeur (« PositionBlock »). Un bloc qui gère les boutons pour éviter d&#39;avoir plusieurs appui simultané (« ButtonBlock »). Un bloc driver qui gère la puissance et la direction du moteur (« driver2 »). Et enfin le bloc principal qui gère la logique global du curseur (« Main2 »).

![](RackMultipart20220123-4-1lfzf1b_html_e4a68db44b68109c.png)

_Figure 1 Top level_

## 2.1 « PositionBlock »

Le « PositionBlok » (Figure 2) s&#39;occupe de donner la position absolue depuis le reset. Il prend les signaux de l&#39;encodeur de position en entrée ainsi que le signal reset. Ça seule sortie est la position codé sur 16 bit.

Le bloc est découpé en 2 grande parties. La première s&#39;occupe de générer un signal de comptage ou de décomptage en fonction du sens de rotation de l&#39;encodeur et donc de la direction du curseur.

![](RackMultipart20220123-4-1lfzf1b_html_18d492b5a0ede8ce.png)

_Figure 2 Architecture « PositionBlock »_

Pour savoir s&#39;il faut compter ou décompter, nous regardons dans quel sens tourne le codeur incrémental. Comme il possède 2 bit, il suffit de regarder quel est l&#39;état de ces deux bits les uns après les autres (Figure 3

# 1
). Cette partie « Encoder » transmet simplement un signal s&#39;il faut incrémenter la position ou la décrémenter (Figure 4).

![](RackMultipart20220123-4-1lfzf1b_html_86c5860c18c836fa.png)

_Figure 3 Signaux du codeur incrémental_

![](RackMultipart20220123-4-1lfzf1b_html_5b73452086522ed9.png)

_Figure 4 FSM encoder_

Pour calculer la position absolue, nous devons déjà connaître la valeur maximale de notre compteur. L&#39;encodeur aillant 500 position par tour pour chacun des deux signaux, nous avons donc un changement de bit 2000 fois par tour. Le pas de vis étant de 1,75 [mm], Nous pouvons calculer qu&#39;il y aura 11&#39;430 changement pour 1 [cm] soit 171&#39;450 pour les 15 [cm] de course totale du curseur. Nous avons donc besoin d&#39;aller au moins jusqu&#39;à 0010&#39;1001&#39;1101&#39;1011&#39;1010 pour faire rond 20bit.

_Remarque :_ _À la suite d&#39;une erreur de calculs lors de notre toute première version, nous avons réalisé un compteur sur 24 bit. Comme nous l&#39;avons créé sur 24 bit et que cela ne change rien au process, nous gardons cette version a 24 bit, mais sachez qu&#39;il est tout à fait possible (si ce n&#39;est préférable) de faire le compteur sur seulement 20 bit_

Pour déterminer cette position absolue, nous avons donc besoin de compter et décompter. Nous avons pour ceci créé un composé de plusieurs sous compteur. Pour commencer, le bloc primordial, le compteur 1 bit qui peut compter ou décompter et possède une remis à zéro synchrone (Figure 5). Ensuite en en assemblant 4 et en connectant leurs bit de carriage à leurs entrées enable, nous avons un compteur 4 bit (Figure 6). Enfin la même chose avec 6 _(ou 5 si compteur 20bit)_ de ces compteur 4 bits pour construire notre compteur total (Figure 7).

![](RackMultipart20220123-4-1lfzf1b_html_b035f83c46f4b422.png)

_Figure 5 Counter 1 bit_

| ![](RackMultipart20220123-4-1lfzf1b_html_47914666f76dde22.png)_Figure 6 Counter 4 bits_ | ![](RackMultipart20220123-4-1lfzf1b_html_40af794987705242.png)_Figure 7 Counter 24 bits_
 |
| --- | --- |
| ![](RackMultipart20220123-4-1lfzf1b_html_6dacc9adda62feaa.png)

 Pour éviter un dépassement de bit, il faut bloquer le décomptage lorsque la valeur de ce dernier est à 0.Pour ce faire, un signal est envoyé depuis un autre bloc qui fait la comparaison et renvoie si la valeur est à 0.Lorsque ce signal est à 1, il bloque le décomptage. Ceci ce fait grâce à l&#39;équation :


_Figure 8 Blocage pour éviter le dépassement_Cette équation est traduite en porte logique dans un zoom de la Figure 7 en Figure 8 |
 |

Comme cette valeur est codé sur 24 bit (ou 20 bit), et que nous souhaitons travailler sur 16 bit pour plus de facilité et de clarté nous de prenons que les 16 bit de poids forts qui nous intéresse. Notre valeure maximal pour 15 cm codé sur 24 bit étant 0000&#39;0010&#39;1001&#39;1101&#39;1011&#39;1010 on peut voir que les 6 bits de poids fort ne nous intéresse pas. Nous prenons donc les 16 bit de poids fort à partir de du 7e.

Nous perdons certes en précisions, mais il s&#39;agit là de doute façon d&#39;une précision que nous ne pourrions pas atteindre dût à la mécanique du système. Avec cette réduction de précision nous avons donc une valeur de 2&#39;857 par [cm]. Cette valeur correspond en binaire à 0000&#39;1011&#39;0010&#39;1001.

Pour faire cette réduction, le signal est filtré par un bloc en FSM (Figure 9). Dans le cas général, nous prenons les bit 17 à 2. Si la valeur sur 24 bit était plus grande que notre course maximale, nous forçons la valeur maximal au signal de sortie de la position. Pour éviter un dépassement de bit lors du décomptage, nous envoyons un signal aux compteurs lorsque la valeur est à 0. Ce signal a pour effet de bloquer le décomptage comme vu précédemment dans la Figure 8.

![](RackMultipart20220123-4-1lfzf1b_html_b459bfaf219c0e22.png)

_Figure 9 Filtrage de 24 bit à 16 bit_

Cette façon de faire le comptage permet d&#39;avoir à tout moment la valeur absolu de la position une fois passé le premier reset. Ainsi, il sera possible d&#39;aller à la position 1 ou 2 depuis n&#39;importe quelle position atteinte au moment de faire un stop par exemple.

## 2.2« ButtonBlock »

Le bloc qui gère les boutons est très simple. Dès que l&#39;un des boutons est pressé, nous entrons dans un état « d&#39;attente » jusqu&#39;à recevoir un signal de libération qui indique la fin du process engagé par l&#39;actionnement du dit bouton (Figure 10). Le bouton 4 est une exception à ce système. Nous l&#39;utilisons comme bouton d&#39;arrêt, il est donc directement relié à la sortie (Figure 11). La sortie est un signal de 4 bit non signé avec dans l&#39;ordre du poids faible à fort : le bouton reset, pos1, pos2, button4.

| ![](RackMultipart20220123-4-1lfzf1b_html_c1a61d801c9a2cad.png)_Figure 10 Stand by des boutons_ | ![](RackMultipart20220123-4-1lfzf1b_html_347b86fee840719.png)_Figure 11 Bypass du button4_
 |
| --- | --- |

## 2.3« Driver »

Le bloc driver sert à piloter le moteur selon un sens et une puissance. (Figure 12)

Il est composé de 5 parties. :

- Le premier bloc (« counterEnableResetSync ») est un simple compteur qui permet de créer un signal qui monte jusqu&#39;à 255. Ce signal est reset par un autre bloc et sera utilisé pour la PWM.
- Un deuxième bloc « Counter\_Controller » (Figure 13) fait compter le compteur de la PWM et du reset lorsque ce dernier a atteint sa valeur maximale. Il donne l&#39;impulsion pour compter qu&#39;une clock sur trois pour ne pas faire une fréquence trop élevée pour le pont H du moteur.
- Le Bloc « PWM » fait une comparaison entre la puissance voulue et la valeur du compteur afin de créer un vrai signal PWM. Lorsque la PWM est inférieur ou égal à la puissance désirée, le signal de sortie s&#39;active, sinon il se désactive.
- Le dernier bloc « if0 » active le moteur si la puissance n&#39;est pas nul.
- La dernière partie simplement un démultiplexeur qui met le signal de PWM sur la bonne sortie de direction du moteur en fonction de l&#39;a direction souhaitée.

![](RackMultipart20220123-4-1lfzf1b_html_32ef88da65535bb4.png)

_Figure 12 Architecture « Driver »_

![](RackMultipart20220123-4-1lfzf1b_html_c8370db84bd51eef.png)

_Figure 13 Bloc « Counter\_Controller »_

## 2.4« Main »

![](RackMultipart20220123-4-1lfzf1b_html_741dc581c98e7e78.png)

_Figure 14 Architecture &quot;Main&quot;_

 Le bloc main est le cœur du système. C&#39;est lui qui gère la logique d&#39;accélération et de décélération en fonction de la position du curseur et la position choisie par les bouton.

Le diagramme ci-contre représente l&#39;intérieur de notre bloc (Figure 14).

Lors de l&#39;appuis du bouton Reset, si aucun mouvement n&#39;était en cours, le signal power est fixé à fond, la direction est définie à gauche. L&#39;arrêt est immédiat au capteur reed.

Lors de l&#39;appui d&#39;un des 2 boutons de positions, la position actuelle absolue est comparée avec la position désirée pour choisir la direction dans laquelle le curseur doit se déplacer.

Ensuite, une phase d&#39;accélération à lieu sur 1 cm jusqu&#39;à la vitesse maximal. 1 cm avant position désirée, la phase de décélération commence jusqu&#39;à l&#39;arrêt à la position exact.

L&#39;accélération et la décélération sont défini par 10 phases. La puissance minimum est à 25% afin de compenser le frottement. Le reste est séparé en 10 tranches. La position de déclanchement de la phase suivante est calculée sur une courbe x2 afin d&#39;avoir une accélération constante et non exponentielle

# 3Vérification et validation

## 3.1Simulation Position

Bla bla bla [DMS]

## 3.2Simulation Boutons

Bla bla bla [DMS]

## 3.3Simulation Main

Bla bla bla [DMS]

## 3.4Simulation Driver

Bla bla bla [DMS]

# 4Intégration

Pour « programmer » un FPGA, il faut passer par plusieurs étapes qui vont être détaillée dans cette partie. Le terme de programmation n&#39;est pas très correct pour parler d&#39;un FPGA. Il ne s&#39;agit pas de mettre du logiciel qui sera interpréter mais de décrire la configuration d&#39;un circuit électronique.

## 4.1HDL-Designer

La première étapes pour la réalisation du projet est de réaliser le design décrit plus haut sur HDL-Designer. Ce logiciel de Siemens permet de réaliser des circuits logique de toutes sorte. Nous avons fait notre design de façon très graphique à l&#39;aide de portes logique, de bascules, de machines d&#39;états, …

Mais tout ceci n&#39;est qu&#39;une interface plus pratique pour de la description de matériel « VHDL ». Tous ces blocs que nous avons mis et décrit dans le chapitre « Design général » ne sont en réalité fait que de VHDL. Il est donc aussi possible de décrire directement tout notre design de cette façon.

## 4.2Test Design

Le logiciel HDL-Designer permet aussi de réaliser des simulation comme expliqué au chapitre « Vérification et validation ». Pour ce faire, le logiciel doit compiler tout le design en VHDL pour l&#39;interpréter dans la simulation comme un circuit numérique. En complément vient aussi un fichier de vérification de matériel qui permet de stimuler et valider le design. Dans la Figure 15 on peut voir le bloc vert qui est l&#39;ensemble de notre design décrit au chapitre « Design général » et le bloc bleu qui est le fichier de vérification de matériel écrit lui aussi en VHDL. Une fois sur cette vue, il est possible de compiler pour passer au test.

![](RackMultipart20220123-4-1lfzf1b_html_f7d7b5d1bdb39ad6.png)

_Figure 15 Root view pour la simulation_

| ![](RackMultipart20220123-4-1lfzf1b_html_d8fda35112c65565.png) Pour préparer l&#39;intégration dans le FPGA, il faut non plus se mettre sur la Root View, mais sur « FPGA\_cursor » et lancé la « ModelSim Flow » comme dans la Figure 16.
_Figure 16 ModelSim Flow_ Plusieurs étapes vont se faire. En premier, le logiciel va générer tous les fichiers en VHDL à partir du design. Puis il va compiler afin de vérifier s&#39;il n&#39;y a pas d&#39;erreur, puis lancer la Simulation (ce qui n&#39;est pas utile dans le cas du chargement dans le FPGA). |
| --- |

## 4.3Préparation pour la synthèse

| _Figure 17 Prepare for Synthesis_ U ![](RackMultipart20220123-4-1lfzf1b_html_f800ba05b1f38798.png) ne fois notre design généré et compilé, il faut rester sur la même vue et faire « Prepare for Synthesis » comme dans la Figure 17. Le logiciel va d&#39;abord récupérer les fichiers généré précédemment, puis les assembler en un seul fichier VHDL par blocs qui contient des I/O. Ensuite, il va changer les librairies pour généraliser tous les composants. Comme nous souhaitons configurer un FPGA, il suffit d&#39;indiquer qu&#39;on utilise une porte AND et non tel modèle de composant qui réalise cette fonction par exemple. |
| --- |

## 4.4Synthèse

| ![](RackMultipart20220123-4-1lfzf1b_html_fe3e197b995dc807.png) La synthèse comporte de nombreuses étapes. La première se situe encore dans le logiciel « HDL-Designer »._Figure 18 Xilinx Project Navigator_En double cliquant sur « Xilinx Project Navigator » comme sur la Figure 18 le logiciel récupère le fichier généré par l&#39;étape précédente (« Préparation pour la synthèse ») pour l&#39;updater aux spécifications lié au logiciel Xilinx.Ensuite, il ouvre simplement le logiciel « ISE Project Navigator » |
| --- |
| U ![](RackMultipart20220123-4-1lfzf1b_html_c2f4760265fcc232.png) ne fois le logiciel « ISE Project Navigator » ouvert, on peut y trouver l&#39;architecture de notre projet. Tout en bas, on peut voir qu&#39;il y a un nouveau fichier : « eln\_cursor.ucf » Ce fichier UCF sert à faire la connexion entre les signaux I/O VHDL et les ports physique du FPGA. Selon la version de la board, il faut définir des ports différents en mettant en commentaire l&#39;autre version de la board tel que sur la Figure 19. ![](RackMultipart20220123-4-1lfzf1b_html_c5d0cdfefa31c80a.png)_Figure 19 Buttons on ucf file_ ![Shape6](RackMultipart20220123-4-1lfzf1b_html_da661aaeee7c68bc.gif)_Figure 20 Hierarchy in ISE_ Il faut le faire pour les boutons et les leds. Si l&#39;écran LCD n&#39;est pas utilisé, il faut aussi mettre toute la partie LCD en commentaire. |

| ![Shape7](RackMultipart20220123-4-1lfzf1b_html_918b971cb2ead494.gif)_Figure 21 Processes ISE_ ![](RackMultipart20220123-4-1lfzf1b_html_bef0a703fab8e221.png) Pour créer la configuration pour le FPGA il faut lancer « Configure Target Device » visible sur la Figure 21.
 Ce process va lancer le processus « Synthesis » qui va adapter notre design pour les spécificité de notre FPGA.
 Ensuite il lancera le processus d&#39;implémentation qui va traduire le projet généralisé par l&#39;étape « Préparation pour la synthèse » en bloc logique configurable (CLB), les mapper puis enfin choisir l&#39;emplacement et faire la description du routage.
 Enfin, le résultat de tout ceci donnera un fichier « .bit » qui est tout simplement le description de la configuration du FPGA. |
| --- |

## 4.5Configuration

À ce stade de l&#39;implémentation, il ne nous reste plus qu&#39;à charger notre configuration dans le FPGA.

Pour ceci, le logiciel iMPACT se lance automatiquement à la fin de la dernière phase. On peut le voir dans la Figure 22. Il faut cliquer sur Boundary Scan puis faire clique droite pour trouver le FPGA. On y voit à gauche la mémoire flash pour garder un programme après l&#39;extinction de la board. À droite, se trouve la mémoire interne du FPGA pour charger une configuration. Il faut donc faire clique droite sur la mémoire de droite et ajouter un nouveau fichier de configuration. Dans le dossier « ise » se trouve le fichier « .bit » généré par l&#39;étape précédente

Il ne reste plus qu&#39;à faire à nouveau clique droite sur la mémoire de droite et faire « Program ».

Cette fois c&#39;est bon, la configuration est dans le FPGA.

![](RackMultipart20220123-4-1lfzf1b_html_158fa0358fe016de.png)

_Figure 22 iMPACT_

# 5Conclusion

Bcp de bugs, on est nul en math, mais avec pas mal de bouts de scotch, ça marche.

[1](#sdfootnote1anc) Graphique provenant de la donnée (Figure 10)

**H ![](RackMultipart20220123-4-1lfzf1b_html_18dc70e5e66d71fd.png) ![](RackMultipart20220123-4-1lfzf1b_html_9602ce5372f34a00.png) ![](RackMultipart20220123-4-1lfzf1b_html_9703136ae1536a16.jpg) ![](RackMultipart20220123-4-1lfzf1b_html_5abf79063ad423ec.png) ES****-SO Valais-Wallis** • rue de l&#39;Industrie 23 • 1950 Sion

+41 58 606 85 16 • info.synd@hevs.ch • www.hevs.ch/synd