# README
# THP - Week 4 - Project 5 - Le Back-end de Airbnb
# Francois THIOUNN

# Notes :

Models crées: 
	- City => has 1-N with Listing
	- User => has 2 class names : 	- admin => 1-N with Listing
									- guest => N-N with Reservation donc 1-N with jointable (UserReservation)
	- Listing => belongs to admin and city, has 1-N with reservation
	- Reservation => has 1-N with listings, N-N with Guest donc 1-N with jointable (UserReservation)
	- UserReservation => jointable of N-N between User(class_name :guest) and Reservation
	

Description du projet selon THP ci dessous :

Projet : Le Back-end de Airbnb
  
# 1.Introduction
C'est parti ! Voici enfin un projet concret où tu vas réaliser une vraie base de données robuste. Pour l'occasion, nous allons te demander de refaire la BDD et les model d'une application bien connue du monde des startups : Airbnb. Oui, aujourd'hui, après même pas 4 semaines d'apprentissage au code tu vas refaire le back-end de Airbnb.

Pour le projet du jour, nous allons te donner simplement le pitch de l'application. À partir de ça, tu feras le design de la base de données tout seul comme un grand, puis tu rendras tes models robustes en mettant des validations.

Nous sommes très fiers de te proposer un projet aussi concret aussi rapidement et nous espérons que tu vas prendre autant de plaisir à le faire que nous en le rédigeant.

# 2. Le projet
2.1. Présentation
Nous sommes en 2007, tu habites dans une grande ville et galère à payer ton loyer. Tu remarques qu'il y a une super conférence sur Internet Explorer 6 pas loin de chez toi. Tu es passionné de web donc pour rien au monde tu ne manquerais cet événement. Cependant, tu constates avec ta coloc que tous les hôtels du coin sont pleins. Et là vous vous dites "on devrait faire un site où les particuliers peuvent proposer une chambre dans leur piaule moyennant un peu d'argent."
L'idée est bonne, mais vous êtes pas les premiers à y penser. Pour la transformer en idée du siècle, il faut l'implémenter comme un chef. Et le point de départ, avant de coder les views, c'est de modéliser la base de données. Hop, une feuille, un stylo et des surligneurs !

2.2. L'application
Ci-dessous tu trouveras quelques parcours utilisateurs sur l'application. Ils te renseigneront sur les models à définir, leurs attributs et les relations entre eux.

Un utilisateur va arriver sur la page d'accueil du site qui présente les villes dans lesquelles le site opère. Pas de notion de pays dans cette première version qui sera consacrée uniquement à la France.
Quand tu vas sur la page d'une ville, tu pourras voir les différents logements que cette ville propose.
Pour chaque logement, tu peux avoir des informations précises sur :
Le nombre de lits disponibles
Le prix par nuit
Note : pour cette première version, un logement sera forcément loué en entier : il ne peut accepter qu'une seule réservation par nuit. Si jamais ta startup cartonne, tu développeras une fonctionnalité qui permettra de louer un logement à plusieurs personnes différentes par nuit, en fonction du nombre de lits pris.
Une description
Est-ce qu'il a le wifi ?
Une personne peut effectuer une réservation facilement sur le site, en payant le coût de la réservation. Une réservation a une date de début, une date de fin, et une durée.
Dans cette version du site, nous allons faire comme si toutes les réservations étaient instantanées, c’est-à-dire qu'une réservation sera automatiquement validée quand elle sera payée.
Il est bien entendu impossible d'effectuer une réservation sur un logement si ce dernier a déjà une réservation sur tout ou une partie de la période qu'on cherche à réserver.
Un utilisateur doit renseigner ses informations basiques : une adresse e-mail, un numéro de téléphone, une description de profil.
Nous n'allons pas gérer la notion de mot de passe pour le moment.
Un logement est administré par un utilisateur. Dès qu'une réservation est passée dessus, les utilisateurs deviennent des invités.
Un logement a un petit mot d'accueil réservé aux invités. C'est généralement un texte écrit pour donner quelques détails sur la réservation.
On ne va pas encore coder la fonctionnalité de messages privés entre utilisateurs.
Avec ces informations, tu devrais être capable de modéliser la base de données de l'application. En avant !
Une fois ce premier jet de fait, nous allons te proposer notre version de la base de données afin de te guider dans les migrations et créations de models. N'hésite pas à comparer notre version et celle à laquelle tu étais arrivé sur papier/tableau/ERD.

