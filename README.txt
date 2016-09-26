PETIT Antoine : Rendu TP AspectJ

Exercice 1 : Aspect permettant la gestion des Singletons

	Pour créer cet Aspect, j'ai fait en sorte que le pointcut impact tout les classes intégrées dans un package singleton.
	Ainsi toutes les classes de ce package seront des Singletons.
	
	La gestion des Singletons se fait grâce à une Map liant les classes (clé) au objet instancié (valeur).
	
	Grâce à un around sur le constructeur, si on a déjà une instance de la classe dans la Map on ne fait pas le proceed et on renvoie la valeur présente dans le Map.

Exercice 2 : Aspect permettant l'affichage d'un diagramme d'échanges de messages

	Cet Aspect utilise un pointcut avant l'appel du main afin d'obtenir le nom de la classe du main pour la base de tout les autres appels.

	Ensuite on applique un around pour les constructeurs afin de récupérer les objets pour conserver leurs ordres.

	Enfin on applique un around autour des méthodes appelées pour afficher l'appel ainsi que le retour des méthodes.

	L'affichage est géré grâce à un stringBuilder qui construit l'ensemble du diagrammme et qui permet de faire l'affichage une fois le main terminé.