⚠️ Il est important que tu prennes au sérieux la partie modélisation sur papier : si tu ne te casses pas un peu la tête dessus, tu ne progresseras pas. Pour ton projet final THP (et encore plus pour ta vie future de dev) il n'y aura pas de correction à suivre. Et si tu ne t’es jamais entraîné avant, tu vas être à la ramasse.

2.3. La base de données en détails
Voici notre version de la BDD de cette V0 d'AirBnb. Cela ne correspond en rien à une correction, car il y a plusieurs façons d'arriver à un même résultat, sans forcément qu'une soit supérieure à l'autre. Mais cela va te donner une idée et surtout nous permettre de te guider.

⚠️ Avant de coder, lis toute la partie 2.3. Tu passeras à la mise en œuvre en 2.4.

Personnellement, j'aurais vu 4 models :

un model User, qui représente nos utilisateurs
un model Listing, qui représente les logements disponibles (Accommodation aurait été pas mal non plus comme nom)
un model City, qui représente les villes desservies par l'application
un model Reservation, qui représente les séjours
2.3.1. Model User
Pour les utilisateurs, c'est plutôt simple. Ils ont les attributs de base :

email : un string. Sa présence est obligatoire, il doit être unique et répondre au regex d'un email
phone_number : un string (ce n'est pas un integer) qui doit répondre à ce regex : format: { with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/, message: "please enter a valid french number" }. On peut rendre le numéro de téléphone obligatoire uniquement pour la création d'une réservation, mais en termes de code c'est pas ultra pratique, donc nous allons rendre le numéro de téléphone obligatoire tout court.
description : un text
Un utilisateur peut avoir plusieurs réservations: il devient alors un "invité" (guest).
Un utilisateur peut être administrateur de plusieurs listings.

2.3.2. Model City
Une ville a des attributs très simples :

Un name, qui est le nom de la ville. Sa présence est obligatoire.
Un zip_code qui est le code postal. Ce sera un string au format suivant : format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "please enter a valid french zip code" }. Sa présence est obligatoire et il est unique.
Une ville peut avoir plusieurs listings.

2.3.3. Model Listing
Voici les attributs du listing :

Un available_beds, qui est un integer. Il doit être strictement positif, et est obligatoire
Un price qui est un integer. Le prix correspondra au nombre d'euros qu'il faudra débourser pour rester une nuit. Dans cette application révolutionnaire, nous ne proposons que des prix entiers (pas de centimes). Il doit être strictement positif et est obligatoire.
Une description qui est un text. Elle doit faire au moins 140 caractères de long et est obligatoire.
Un boolean au nom de has_wifi qui permet de vérifier que le listing ait bien le wifi.
Un welcome_message qui est un text. Sa présence est obligatoire.
Un listing a un administrateur (qui est un utilisateur).
Un listing a plusieurs réservations.
Un listing appartient à une ville.

2.3.4. Model Reservation
Voici les attributs de la réservation :

Une start_date qui est un datetime
Une end_date qui est un datetime. Il est impossible que la end_date soit avant la start_date (pour ceci, j'ai trouvé ce thread sur Stack overflow 😉)
Pour connaître la durée d'une réservation, ce sera une méthode d'instance qui fait la différence entre la end_date et la start_date. Je te conseille de t'aider de cet article sur Stack Overflow

Une réservation est associée à un guest (qui est un utilisateur) et un listing.

Enfin, il te faudra faire en sorte qu'il soit impossible de faire une réservation sur un événement si ce dernier est déjà pris. Pour ceci voici quelques astuces :

Il faut mettre en place une validation custom bien entendu.
Il faudra que tu passes sur chaque réservation d'un listing et que tu vérifies que aucune ne tombe au moment de la réservation que tu veux valider.
Faire reservation.end_date < other_reservation.start_date && blabla n'est pas ultra lisible. Rails aime bien les méthodes DRY comme cette méthode d'instance pour le model Listing :
def overlaping_reservation?(datetime)
  # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée
end
2.4. À vos claviers !
Tu vas pouvoir te lancer dans la création des models et la rédaction des migrations. Voici quelques conseils pour que tu réussisses le projet :

Procède model par model et branche bien les associations.
N'hésite pas à abuser des migrations, à drop ta base de données si tu foires tout, à faire des rollbacks. Bref joue avec tout cela
Vérifie tout en console avant de considérer qu'un model et ses associations sont ok.
La méthode de validation overlaping_reservation? est de loin la partie la plus complexe. Garde la pour la fin.
📚 INSTANT CULTURE GÉ
Apprendre à bien maîtriser la création de model sur Rails c'est la base d'un bon back-end. Et comme on ne veut pas t'assommer d'informations, on a sciemment fait l'impasse sur un gros morceaux : l'écriture de tests pour tes models. Comme c'est une part importante de la vie d'un développeur professionnel, on va t'en parler rapidement.

C'est dans le backend qu'on peut voir la puissance et la pertinence des tests. Par exemple la méthode overlaping_reservation? va être très souvent utilisée, et tu ne dois pas te tromper en la codant. Si, par un bug quelconque, un utilisateur réussi à créer une réservation en même temps qu'une autre sur le même logement, crois-moi que tu aurais eu bien l'air d'un con en appelant ton client pour lui dire qu'en fait ses vacances de rêve en Bretagne tombent à l'eau car "il y a eu un bug et le logement est déjà loué à cette date" 😅.

Voici tout l'intérêt qu'auraient des tests en Rails : on pourrait vérifier à chaque mise à jour du code que la méthode overlaping_reservation? n'est pas cassée. Et bien évidemment, ça ne sera pas la seule méthode dans ce cas : dans l'idéal, il faudra, à chaque méthodes de model, des tests pour éviter les mauvaises surprises.

Au final, un backend ET robuste ET testé c'est l'assurance-vie d'une application web et un vrai investissement pour éviter tout tracas. Par exemple si un petit développeur stagiaire venait à changer la petite méthode overlaping_reservation? de rien du tout et qu'elle ne fonctionne plus (Bouh le stagiaire 👺!).

Pense bien sûr à faire un petit seed qui va :

Détruire ta base actuelle
Créer 20 utilisateurs
Créer 10 villes
Créer 50 listings
Pour chaque listing
Créer 5 réservations dans le passé
Créer 5 réservations dans le futur
Puisque c'est toi, permets-moi de te proposer un repo qui contient les bases de l'application (oh yeah !). Voici le dossier

2.5. Et après ?
Maintenant que tu as fait une base de données solide, il te sera très simple d'ajouter les views et les controllers qui feront tourner le tout. On appellera les bonnes méthodes dans des controllers, elles redirigeront vers les bonnes vues et les clients seront séduits !

La semaine prochaine, nous verrons comment faire ce branchement pour que tu puisses afficher en HTML le contenu de ta BDD, par exemple :

La page d'accueil affichera l'index de toutes les villes disponibles (City.all)
Tu pourras cliquer sur la page d'une ville pour voir les logements dans la ville (selected_city.listings)
Sur la page d'un logement, tu verras les détails du logement (selected_listing.description).
Tu pourras payer et créer des réservations (Reservation.create)
Une fois la réservation faite, l'utilisateur sera redirigé vers la page de la réservation, dans laquelle il verra le fameux mot de bienvenue
etc.
Puis, lors de la 3ème semaine de Rails, nous verrons des fonctionnalités avancées comme le paiement, ou l'ajout de photos des logements, etc.

# 3. Rendu attendu
Un dossier qui répond au cahier des charges cité ci-haut.